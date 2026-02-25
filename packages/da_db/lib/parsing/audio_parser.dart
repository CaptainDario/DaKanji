import 'dart:async';
import 'dart:convert';
import 'dart:isolate';

import 'package:archive/archive_io.dart';
import 'package:collection/collection.dart';
import 'package:da_db/data/dictionary_types.dart';
import 'package:da_db/database/da_db.dart';
import 'package:da_db/parsing/audio/mergers/audio_bank_merger.dart';
import 'package:da_db/parsing/staging_db/staging_db.dart';
import 'package:da_db/parsing/util/db_optimization.dart';
import 'package:da_db/parsing/util/parsing_util.dart';
import 'package:da_db/parsing/yomitan/in_memory_cache/index/index_parser.dart';
import 'package:drift/isolate.dart';
import 'package:drift/native.dart';
import 'package:language_processing/language_processing.dart';
import 'package:path/path.dart' as p;
import 'package:universal_io/io.dart';

import 'audio/parsers/audio_entries_json_parser.dart';
import 'audio/parsers/audio_file_name_parser.dart';
import 'audio/parsers/audio_index_json_parser.dart';

/// Orchestrates the audio data source import following the Yomitan staging pattern.
Future<Stream<String>> parseAudioDataSource({
  required String dataSourcePath,
  required bool isDefaultDictionary,
  required DaDb db,
}) async {
  final controller = StreamController<String>();
  final connection = await db.attachedDatabase.serializableConnection();
  final lpJson = db.languageProcessor.toJsonString();
  final inMemory = db.inMemory;

  final receivePort = ReceivePort();
  receivePort.listen((message) {
    if (message is String) {
      controller.add(message);
    } else if (message == null) {
      receivePort.close();
      controller.close();
    } else {
      controller.addError(message);
    }
  });

  await Isolate.spawn(_audioOrchestratorEntry, (
    dataSourcePath: dataSourcePath,
    dbConnection: connection,
    languageProcessorJson: lpJson,
    mainIsolateSendPort: receivePort.sendPort,
    inMemory: inMemory,
    isDefaultDictionary: isDefaultDictionary,
  ));

  return controller.stream;
}

/// Worker entry point for parsing Audio Dictionary Data Sources.
Future<void> _audioOrchestratorEntry(({
  String dataSourcePath,
  DriftIsolate dbConnection,
  String languageProcessorJson,
  SendPort mainIsolateSendPort,
  bool inMemory,
  bool isDefaultDictionary
}) params) async {
  final sendPort = params.mainIsolateSendPort;

  final db = DaDb(
    executor: await params.dbConnection.connect(),
    inMemory: params.inMemory,
    languageProcessor: LanguageProcessor.fromJsonString(params.languageProcessorJson),
  );

  Directory? tempDir;
  StagingDatabase? stagingDb;

  try {
    sendPort.send("Scanning audio dictionary structure...");
    await db.languageProcessor.init();

    // 1. Get all file handles lazily
    final allFiles = daDbDataSourceIterator(
      archivePath: params.dataSourcePath, 
      fileOrder: ["yomitan_index.json"]
    ).toList(); // Safe: only stores ArchiveFile pointers, not content

    // 2. Setup Index
    final indexFile = allFiles.firstWhereOrNull((f) => f.name == "yomitan_index.json");
    if (indexFile == null) throw Exception("No yomitan_index.json found.");
    
    final int indexId = await parseAndInsertIndex(
      utf8.decode(indexFile.readBytes()!), 
      db, 
      DictionaryTypes.audio, 
      params.isDefaultDictionary
    );

    // 3. Prepare Staging Environment
    tempDir = await Directory.systemTemp.createTemp('da_db_audio_');
    final String stagingDbPath = p.join(tempDir.path, 'audio_staging.db');
    stagingDb = StagingDatabase(NativeDatabase(File(stagingDbPath)));

    // 4. Stage Metadata
    // Filter out the index file and pass the rest to the staging logic
    final contentFiles = allFiles.where((f) => f.name != "yomitan_index.json").toList();
    
    await _runAudioStaging(
      contentFiles: contentFiles,
      stagingDb: stagingDb,
      db: db,
      sendPort: sendPort,
    );

    // 5. SQL-based Merge
    await _mergeAudioStagingData(
      db: db,
      stagingDbPath: stagingDbPath,
      indexId: indexId,
      sendPort: sendPort,
    );

    sendPort.send("Optimizing database...");
    await optimizeDbAfterImport(db);

  } catch (e, stack) {
    sendPort.send("Error: $e\n$stack");
  } finally {
    await stagingDb?.close();
    if (tempDir != null && await tempDir.exists()) {
      await tempDir.delete(recursive: true);
    }
    db.languageProcessor.close();
    await db.close();
    sendPort.send(null);
  }
}

// --- Helper Functions ---

Future<void> _runAudioStaging({
  required List<ArchiveFile> contentFiles,
  required StagingDatabase stagingDb,
  required DaDb db,
  required SendPort sendPort,
}) async {
  sendPort.send("Parsing metadata to staging database...");

  if (contentFiles.isEmpty) return;

  // Detect format using handles (No bytes loaded yet!)
  final indexJsonEntry = contentFiles.firstWhereOrNull((f) => p.basename(f.name) == "index.json");
  final entriesJsonEntry = contentFiles.firstWhereOrNull((f) => p.basename(f.name) == "entries.json");

  if (indexJsonEntry != null) {
    final jsonStr = utf8.decode(indexJsonEntry.readBytes()!);
    final audioFiles = contentFiles.where((f) => f != indexJsonEntry).toList();
    await AudioIndexJsonParser().parse(audioFiles, jsonStr, stagingDb, db, (msg) => sendPort.send(msg));
  } 
  else if (entriesJsonEntry != null) {
    final jsonStr = utf8.decode(entriesJsonEntry.readBytes()!);
    final audioFiles = contentFiles.where((f) => f != entriesJsonEntry).toList();
    await AudioEntriesJsonParser().parse(audioFiles, jsonStr, stagingDb, db, (msg) => sendPort.send(msg));
  } 
  else {
    await AudioFileNameParser().parse(contentFiles, stagingDb, db, (msg) => sendPort.send(msg));
  }
}

Future<void> _mergeAudioStagingData({
  required DaDb db,
  required String stagingDbPath,
  required int indexId,
  required SendPort sendPort,
}) async {
  sendPort.send("Merging audio data into main database...");
  
  await db.customStatement("ATTACH DATABASE '$stagingDbPath' AS staging_worker");
  
  try {
    await AudioBankMerger().merge(
      targetDb: db,
      workerAlias: 'staging_worker',
      indexId: indexId,
    );
  }
  finally {
    await db.customStatement("DETACH DATABASE staging_worker");
  }
}