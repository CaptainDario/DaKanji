import 'dart:async';
import 'dart:convert';
import 'dart:isolate';
import 'dart:math';
import 'dart:typed_data';

import 'package:archive/archive_io.dart';
import 'package:da_db/data/dictionary_types.dart';
import 'package:da_db/database/da_db.dart';
import 'package:da_db/parsing/util/db_optimization.dart';
import 'package:da_db/parsing/util/parsing_util.dart';
import 'package:da_db/parsing/util/staging_worker_pool.dart';
import 'package:da_db/parsing/yomitan/in_memory_cache/index/index_parser.dart';
import 'package:da_db/parsing/yomitan/in_memory_cache/media/media_importer.dart';
import 'package:da_db/parsing/yomitan/staging_db/mergers/staging_db_merging.dart';
import 'package:da_db/parsing/yomitan/staging_db/workers/worker_entry.dart';
import 'package:drift/isolate.dart';
import 'package:language_processing/language_processing.dart';
import 'package:path/path.dart' as p;
import 'package:universal_io/io.dart';

const String indexFileNamingScheme = "index.json";
const List<String> parallelHandledFiles = [
  "term_bank",
  "kanji_bank",
  "tag_bank", 
  "term_meta_bank",
  "kanji_meta_bank"
];

Future<Stream<String>> parseDictionaryDataSource({
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

  InputFileStream? zipStream;

  try {
    // --- STEP 1: SCAN ---
    sendPort.send("Scanning dictionary structure...");
    final allFiles = daDbDataSourceIterator(
      archivePath: params.dataSourcePath, 
      fileOrder: [indexFileNamingScheme]
    ).toList();
    
    int? indexId;
    final parallelQueue = <String>[];
    final mediaQueue = <({ArchiveFile file, int indexId, int? insertId})>[];

    for (final file in allFiles) {
      final name = p.basename(file.name);
      if (name == indexFileNamingScheme) {
        final indexJson = utf8.decode(file.rawContent!.getStream(decompress: true).toUint8List());
        indexId = await parseAndInsertIndex(indexJson, db, DictionaryTypes.yomitan, params.isDefaultDictionary);
        continue;
      }
      if (!file.isFile) continue;
      if (parallelHandledFiles.any((s) => name.contains(s))) {
        parallelQueue.add(file.name);
      }
      else {
        if (name.endsWith('.json')) print("DEBUG: Treating as media: $name");
        mediaQueue.add((
          file: file,
          indexId: 0,
          insertId: null
        ));
        file.closeSync();
      }
    }

    // --- STEP 2: STAGING (Using Shared Pool) ---
    if (indexId == null) throw Exception("No index.json found.");
    parallelQueue.sort((a, b) => a.compareTo(b));

    // Calculate number of workers based on Yomitan's specific logic
    final int numWorkers = min(
      max(1, parallelQueue.where((f) => f.contains(RegExp("term_bank|term_meta_bank"))).length),
      4
    );

    // Call the shared pool, passing the Yomitan worker entry point
    final List<String> workerDbPaths = await StagingWorkerPool.runGreedyParallelStaging(
      numWorkers: numWorkers,
      dataSourcePath: params.dataSourcePath,
      languageProcessorJson: params.languageProcessorJson,
      files: parallelQueue,
      tempDir: params.tempDir,
      workerEntryPoint: workerEntry,
      onStatus: (msg) => sendPort.send(msg),
    );

    // --- STEP 3: MERGING ---
    await _mergeStagingData(
      db: db,
      workerDbPaths: workerDbPaths,
      indexId: indexId,
      sendPort: sendPort,
    );

    // --- STEP 4: MEDIA ---
    await _finalizeImport(db, mediaQueue, sendPort);

  } catch (e, stack) {
    print(stack);
    sendPort.send(e.toString());
  }
  finally {
    db.close();
    sendPort.send(null);
  }
}

Future<void> _mergeStagingData({
  required DaDb db,
  required List<String> workerDbPaths,
  required int indexId,
  required SendPort sendPort,
}) async {
  if (workerDbPaths.isEmpty) return;

  sendPort.send("Parsing complete. Merging data...");
  
  for (int i = 0; i < workerDbPaths.length; i++) {
    final path = workerDbPaths[i];
    if (await File(path).exists()) {
      sendPort.send("Merging ${i + 1}/${workerDbPaths.length}...");
      await mergeStagingDb(
        db: db,
        workerDbPath: path,
        indexId: indexId,
      );
      await File(path).delete();
    }
  }
}

Future<void> _finalizeImport(
  DaDb db, 
  List<({ArchiveFile file, int indexId, int? insertId})> mediaFiles, 
  SendPort sendPort
) async {
  if (mediaFiles.isNotEmpty) {
    sendPort.send("Importing ${mediaFiles.length} media files...");
    const batchSize = 200;
    for (var i = 0; i < mediaFiles.length; i += batchSize) {
      final end = min(i + batchSize, mediaFiles.length);
      await importMediaFiles(db, mediaFiles.sublist(i, end));
    }
  }

  sendPort.send("Optimizing database...");
  await optimizeDbAfterImport(db);
}