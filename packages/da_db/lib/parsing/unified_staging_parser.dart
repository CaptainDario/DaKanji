import 'dart:async';
import 'dart:convert';
import 'dart:isolate';
import 'dart:math';
import 'dart:typed_data';

import 'package:archive/archive_io.dart';
import 'package:da_db/data/dictionary_types.dart';
import 'package:da_db/data/supported_audio_formats.dart';
import 'package:da_db/database/da_db.dart';
import 'package:da_db/database/index/yomitan_index.dart';
import 'package:da_db/parsing/audio/mergers/audio_staging_db_merging.dart';
import 'package:da_db/parsing/audio/workers/audio_worker_entry.dart';
import 'package:da_db/parsing/example/mergers/example_staging_db_merging.dart';
import 'package:da_db/parsing/example/workers/example_worker_entry.dart';
import 'package:da_db/parsing/util/db_optimization.dart';
import 'package:da_db/parsing/util/parsing_constants.dart';
import 'package:da_db/parsing/util/parsing_util.dart';
import 'package:da_db/parsing/util/staging_worker_pool.dart';
import 'package:da_db/parsing/util/worker_protocol.dart';
import 'package:da_db/parsing/yomitan/in_memory_cache/audio_source_list/audio_source_list_parser.dart';
import 'package:da_db/parsing/yomitan/in_memory_cache/index/index_parser.dart';
import 'package:da_db/parsing/yomitan/in_memory_cache/media/media_importer.dart';
import 'package:da_db/parsing/yomitan/staging_db/mergers/staging_db_merging.dart';
import 'package:da_db/parsing/yomitan/staging_db/workers/worker_entry.dart';
import 'package:drift/isolate.dart';
import 'package:language_processing/language_processing.dart';
import 'package:path/path.dart' as p;
import 'package:universal_io/io.dart';

typedef RoutingResult = ({
  DictionaryTypes actualType,
  String indexJson,
  YomitanIndex index,
  List<String> parallelQueue,
  List<ArchiveFile> mediaQueue,
  String? audioListContent,
});

/// Orchestrates the parallel extraction, parsing, and SQL merging of dictionary archives.
Future<Stream<String>> parseDaDbDataSource({
  String? dataSourcePath,
  Uint8List? archiveBytes,
  required bool isDefaultDictionary,
  required DaDb db,
  DictionaryTypes? dictionaryType,
  Directory? tempDir,
}) async {
  assert(dataSourcePath != null, "Parallel import requires a file path");
  tempDir ??= Directory.systemTemp;

  final StreamController<String> controller = StreamController();
  final connection = await db.attachedDatabase.serializableConnection();
  final lpJson = db.languageProcessor.toJsonString();

  ReceivePort receivePort = ReceivePort();
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

  await Isolate.spawn(_unifiedOrchestratorEntry, (
    dataSourcePath: dataSourcePath!,
    dbConnection: connection,
    languageProcessorJson: lpJson,
    mainIsolateSendPort: receivePort.sendPort,
    inMemory: db.inMemory,
    isDefaultDictionary: isDefaultDictionary,
    dictionaryType: dictionaryType,
    tempDir: tempDir
  ));

  return controller.stream;
}

Future<void> _unifiedOrchestratorEntry(({
  String dataSourcePath,
  DriftIsolate dbConnection,
  String languageProcessorJson,
  SendPort mainIsolateSendPort,
  bool inMemory,
  bool isDefaultDictionary,
  DictionaryTypes? dictionaryType,
  Directory tempDir,
}) params) async {
  final sendPort = params.mainIsolateSendPort;
  final db = DaDb(
    executor: await params.dbConnection.connect(),
    inMemory: params.inMemory,
    languageProcessor: LanguageProcessor.fromJsonString(params.languageProcessorJson)
  );

  final List<String> workerDbPaths = [];

  try {
    sendPort.send("Scanning dictionary structure...");
    
    final routing = _scanAndRouteFiles(
      dataSourcePath: params.dataSourcePath,
      requestedType: params.dictionaryType,
    );

    final engineConfig = _configureWorkerEngine(
      actualType: routing.actualType, 
      parallelQueue: routing.parallelQueue,
    );
    
    workerDbPaths.addAll(await StagingWorkerPool.runGreedyParallelStaging(
      numWorkers: engineConfig.numWorkers,
      dataSourcePath: params.dataSourcePath,
      languageProcessorJson: params.languageProcessorJson,
      index: routing.index,
      files: routing.parallelQueue,
      tempDir: params.tempDir,
      workerEntryPoint: engineConfig.targetWorkerEntry,
      onStatus: (msg) => sendPort.send(msg),
    ));  

    final workerAliases = await _attachWorkerDatabases(db, workerDbPaths);
    await optimizeTargetDbForMerge(db);

    await _executeMergeTransaction(
      db: db,
      routing: routing,
      workerAliases: workerAliases,
      workerDbPaths: workerDbPaths,
      isDefaultDictionary: params.isDefaultDictionary,
      sendPort: sendPort,
    );

    sendPort.send("Optimizing database...");
    await optimizeDbAfterImport(db);

  } catch (e, stack) {
    print("Unified Import Error: $e\n$stack");
    sendPort.send(e.toString());
  } finally {
    await _cleanup(db, workerDbPaths);
    sendPort.send(null);
  }
}

RoutingResult _scanAndRouteFiles({
  required String dataSourcePath,
  DictionaryTypes? requestedType,
}) {
  final allFiles = daDbDataSourceIterator(
    archivePath: dataSourcePath, 
    fileOrder: [indexFileName, yomitanIndexFile]
  ).toList();
  
  final actualType = requestedType ?? determineDictionaryType(allFiles.map((f) => f.name));
  
  String? indexJson;
  final parallelQueue = <String>[];
  final mediaQueue = <ArchiveFile>[];
  String? audioListContent;

  for (final file in allFiles) {
    final name = p.basename(file.name);
    
    bool isMetadataFile = false;
    if (actualType == DictionaryTypes.audio && name == yomitanIndexFile) {
      isMetadataFile = true;
    } else if (actualType != DictionaryTypes.audio && name == indexFileName) {
      isMetadataFile = true;
    } else if (actualType == DictionaryTypes.examples && name == yomitanIndexFile && indexJson == null) {
      isMetadataFile = true; 
    }

    if (isMetadataFile) {
      indexJson = utf8.decode(file.rawContent!.getStream(decompress: true).toUint8List());
      continue; 
    }
    
    if (!file.isFile) continue;

    switch (actualType) {
      case DictionaryTypes.yomitan:
        if (name == audioListName) audioListContent = utf8.decode(file.content);
        else if(yomitanDictFiles.any((s) => name.contains(s))) parallelQueue.add(file.name);
        else mediaQueue.add(file);
        break;
      case DictionaryTypes.examples:
        if (exampleDictFiles.any((s) => name.contains(s))) parallelQueue.add(file.name);
        else if (SupportedAudioFormats.values.any((ext) => name.endsWith(".${ext.name}"))) mediaQueue.add(file);
        break;
      case DictionaryTypes.audio:
        break;
    }
  }

  if (indexJson == null) {
    throw Exception("No valid metadata index file found for format: ${actualType.name}");
  }

  parallelQueue.sort((a, b) => a.compareTo(b));

  return (
    actualType: actualType,
    indexJson: indexJson,
    index: YomitanIndex.fromJson(jsonDecode(indexJson)),
    parallelQueue: parallelQueue,
    mediaQueue: mediaQueue,
    audioListContent: audioListContent,
  );
}

({void Function(SendPort) targetWorkerEntry, int numWorkers}) _configureWorkerEngine({
  required DictionaryTypes actualType,
  required List<String> parallelQueue,
}) {
  switch (actualType) {
    case DictionaryTypes.yomitan:
      return (
        targetWorkerEntry: workerEntry, 
        numWorkers: min(max(1, parallelQueue.where((f) => f.startsWith(RegExp("$termBankPrefix|$termMetaBankPrefix"))).length), 4)
      );
    case DictionaryTypes.examples:
      return (
        targetWorkerEntry: exampleWorkerEntry, 
        numWorkers: min(max(1, parallelQueue.length), 4)
      );
    case DictionaryTypes.audio:
      parallelQueue.add(processFullAudioArchive);
      return (
        targetWorkerEntry: audioWorkerEntry, 
        numWorkers: 1 
      );
  }
}

Future<List<String>> _attachWorkerDatabases(DaDb db, List<String> workerDbPaths) async {
  final List<String> workerAliases = [];
  for (int i = 0; i < workerDbPaths.length; i++) {
    workerAliases.add("worker_$i");
    await db.customStatement("ATTACH DATABASE '${workerDbPaths[i]}' AS ${workerAliases.last}");
  }
  return workerAliases;
}

Future<void> _executeMergeTransaction({
  required DaDb db,
  required RoutingResult routing,
  required List<String> workerAliases,
  required List<String> workerDbPaths,
  required bool isDefaultDictionary,
  required SendPort sendPort,
}) async {
  await db.transaction(() async {
    final indexId = await parseAndInsertIndex(
      routing.indexJson, db, routing.actualType, isDefaultDictionary);
    
    sendPort.send("Parsing complete. Merging data...");
    
    for (int i = 0; i < workerAliases.length; i++) {
      sendPort.send("Merging ${i + 1}/${workerAliases.length}...");
      switch (routing.actualType) {
        case DictionaryTypes.yomitan:
          await mergeStagingDb(db: db, workerAlias: workerAliases[i], index: routing.index, indexId: indexId);
          break;
        case DictionaryTypes.examples:
          await mergeExampleStagingDb(db: db, workerAlias: workerAliases[i], index: routing.index, indexId: indexId);
          break;
        case DictionaryTypes.audio:
          await mergeAudioStagingDb(db: db, workerDbPath: workerDbPaths[i], index: routing.index, indexId: indexId);
          break;
      }
    }
    
    if (routing.audioListContent != null) {
      await parseAudioList(routing.audioListContent!, db, indexId);  
    }

    if (routing.mediaQueue.isNotEmpty) {
      sendPort.send("Importing ${routing.mediaQueue.length} media files...");
      
      // Explicitly typed to prevent implicit dynamic cast exceptions.
      final mappedMedia = routing.mediaQueue.map<({ArchiveFile file, int indexId, int? insertId})>(
        (f) => (file: f, indexId: indexId, insertId: null)
      ).toList();
      
      for (var i = 0; i < mappedMedia.length; i += 200) {
        final end = min(i + 200, mappedMedia.length);
        await importMediaFiles(db, mappedMedia.sublist(i, end));
      }
    }
  });
}

Future<void> _cleanup(DaDb db, List<String> workerDbPaths) async {
  await restoreTargetDbAfterMerge(db);
  for (int i = 0; i < workerDbPaths.length; i++) {
    await db.customStatement('DETACH DATABASE worker_$i');
    if (File(workerDbPaths[i]).existsSync()) {
      File(workerDbPaths[i]).deleteSync();
    }
  }
  await db.close();
}

DictionaryTypes determineDictionaryType(Iterable<String> fileNames) {
  bool hasExamples = false;
  bool hasYomitanBanks = false;
  bool hasYomitanAudioList = false;

  bool hasYomitanIndexFile = false;
  bool hasAudioEntries = false;
  bool hasAudioIndex = false;
  bool hasMediaFiles = false;

  for (final path in fileNames) {
    final name = p.basename(path);
    
    if (name.startsWith(exampleBankPrefix) || name.startsWith(exampleTextBankPrefix)) {
      hasExamples = true;
    } else if (name.startsWith(termBankPrefix) || name.startsWith(termMetaBankPrefix) ||
               name.startsWith(kanjiBankPrefix) || name.startsWith(kanjiMetaBankPrefix) ||
               name.startsWith(tagBankPrefix)) {
      hasYomitanBanks = true;
    } else if (name.startsWith(audioListName)) {
      hasYomitanAudioList = true;
    } else if (name == yomitanIndexFile) {
      hasYomitanIndexFile = true;
    } else if (name == audioEntriesFile) {
      hasAudioEntries = true;
    } else if (name == audioIndexFile) {
      hasAudioIndex = true;
    } else if (SupportedAudioFormats.values.any((ext) => name.endsWith(".${ext.name}"))) {
      hasMediaFiles = true;
    }
  }

  if (hasExamples) return DictionaryTypes.examples;
  if (hasYomitanBanks || hasYomitanAudioList) return DictionaryTypes.yomitan;
  if (hasYomitanIndexFile && (hasAudioEntries || hasAudioIndex || hasMediaFiles)) return DictionaryTypes.audio;

  return DictionaryTypes.yomitan; 
}