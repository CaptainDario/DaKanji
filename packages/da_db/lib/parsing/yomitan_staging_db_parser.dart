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
import 'package:da_db/parsing/yomitan/in_memory_cache/index/index_parser.dart';
import 'package:da_db/parsing/yomitan/in_memory_cache/media/media_importer.dart';
import 'package:da_db/parsing/yomitan/staging_db/mergers/staging_db_merging.dart';
import 'package:da_db/parsing/yomitan/staging_db/workers/worker_entry.dart';
import 'package:da_db/parsing/yomitan/staging_db/workers/worker_protocol.dart';
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
        if (name.endsWith('.json')) print("DEBUG: Treating as media: $name"); // Trace unhandled files
        mediaQueue.add((
          file: file,
          indexId: 0,
          insertId: null
        ));
        file.closeSync();
      }
    }

    // --- STEP 2: STAGING ---
    if (indexId == null) throw Exception("No index.json found.");
    parallelQueue.sort((a, b) => a.compareTo(b));

    final List<String> workerDbPaths = await _runGreedyParallelStaging(
      params: params,
      queue: parallelQueue,
      sendPort: sendPort,
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
  } finally {
    zipStream?.close();
    db.close();
    sendPort.send(null);
  }
}
Future<List<String>> _runGreedyParallelStaging({
  required ({
    String dataSourcePath,
    DriftIsolate dbConnection,
    String languageProcessorJson,
    SendPort mainIsolateSendPort,
    bool inMemory,
    bool isDefaultDictionary,
    Directory tempDir,
  }) params,
  required List<String> queue,
  required SendPort sendPort,
}) async {
  if (queue.isEmpty) return [];

  sendPort.send("Importing ${queue.length} file(s)...");
  final poolDir = await params.tempDir.createTemp('da_db_pool_');
  final workerDbPaths = <String>[];
  final completions = <Future>[];
  
  final int numWorkers = min(
    max(1, queue.where((f) => f.contains(RegExp("term_bank|term_meta_bank"))).length),
    4
  );

  for (int i = 0; i < numWorkers; i++) {
    final workerDbPath = p.join(poolDir.path, 'worker_$i.db');
    workerDbPaths.add(workerDbPath);
    final completer = Completer<void>();
    completions.add(completer.future);

    _spawnWorker(
      id: i,
      zipPath: params.dataSourcePath,
      dbPath: workerDbPath,
      lpJson: params.languageProcessorJson,
      files: queue,
      completer: completer,
      onStatus: (msg) => sendPort.send(msg)
    );
  }

  await Future.wait(completions);
  return workerDbPaths;
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

Future<void> _spawnWorker({
  required int id,
  required String zipPath,
  required String dbPath,
  required String lpJson,
  required List<String> files,
  required Completer completer,
  required Function(String) onStatus,
}) async {
  final receivePort = ReceivePort();
  await Isolate.spawn(workerEntry, receivePort.sendPort);

  SendPort? workerSendPort;
  String? currentFileName;

  receivePort.listen((message) {
    if (message is SendPort) {
      workerSendPort = message;
      workerSendPort!.send(MsgInit(zipPath, dbPath, lpJson, receivePort.sendPort));
    } 
    else if (message is MsgReady) {
      if (files.isNotEmpty) {
        currentFileName = files.removeAt(0);
        workerSendPort!.send(MsgProcessFile(currentFileName!));
      } else {
        workerSendPort!.send(MsgTerminate());
      }
    }
    else if (message is MsgDone) {
      onStatus("Parsed: $currentFileName");
      
      if (files.isNotEmpty) {
        currentFileName = files.removeAt(0);
        workerSendPort!.send(MsgProcessFile(currentFileName!));
      } else {
        workerSendPort!.send(MsgTerminate());
      }
    }
    else if (message is MsgError) {
      print("Worker $id Error: ${message.error}");
      if (files.isNotEmpty) {
        currentFileName = files.removeAt(0);
        workerSendPort!.send(MsgProcessFile(currentFileName!));
      } else {
        workerSendPort!.send(MsgTerminate());
      }
    }
    else if (message == "CLOSED") {
      receivePort.close();
      completer.complete();
    }
  });
}