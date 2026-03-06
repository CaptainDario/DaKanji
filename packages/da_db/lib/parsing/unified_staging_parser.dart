import 'dart:async';
import 'dart:convert';
import 'dart:isolate';
import 'dart:math';
import 'dart:typed_data';

import 'package:archive/archive_io.dart';
import 'package:da_db/data/dictionary_types.dart';
import 'package:da_db/data/supported_audio_formats.dart';
import 'package:da_db/database/da_db.dart';
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

/// Orchestrates the parallel extraction, parsing, and SQL merging of dictionary archives.
/// 
/// Operates on a dedicated Isolate to keep the main UI thread unblocked. 
/// If [dictionaryType] is omitted, the system will automatically scan the archive's 
/// contents to infer the correct format (Yomitan, Examples, or Audio).
/// 
/// Returns a [Stream] of status messages intended for UI progress indicators.
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
    if (message is String) controller.add(message);
    else if (message == null) {
      receivePort.close();
      controller.close();
    }
    else controller.addError(message);
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

/// The core Isolate entry point for unified parsing.
/// 
/// Architecture flow:
/// 1. Type Inference -> 2. File Routing -> 3. Parallel Staging -> 
/// 4. SQLite Attachment -> 5. Transactional Merge -> 6. Cleanup.
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
    
    // --- STEP 1: SCAN & INFER ---
    // Extract BOTH potential metadata files up front. We must do this before routing
    // because we rely on the archive's internal filenames to infer its type if null.
    final allFiles = daDbDataSourceIterator(
      archivePath: params.dataSourcePath, 
      fileOrder: [indexFileName, yomitanIndexFile]
    ).toList();
    
    final DictionaryTypes actualType = params.dictionaryType ?? 
        determineDictionaryType(allFiles.map((f) => f.name));
    
    String? indexJson;
    final parallelQueue = <String>[];
    final mediaQueue = <ArchiveFile>[];
    String? audioListContent;

    // --- STEP 2: FILE ROUTING ---
    for (final file in allFiles) {
      final name = p.basename(file.name);
      
      // Strict Metadata Extraction
      bool isMetadataFile = false;
      if (actualType == DictionaryTypes.audio && name == yomitanIndexFile) {
        isMetadataFile = true;
      } else if (actualType != DictionaryTypes.audio && name == indexFileName) {
        isMetadataFile = true;
      } else if (actualType == DictionaryTypes.examples && name == yomitanIndexFile && indexJson == null) {
        isMetadataFile = true; 
      }

      // Decode main metadata into memory for the orchestrator
      if (isMetadataFile) {
        indexJson = utf8.decode(file.rawContent!.getStream(decompress: true).toUint8List());
        continue; 
      }
      
      if (!file.isFile) continue;

      // Route data files
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
          // We DO NOT add individual files here. 
          // The worker will handle the entire archive iteration.
          break;
      }
    }

    if (indexJson == null) {
      throw Exception("No valid metadata index file found for format: ${actualType.name}");
    }

    parallelQueue.sort((a, b) => a.compareTo(b));
    
    // --- STEP 3: CONFIGURE WORKER ENGINE ---
    late final void Function(SendPort) targetWorkerEntry;
    late final int numWorkers;

    switch (actualType) {
      case DictionaryTypes.yomitan:
        targetWorkerEntry = workerEntry; 
        numWorkers = min(max(1, parallelQueue.where((f) => f.startsWith(RegExp("$termBankPrefix|$termMetaBankPrefix"))).length), 4);
        break;
      case DictionaryTypes.examples:
        targetWorkerEntry = exampleWorkerEntry; 
        numWorkers = min(max(1, parallelQueue.length), 4);
        break;
      case DictionaryTypes.audio:
        targetWorkerEntry = audioWorkerEntry; 
        numWorkers = 1; // 1 worker will process the entire zip in a single pass
        
        // Give the worker the single command to process everything
        parallelQueue.add(processFullAudioArchive); 
        break;
    }

    // --- STEP 4: RUN PARALLEL STAGING ---
    workerDbPaths.addAll(await StagingWorkerPool.runGreedyParallelStaging(
      numWorkers: numWorkers,
      dataSourcePath: params.dataSourcePath,
      languageProcessorJson: params.languageProcessorJson,
      files: parallelQueue,
      tempDir: params.tempDir,
      workerEntryPoint: targetWorkerEntry,
      onStatus: (msg) => sendPort.send(msg),
    ));  

    // --- STEP 5: ATTACH WORKER DATABASES ---
    // Link the temporary worker SQLite files directly to the main database connection
    // to allow ultra-fast `INSERT INTO ... SELECT FROM` cross-database merging.
    List<String> workerAliases = [];
    for (int i = 0; i < workerDbPaths.length; i++) {
      workerAliases.add("worker_$i");
      await db.customStatement("ATTACH DATABASE '${workerDbPaths[i]}' AS ${workerAliases.last}");
    }
    
    await optimizeTargetDbForMerge(db);

    // --- STEP 6: MERGE ---
    // (Removed the overarching db.transaction wrapper because individual 
    // mergers execute PRAGMA safety changes which SQLite forbids inside transactions).
    
    final indexId = await parseAndInsertIndex(
      indexJson, db, actualType, params.isDefaultDictionary);
    
    sendPort.send("Parsing complete. Merging data...");
    
    // Dynamic Merger Routing
    for (int i = 0; i < workerAliases.length; i++) {
      sendPort.send("Merging ${i + 1}/${workerAliases.length}...");
      switch (actualType) {
        case DictionaryTypes.yomitan:
          await mergeStagingDb(db: db, workerAlias: workerAliases[i], indexId: indexId);
          break;
        case DictionaryTypes.examples:
          await mergeExampleStagingDb(db: db, workerAlias: workerAliases[i], indexId: indexId);
          break;
        case DictionaryTypes.audio:
          await mergeAudioStagingDb(db: db, workerDbPath: workerDbPaths[i], indexId: indexId);
          break;
      }
    }
    // merge audio lists on top level as they are small
    if(audioListContent != null) await parseAudioList(audioListContent, db, indexId);  

    // --- STEP 7: DYNAMIC MEDIA IMPORT ---
    if (mediaQueue.isNotEmpty) {
      sendPort.send("Importing ${mediaQueue.length} media files...");
      final mappedMedia = mediaQueue.map((f) => (file: f, indexId: indexId, insertId: null)).toList();
      
      for (var i = 0; i < mappedMedia.length; i += 200) {
        final end = min(i + 200, mappedMedia.length);
        await importMediaFiles(db, mappedMedia.sublist(i, end));
      }
    }

    // Run outside the transaction as SQLite forbids VACUUM operations inside transactions.
    sendPort.send("Optimizing database...");
    await optimizeDbAfterImport(db);

  }
  catch (e, stack) {
    print("Unified Import Error: $e\n$stack");
    sendPort.send(e.toString());
  }
  finally {
    // --- STEP 8: CLEANUP ---
    // Ensure file locks are released BEFORE attempting to delete the temporary databases.
    await restoreTargetDbAfterMerge(db);
    for (int i = 0; i < workerDbPaths.length; i++) {
      await db.customStatement('DETACH DATABASE worker_$i');
      if (File(workerDbPaths[i]).existsSync()) {
        File(workerDbPaths[i]).deleteSync();
      }
    }
    db.close();
    sendPort.send(null);
  }
}

/// Infers the expected Dictionary Format by analyzing the archive's file structure.
/// 
/// Relies on established naming schemas (e.g., `term_bank_*.json` for Yomitan, 
/// `example_bank_*.json` for Examples). Audio dictionaries are inferred via process 
/// of elimination alongside the presence of specific mapping files (`entries.json`).
DictionaryTypes determineDictionaryType(Iterable<String> fileNames) {
  bool hasExamples = false;
  bool hasYomitanBanks = false;
  bool hasYomitanAudioList = false;

  bool hasYomitanIndexFile = false; // "yomitan_index.json"
  bool hasAudioEntries = false;     // "entries.json"
  bool hasAudioIndex = false;       // "index.json"
  bool hasMediaFiles = false;

  for (final path in fileNames) {
    final name = p.basename(path);
    
    // 1. Example Fingerprints
    if (name.startsWith(exampleBankPrefix) || name.startsWith(exampleTextBankPrefix)) {
      hasExamples = true;
    } 
    // 2. Yomitan Fingerprints
    else if (name.startsWith(termBankPrefix) || name.startsWith(termMetaBankPrefix) ||
             name.startsWith(kanjiBankPrefix) || name.startsWith(kanjiMetaBankPrefix) ||
             name.startsWith(tagBankPrefix)) {
      hasYomitanBanks = true;
    } else if (name.startsWith(audioListName)) {
      hasYomitanAudioList = true;
    } 
    // 3. Audio Fingerprints
    else if (name == yomitanIndexFile) {
      hasYomitanIndexFile = true;
    } else if (name == audioEntriesFile) {
      hasAudioEntries = true;
    } else if (name == audioIndexFile) {
      hasAudioIndex = true;
    } else if (SupportedAudioFormats.values.any((ext) => name.endsWith(".${ext.name}"))) {
      hasMediaFiles = true;
    }
  }

  // --- Resolution Order ---

  // Precedence 1: Examples
  if (hasExamples) return DictionaryTypes.examples;

  // Precedence 2: Yomitan 
  // Standard banks OR specifically just a Yomitan audio_list format
  if (hasYomitanBanks || hasYomitanAudioList) return DictionaryTypes.yomitan;

  // Precedence 3: Explicit Audio Formats
  // Must have yomitan_index.json AND fit one of the three Audio schemas
  if (hasYomitanIndexFile && (hasAudioEntries || hasAudioIndex || hasMediaFiles)) {
    return DictionaryTypes.audio;
  }

  // Fallback assumption
  return DictionaryTypes.yomitan; 
}