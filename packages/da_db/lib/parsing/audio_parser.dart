import 'dart:async';
import 'dart:convert';
import 'dart:isolate';

import 'package:collection/collection.dart';
import 'package:da_db/data/dictionary_types.dart';
import 'package:da_db/database/da_db.dart';
import 'package:da_db/parsing/audio/mergers/audio_staging_db_merging.dart';
import 'package:da_db/parsing/audio/workers/audio_worker_entry.dart';
import 'package:da_db/parsing/util/db_optimization.dart';
import 'package:da_db/parsing/util/parsing_util.dart';
import 'package:da_db/parsing/util/staging_worker_pool.dart';
import 'package:da_db/parsing/yomitan/in_memory_cache/index/index_parser.dart';
import 'package:drift/isolate.dart';
import 'package:language_processing/language_processing.dart';
import 'package:path/path.dart' as p;
import 'package:universal_io/io.dart';


/// Orchestrates the parsing, staging, and merging of Audio Dictionaries.
/// 
/// Operates on a dedicated Isolate using the `StagingWorkerPool` engine to 
/// guarantee the main Flutter UI thread remains completely responsive while 
/// massive binary blobs are moved through the file system.
Future<Stream<String>> parseAudioDataSource({
  required String dataSourcePath,
  required bool isDefaultDictionary,
  required DaDb db,
}) async {
  final controller = StreamController<String>();
  final connection = await db.attachedDatabase.serializableConnection();
  final lpJson = db.languageProcessor.toJsonString();

  final receivePort = ReceivePort();
  receivePort.listen((message) {
    if (message is String) controller.add(message);
    else if (message == null) {
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
    inMemory: db.inMemory,
    isDefaultDictionary: isDefaultDictionary,
  ));

  return controller.stream;
}

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

  try {
    sendPort.send("Scanning audio dictionary structure...");

    final allFiles = daDbDataSourceIterator(
      archivePath: params.dataSourcePath, 
      fileOrder: ["yomitan_index.json"]
    ).toList(); 

    // --- 1. Parse Primary Dictionary Index ---
    final indexFile = allFiles.firstWhereOrNull((f) => f.name == "yomitan_index.json");
    if (indexFile == null) throw Exception("No yomitan_index.json found.");
    
    final int indexId = await parseAndInsertIndex(
      utf8.decode(indexFile.readBytes()!), db, DictionaryTypes.audio, params.isDefaultDictionary
    );

    // --- 2. Build the File Queue ---
    final contentFiles = allFiles.where((f) => f.name != "yomitan_index.json").map((f) => f.name).toList();
    
    // Sort the queue so metadata files (index.json / entries.json) 
    // are parsed FIRST.
    contentFiles.sort((a, b) {
      final baseA = p.basename(a);
      final baseB = p.basename(b);
      if (baseA == 'index.json' || baseA == 'entries.json') return -1;
      if (baseB == 'index.json' || baseB == 'entries.json') return 1;
      return a.compareTo(b);
    });

    tempDir = await Directory.systemTemp.createTemp('da_db_audio_pool_');

    // --- 3. Stage the Data ---
    final List<String> workerDbPaths = await StagingWorkerPool.runGreedyParallelStaging(
      numWorkers: 1, 
      dataSourcePath: params.dataSourcePath,
      languageProcessorJson: params.languageProcessorJson,
      files: contentFiles,
      tempDir: tempDir,
      workerEntryPoint: audioWorkerEntry,
      onStatus: (msg) => sendPort.send(msg),
    );

    // --- 4. Merge into Main Database ---
    if (workerDbPaths.isNotEmpty && await File(workerDbPaths.first).exists()) {
      sendPort.send("Merging audio staging database...");
      await mergeAudioStagingDb(
        db: db,
        workerDbPath: workerDbPaths.first,
        indexId: indexId,
      );
      await File(workerDbPaths.first).delete();
    }

    sendPort.send("Optimizing database...");
    await optimizeDbAfterImport(db);

  }
  catch (e, stack) {
    sendPort.send("Error: $e\n$stack");
  } 
  finally {
    if (tempDir != null && await tempDir.exists()) {
      await tempDir.delete(recursive: true);
    }
    await db.close();
    sendPort.send(null);
  }
}