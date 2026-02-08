import 'dart:async';
import 'dart:convert';
import 'dart:isolate';
import 'dart:typed_data';

import 'package:archive/archive_io.dart';
import 'package:dakanji_db_core/data/dictionary_types.dart';
import 'package:dakanji_db_core/database/dakanji_db.dart';
import 'package:dakanji_db_core/parsing/util/db_optimization.dart';
// --- Existing Utilities ---
import 'package:dakanji_db_core/parsing/yomitan/in_memory_cache/index/index_parser.dart';
import 'package:dakanji_db_core/parsing/yomitan/in_memory_cache/media/media_importer.dart';
import 'package:dakanji_db_core/parsing/yomitan/staging_db/mergers/staging_db_merging.dart';
import 'package:dakanji_db_core/parsing/yomitan/staging_db/workers/worker_entry.dart';
import 'package:dakanji_db_core/parsing/yomitan/staging_db/workers/worker_protocol.dart';
import 'package:dakanji_db_core/util/memory_usage.dart';
import 'package:drift/isolate.dart';
import 'package:language_processing/language_processing.dart';
import 'package:path/path.dart' as p;
import 'package:universal_io/io.dart';



const String indexFileNamingScheme = "index.json";
const List<String> parallelHandledFiles = [
  "term_bank", "kanji_bank", "tag_bank", 
  "term_meta_bank", "kanji_meta_bank"
];


Future<Stream<String>> parseDictionaryDataSource({
  String? dataSourcePath,
  Uint8List? archiveBytes,
  required bool isDefaultDictionary,
  required DaKanjiDB db,
  required bool addStructuredContentJsonDefs,
}) async {
  assert(dataSourcePath != null, "Parallel import requires a file path");

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
    addFullJsonDefinitions: addStructuredContentJsonDefs,
    languageProcessorJson: lpJson,
    mainIsolateSendPort: receivePort.sendPort,
    inMemory: db.inMemory,
    isDefaultDictionary: isDefaultDictionary
  ));

  return controller.stream;
}

// -----------------------------------------------------------------------------
// ORCHESTRATOR ISOLATE
// -----------------------------------------------------------------------------

Future<void> _orchestratorEntry(({
  String dataSourcePath,
  DriftIsolate dbConnection,
  bool addFullJsonDefinitions,
  String languageProcessorJson,
  SendPort mainIsolateSendPort,
  bool inMemory,
  bool isDefaultDictionary
}) params) async {

  final sendPort = params.mainIsolateSendPort;
  
  // 1. Setup DB (Lightweight Mode - No MeCab Init)
  final db = DaKanjiDB(
    executor: await params.dbConnection.connect(),
    inMemory: params.inMemory,
    languageProcessor: LanguageProcessor.fromJsonString(params.languageProcessorJson)
  );

  InputFileStream? zipStream;

  try {
    sendPort.send("Scanning dictionary structure...");
    printMemoryUsage();

    // 2. Open Zip (Headers Only)
    zipStream = InputFileStream(params.dataSourcePath);
    final archiveHeaders = ZipDecoder().decodeStream(zipStream);

    // 3. Parse Index
    final indexHeader = archiveHeaders.findFile(indexFileNamingScheme);
    if (indexHeader == null) throw Exception("Invalid Dictionary: No index.json found.");

    final indexContentStream = indexHeader.rawContent!.getStream(decompress: true);
    final indexJson = utf8.decode(indexContentStream.toUint8List());
    indexHeader.closeSync(); // Clear memory

    final int indexId = await parseAndInsertIndex(
      indexJson, db, DictionaryTypes.yomitan, params.isDefaultDictionary);

    // 4. Sort Files
    final parallelParseQueue = <String>[];
    final mediaFilesToInsert = <({String filePath, Uint8List mediaContent, int indexId, int? insertId})>[];

    for (final file in archiveHeaders.files) {
      final name = p.basename(file.name);
      if (name == indexFileNamingScheme) continue;

      if (parallelHandledFiles.any((s) => name.contains(s))) {
        parallelParseQueue.add(file.name);
      }
      else {
        // Collect media files for standard import
        final content = file.content as List<int>;
        mediaFilesToInsert.add((
          filePath: file.name,
          mediaContent: Uint8List.fromList(content),
          indexId: indexId,
          insertId: null
        ));
        file.closeSync(); // Clear memory
      }
    }

    // PARALLEL PARSING
    if (parallelParseQueue.isNotEmpty) {
      sendPort.send("Starting parallel import of ${parallelParseQueue.length} data files...");
      
      final tempDir = await Directory.systemTemp.createTemp('dakanji_pool_');
      final workerDbPaths = <String>[];
      final workerCompletions = <Future>[];
      const int numWorkers = 2;

      for (int i = 0; i < numWorkers; i++) {
        final workerDbPath = p.join(tempDir.path, 'worker_$i.db');
        workerDbPaths.add(workerDbPath);
        final completer = Completer<void>();
        workerCompletions.add(completer.future);

        // Round-robin assignment
        final myFiles = parallelParseQueue.where((f) => parallelParseQueue.indexOf(f) % numWorkers == i).toList();

        if (myFiles.isNotEmpty) {
           _spawnWorker(
             id: i,
             zipPath: params.dataSourcePath,
             dbPath: workerDbPath,
             lpJson: params.languageProcessorJson,
             files: myFiles,
             saveJson: params.addFullJsonDefinitions,
             completer: completer,
             onStatus: (msg) => sendPort.send(msg)
           );
        }
        else {
          completer.complete();
        }
      }

      await Future.wait(workerCompletions);
      sendPort.send("Parallel parsing complete. Merging data...");

      // MERGE STAGING DB
      for (int i = 0; i < workerDbPaths.length; i++) {
        final path = workerDbPaths[i];
        final f = File(path);
        if (await f.exists()) {
          sendPort.send("Merging worker ${i + 1}/$numWorkers...");
          await mergeStagingDb(
            db: db,
            workerDbPath: path,
            indexId: indexId,
            addJsonDefs: params.addFullJsonDefinitions
          );
          await f.delete();
        }
      }
      
      await tempDir.delete(recursive: true);
    }

    // IMPORT MEDIA (Using Existing Utility)
    if (mediaFilesToInsert.isNotEmpty) {
      sendPort.send("Importing ${mediaFilesToInsert.length} media files...");
      
      const batchSize = 50;
      for (var i = 0; i < mediaFilesToInsert.length; i += batchSize) {
        final end = (i + batchSize < mediaFilesToInsert.length) ? i + batchSize : mediaFilesToInsert.length;
        await importMediaFiles(db, mediaFilesToInsert.sublist(i, end));
      }
    }

    sendPort.send("Optimizing database...");
    await optimizeDbAfterImport(db);

  } catch (e, stack) {
    print(stack);
    sendPort.send(e.toString());
  } finally {
    zipStream?.close();
    db.close(); 
    sendPort.send(null); // Signal End
  }
}



Future<void> _spawnWorker({
  required int id,
  required String zipPath,
  required String dbPath,
  required String lpJson,
  required List<String> files,
  required bool saveJson,
  required Completer completer,
  required Function(String) onStatus,
}) async {
  final receivePort = ReceivePort();
  // We use the workerEntry imported from 'worker/worker_entry.dart'
  await Isolate.spawn(workerEntry, receivePort.sendPort);

  SendPort? workerSendPort;
  int completed = 0;

  receivePort.listen((message) {
    if (message is SendPort) {
      workerSendPort = message;
      workerSendPort!.send(MsgInit(zipPath, dbPath, lpJson, saveJson, receivePort.sendPort));
    } 
    else if (message is MsgReady) {
      if (files.isNotEmpty) workerSendPort!.send(MsgProcessFile(files.removeAt(0)));
      else workerSendPort!.send(MsgTerminate());
    }
    else if (message is MsgDone) {
      completed++;
      if (completed % 5 == 0) onStatus("Worker $id: Parsed $completed files...");
      
      if (files.isNotEmpty) workerSendPort!.send(MsgProcessFile(files.removeAt(0)));
      else workerSendPort!.send(MsgTerminate());
    }
    else if (message is MsgError) {
      print("Worker $id Error: ${message.error}");
      if (files.isNotEmpty) workerSendPort!.send(MsgProcessFile(files.removeAt(0)));
      else workerSendPort!.send(MsgTerminate());
    }
    else if (message == "CLOSED") {
      receivePort.close();
      completer.complete();
    }
  });
}