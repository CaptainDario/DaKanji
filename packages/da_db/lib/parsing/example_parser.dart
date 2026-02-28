import 'dart:async';
import 'dart:convert';
import 'dart:isolate';
import 'dart:math';
import 'dart:typed_data';

import 'package:archive/archive_io.dart';
import 'package:da_db/data/dictionary_types.dart';
import 'package:da_db/data/supported_audio_formats.dart';
import 'package:da_db/database/da_db.dart';
import 'package:da_db/parsing/example/mergers/example_staging_db_merging.dart';
import 'package:da_db/parsing/example/workers/example_worker_entry.dart';
import 'package:da_db/parsing/util/db_optimization.dart';
import 'package:da_db/parsing/util/parsing_util.dart';
import 'package:da_db/parsing/util/staging_worker_pool.dart';
import 'package:da_db/parsing/yomitan/in_memory_cache/index/index_parser.dart';
import 'package:da_db/parsing/yomitan/in_memory_cache/media/media_importer.dart';
import 'package:drift/isolate.dart';
import 'package:language_processing/language_processing.dart';
import 'package:path/path.dart' as p;
import 'package:universal_io/io.dart';



const String indexFileNamingScheme = "index.json";
const List<String> parallelHandledFiles = [
  "example_bank",
  "tag_bank",
];

Future<Stream<String>> parseExampleDataSource({
  String? dataSourcePath,
  Uint8List? archiveBytes,
  required bool isDefaultDictionary,
  required DaDb db,
  Directory? tempDir,
}) async {
  assert(dataSourcePath != null, "Parallel import requires a file path");
  tempDir ??= Directory.systemTemp;

  final StreamController<String> controller = StreamController();
  final connection = await db.attachedDatabase.serializableConnection();
  final lpJson = db.languageProcessor.toJsonString();

  ReceivePort receivePort = ReceivePort();
  receivePort.listen((message) {
    if (message is String) controller.add(message);
    else if (message == null) {
      receivePort.close();
      controller.close();
    }
    else controller.addError(message);
  });

  await Isolate.spawn(_orchestratorEntry, (
    dataSourcePath: dataSourcePath!,
    dbConnection: connection,
    languageProcessorJson: lpJson,
    mainIsolateSendPort: receivePort.sendPort,
    inMemory: db.inMemory,
    isDefaultDictionary: isDefaultDictionary,
    tempDir: tempDir
  ));

  return controller.stream;
}

Future<void> _orchestratorEntry(({
  String dataSourcePath,
  DriftIsolate dbConnection,
  String languageProcessorJson,
  SendPort mainIsolateSendPort,
  bool inMemory,
  bool isDefaultDictionary,
  Directory tempDir,
}) params) async {
  final sendPort = params.mainIsolateSendPort;

  final db = DaDb(
    executor: await params.dbConnection.connect(),
    inMemory: params.inMemory,
    languageProcessor: LanguageProcessor.fromJsonString(params.languageProcessorJson)
  );

  String? indexJson;
  final List<String> workerDbPaths = [];
  try {
    sendPort.send("Scanning example dictionary structure...");
    final allFiles = daDbDataSourceIterator(
      archivePath: params.dataSourcePath, fileOrder: [indexFileNamingScheme]
    ).toList();
    
    int? indexId;
    final parallelQueue = <String>[];
    final mediaQueue = <ArchiveFile>[];

    for (final file in allFiles) {
      if (!file.isFile) continue;

      final name = p.basename(file.name);
      if (name == indexFileNamingScheme) {
        indexJson = utf8.decode(file.content);
        continue;
      }
      
      if (parallelHandledFiles.any((s) => name.contains(s))) {
        parallelQueue.add(file.name);
      }
      else {
        if (SupportedAudioFormats.values.any((ext) => name.endsWith(".${ext.name}"))) 
          mediaQueue.add(file);
      }
    }

    parallelQueue.sort((a, b) => a.compareTo(b));
    final int numWorkers = min(max(1, parallelQueue.length), 4);
    workerDbPaths.addAll(await StagingWorkerPool.runGreedyParallelStaging(
      numWorkers: numWorkers,
      dataSourcePath: params.dataSourcePath,
      languageProcessorJson: params.languageProcessorJson,
      files: parallelQueue,
      tempDir: params.tempDir,
      workerEntryPoint: exampleWorkerEntry,
      onStatus: (msg) => sendPort.send(msg),
    ));

    List<String> workerAliases = [];
    for (int i = 0; i < workerDbPaths.length; i++) {
      workerAliases.add("worker_$i");
      await db.customStatement("ATTACH DATABASE '${workerDbPaths[i]}' AS ${workerAliases.last}");
    }

    await optimizeTargetDbForMerge(db);
    await db.transaction(() async {
      indexId = await parseAndInsertIndex(indexJson!, db, DictionaryTypes.yomitan, params.isDefaultDictionary);
      if (indexId == null) throw Exception("No valid index.json found.");

      await _mergeStagingData(
        db: db, workerAliases: workerAliases, indexId: indexId!, sendPort: sendPort,);

      await _importMediaFiles(db, mediaQueue, indexId!, sendPort);
    });

    sendPort.send("Optimizing database...");
    await optimizeDbAfterImport(db);

  }
  catch (e, stack) {
    print("Importing error: $e\n$stack");
    sendPort.send(e.toString());
  }
  finally {
    await restoreTargetDbAfterMerge(db);
    for (int i = 0; i < workerDbPaths.length; i++) {
      await db.customStatement('DETACH DATABASE worker_$i');
      if(File(workerDbPaths[i]).existsSync()) File(workerDbPaths[i]).deleteSync();
    }
    db.close();
    sendPort.send(null);
  }
}

Future<void> _mergeStagingData({
  required DaDb db,
  required List<String> workerAliases,
  required int indexId,
  required SendPort sendPort,
}) async {
  if (workerAliases.isEmpty) return;

  sendPort.send("Parsing complete. Merging data...");
  
  for (int i = 0; i < workerAliases.length; i++) {
    sendPort.send("Merging ${i + 1}/${workerAliases.length}...");
    await mergeExampleStagingDb(
      db: db, workerAlias: workerAliases[i], indexId: indexId,
    );
  }
}

Future<void> _importMediaFiles(
  DaDb db, 
  List<ArchiveFile> mediaFiles, 
  int indexId,
  SendPort sendPort
) async {
  if (mediaFiles.isEmpty) return;
   
  // Map once outside the loop for performance
  final allMediaRecords = mediaFiles.map((f) => (
    file: f, indexId: indexId, insertId: null as int?
  )).toList();

  const batchSize = 200;
  for (var i = 0; i < allMediaRecords.length; i += batchSize) {
    final end = min(i + batchSize, allMediaRecords.length);
    final batch = allMediaRecords.sublist(i, end);
    await importMediaFiles(db, batch);
  }

}