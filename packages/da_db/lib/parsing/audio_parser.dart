import 'dart:async';
import 'dart:convert';
import 'dart:isolate';

import 'package:archive/archive_io.dart';
import 'package:da_db/data/dictionary_types.dart';
import 'package:da_db/database/da_db.dart';
import 'package:da_db/parsing/audio/mergers/audio_bank_merger.dart';
import 'package:da_db/parsing/staging_db/staging_db.dart';
import 'package:da_db/parsing/util/db_optimization.dart';
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
  required DaKanjiDB db,
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

  final db = DaKanjiDB(
    executor: await params.dbConnection.connect(),
    inMemory: params.inMemory,
    languageProcessor: LanguageProcessor.fromJsonString(params.languageProcessorJson),
  );

  InputFileStream? zipStream;
  Directory? tempDir;
  StagingDatabase? stagingDb;

  try {
    sendPort.send("Scanning audio dictionary structure...");
    await db.languageProcessor.init();
    zipStream = InputFileStream(params.dataSourcePath);
    final archiveHeaders = ZipDecoder().decodeStream(zipStream);

    // 1. Setup Index (Reusing the Yomitan pattern)
    final int indexId = await _initializeAudioIndex(archiveHeaders, db, params.isDefaultDictionary);

    // 2. Prepare Staging Environment
    tempDir = await Directory.systemTemp.createTemp('dakanji_audio_');
    final String stagingDbPath = p.join(tempDir.path, 'audio_staging.db');
    stagingDb = StagingDatabase(NativeDatabase(File(stagingDbPath)));

    // 3. Stage Metadata
    await _runAudioStaging(
      archive: archiveHeaders,
      stagingDb: stagingDb,
      db: db,
      sendPort: sendPort,
    );

    // 4. SQL-based Merge
    await _mergeAudioStagingData(
      db: db,
      stagingDbPath: stagingDbPath,
      indexId: indexId,
      sendPort: sendPort,
    );

    // 5. Finalize
    sendPort.send("Optimizing database...");
    await optimizeDbAfterImport(db);

  } catch (e, stack) {
    sendPort.send("Error: $e\n$stack");
  } finally {
    zipStream?.close();
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

Future<int> _initializeAudioIndex(Archive archive, DaKanjiDB db, bool isDefault) async {
  final indexHeader = archive.findFile("yomitan_index.json");
  if (indexHeader == null) {
    throw Exception("Invalid Audio Dict: No yomitan_index.json found.");
  }

  final indexJson = utf8.decode(indexHeader.rawContent!.getStream(decompress: true).toUint8List());
  return await parseAndInsertIndex(indexJson, db, DictionaryTypes.audio, isDefault);
}

Future<void> _runAudioStaging({
  required Archive archive,
  required StagingDatabase stagingDb,
  required DaKanjiDB db,
  required SendPort sendPort,
}) async {
  sendPort.send("Parsing metadata to staging database...");

  final contentDataSources = archive.files
      .where((f) => p.basename(f.name) != "yomitan_index.json" && f.isFile)
      .map((f) => (filePath: f.name, fileContent: f.content))
      .toList();

  if (contentDataSources.isEmpty) return;

  // Determine format via helper
  final indexJsonEntry = contentDataSources.where((f) => p.basename(f.filePath) == "index.json").firstOrNull;
  final entriesJsonEntry = contentDataSources.where((f) => p.basename(f.filePath) == "entries.json").firstOrNull;

  if (indexJsonEntry != null) {
    final jsonStr = utf8.decode(indexJsonEntry.fileContent);
    final audioFiles = contentDataSources.where((f) => f != indexJsonEntry);
    await AudioIndexJsonParser().parse(audioFiles, jsonStr, stagingDb, db, (msg) => sendPort.send(msg));
  } 
  else if (entriesJsonEntry != null) {
    final jsonStr = utf8.decode(entriesJsonEntry.fileContent);
    final audioFiles = contentDataSources.where((f) => f != entriesJsonEntry);
    await AudioEntriesJsonParser().parse(audioFiles, jsonStr, stagingDb, db, (msg) => sendPort.send(msg));
  } 
  else {
    await AudioFileNameParser().parse(contentDataSources, stagingDb, db, (msg) => sendPort.send(msg));
  }
}

Future<void> _mergeAudioStagingData({
  required DaKanjiDB db,
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