
import 'dart:async';
import 'dart:convert';
import 'dart:isolate';
import 'dart:typed_data';

import 'package:archive/archive_io.dart';
import 'package:da_db/data/dictionary_types.dart';
import 'package:da_db/parsing/util/db_optimization.dart';
import 'package:da_db/parsing/util/import_context.dart';
import 'package:da_db/parsing/util/parsing_constants.dart';
import 'package:da_db/parsing/util/parsing_util.dart';
import 'package:da_db/parsing/yomitan/in_memory_cache/audio_source_list/audio_source_list_parser.dart';
import 'package:da_db/parsing/yomitan/in_memory_cache/index/index_parser.dart';
import 'package:da_db/parsing/yomitan/in_memory_cache/kanji/kanji_bank_v3_parser.dart';
import 'package:da_db/parsing/yomitan/in_memory_cache/kanji/kanji_bank_v3_parser_context.dart';
import 'package:da_db/parsing/yomitan/in_memory_cache/kanji_meta/kanji_meta_bank_v3_parser.dart';
import 'package:da_db/parsing/yomitan/in_memory_cache/kanji_meta/kanji_meta_bank_v3_parser_context.dart';
import 'package:da_db/parsing/yomitan/in_memory_cache/media/media_importer.dart';
import 'package:da_db/parsing/yomitan/in_memory_cache/tag/tag_bank_v3_parser.dart';
import 'package:da_db/parsing/yomitan/in_memory_cache/term/term_bank_v3_parser.dart';
import 'package:da_db/parsing/yomitan/in_memory_cache/term/term_bank_v3_parser_context.dart';
import 'package:da_db/parsing/yomitan/in_memory_cache/term_meta/term_meta_bank_v3_parser.dart';
import 'package:da_db/parsing/yomitan/in_memory_cache/term_meta/term_meta_bank_v3_parser_context.dart';
import 'package:da_db/util/memory_usage.dart';
import 'package:drift/isolate.dart';
import 'package:language_processing/language_processing.dart';
import 'package:path/path.dart' as p;

import '/database/da_db.dart';



/// Parses the given yomitan dictionary folder
Future<Stream<String>> parseDictionaryDataSource({
  String? dataSourcePath,
  Uint8List? archiveBytes,
  required bool isDefaultDictionary,
  required DaDb db,
}) async {

  assert(dataSourcePath != null);

  // Stream so that the 'outside' can listen to the progress
  final StreamController<String> controller = StreamController();

  /// get parameters for isolate and spawn it
  final connection = await db.attachedDatabase.serializableConnection();

  // setup isolate communication
  ReceivePort receivePort = ReceivePort();
  receivePort.listen((message) {
    if(message is String) controller.add(message);
    else if(message == null) {
      receivePort.close();
      controller.close();
    }
    else controller.addError(message);
  });

  bool inMemory = db.inMemory;
  await Isolate.spawn(_parseDictionaryDataSource, (
    dataSourcePath: dataSourcePath,
    archiveBytes: archiveBytes,
    dbConnection: connection,
    languageProcessorJson: db.languageProcessor.toJsonString(),
    mainIsolateSendPort: receivePort.sendPort,
    inMemory: inMemory,
    isDefaultDictionary: isDefaultDictionary
  ));

  return controller.stream;

}

/// Actual implementation of [parseDictionaryDataSource] that runs in an
/// isolate.
Future _parseDictionaryDataSource(({
  String? dataSourcePath,
  Uint8List? archiveBytes,
  DriftIsolate dbConnection,
  String languageProcessorJson,
  SendPort mainIsolateSendPort,
  bool inMemory,
  bool isDefaultDictionary
}) params) async {

  final db = DaDb(
    executor: await params.dbConnection.connect(),
    inMemory: params.inMemory,
    languageProcessor: LanguageProcessor.fromJsonString(params.languageProcessorJson)
  );
  await db.languageProcessor.init();
  printMemoryUsage();

  try {
    Iterable<ArchiveFile> dataSources = daDbDataSourceIterator(
      archivePath: params.dataSourcePath,
      fileOrder: [indexFileName, tagBankPrefix],
    );
    
    // parse the index file -> get dict index
    final indexFile = dataSources.first;
    int indexId = await parseAndInsertIndex(
      utf8.decode(indexFile.content), db, DictionaryTypes.yomitan, params.isDefaultDictionary);
    final IndexTableData indexEntry = (await db.indexDao.getTableDataById(indexId))!;

    // create import context for parsing
    TermBankV3ParserContext? termImportContext;
    TermMetaBankV3ParserContext? termMetaImportContext;
    KanjiBankV3ParserContext? kanjiImportContext;
    KanjiMetaBankV3ParserContext? kanjiMetaImportContext;

    // parse the rest of the files (first tag bank, then the rest in sorted order)
    int progressCounter = 0;
    final int noEntries = dataSources.length;
    List<({ArchiveFile file, int indexId, int? insertId})> filesToInsert = [];
    for (ArchiveFile data in dataSources) {

      progressCounter++;
      params.mainIsolateSendPort.send("Parsing ${data.name} ($progressCounter/$noEntries) ...");
      printMemoryUsage();

      if(p.basename(data.name).contains(indexFileName)) continue; // skip index file (already parsed)
      if(!yomitanDictFiles.any((scheme) => p.basename(data.name).contains(scheme))){
        params.mainIsolateSendPort.send("Copying ${data.name} to DB ...");
        filesToInsert.add((
          file: data, indexId: indexId, insertId: null));
      }
      else {
        // manage import contexts
        termImportContext = await manageImportContext(
          termImportContext, data.name, termBankPrefix,
          () => TermBankV3ParserContext.create(db, indexId));
        termMetaImportContext = await manageImportContext(
          termMetaImportContext, data.name, termMetaBankPrefix,
          () => TermMetaBankV3ParserContext.create(db, indexId));
        kanjiImportContext = await manageImportContext(
          kanjiImportContext, data.name, kanjiBankPrefix,
          () => KanjiBankV3ParserContext.create(db, indexId));
        kanjiMetaImportContext = await manageImportContext(
          kanjiMetaImportContext, data.name, kanjiMetaBankPrefix,
          () => KanjiMetaBankV3ParserContext.create(db));
          
        await parseDictionaryFile(
          filePath: data.name,
          fileContent: utf8.decode(data.content),
          importContext: [termImportContext, termMetaImportContext, kanjiImportContext, kanjiMetaImportContext]
            .nonNulls.firstOrNull,
          db: db,
          ind: indexEntry,
        );
      }
      if(filesToInsert.length >= 50 || (progressCounter == noEntries && filesToInsert.isNotEmpty)) {
        await importMediaFiles(db, filesToInsert);
        filesToInsert.clear();
      }
    }

    await optimizeDbAfterImport(db);
  }
  catch (e) {
    params.mainIsolateSendPort.send(e);
    params.mainIsolateSendPort.send(null);
  }

  db.languageProcessor.close();

  // close isolate communication
  params.mainIsolateSendPort.send(null);

}

/// Manages the lifecycle of an import context.
///
/// Returns a new context if [currentContext] is null and [filePath] matches the [namingScheme].
/// Returns null if [currentContext] exists and [filePath] no longer matches.
/// Otherwise, returns the [currentContext] unchanged.
Future<T?> manageImportContext<T>(
  T? currentContext,
  String filePath,
  String namingScheme,
  Future<T> Function() create
) async {
  final bool matchesScheme = filePath.contains(namingScheme);

  if (currentContext == null && matchesScheme) {
    // Condition to CREATE the context
    print("Creating new import context for $namingScheme");
    return await create();
  } else if (currentContext != null && !matchesScheme) {
    // Condition to DISPOSE of the context
    print("Disposing import context for $namingScheme");
    return null;
  }
  
  // No change needed
  return currentContext;
}

/// Depending on the file name applies the correct parsing method
Future parseDictionaryFile({
  required String filePath,
  required String fileContent,
  required ParserContext? importContext,
  required DaDb db,
  required IndexTableData ind,
}) async {
  
  // create config to pass the different arguments to the functions
  final parserConfig = {
    audioListName: () => parseAudioList(fileContent, db, ind.id),
    tagBankPrefix: () => parseTagBankv3(fileContent, db, ind.id),
    kanjiBankPrefix: () => parseKanjiBankV3(fileContent, importContext as KanjiBankV3ParserContext, db, ind.id),
    kanjiMetaBankPrefix: () => parseKanjiMetaBankV3(fileContent, importContext as KanjiMetaBankV3ParserContext, db, ind.id),
    termBankPrefix: () => parseTermBankV3(fileContent, importContext as TermBankV3ParserContext, db, ind.id),
    termMetaBankPrefix: () => parseTermMetaBankV3(fileContent, importContext as TermMetaBankV3ParserContext, db, ind.id),
  };

  final baseName = p.basename(filePath);
  for (final entry in parserConfig.entries) {
    final scheme = entry.key;
    final parserFunction = entry.value;

    if (baseName.contains(scheme)) {
      //print("Parsing $baseName as `$scheme`");
      await parserFunction();
      break;
    }
  }

}
