
import 'dart:async';
import 'dart:convert';
import 'dart:isolate';
import 'dart:typed_data';

import 'package:dakanji_db_core/data/dictionary_types.dart';
import 'package:dakanji_db_core/parsing/util/db_optimization.dart';
import 'package:dakanji_db_core/parsing/util/import_context.dart';
import 'package:dakanji_db_core/parsing/util/parsing_util.dart';
import 'package:dakanji_db_core/parsing/yomitan/in_memory_cache/audio_source_list/audio_source_list_parser.dart';
import 'package:dakanji_db_core/parsing/yomitan/in_memory_cache/index/index_parser.dart';
import 'package:dakanji_db_core/parsing/yomitan/in_memory_cache/kanji/kanji_bank_v3_parser.dart';
import 'package:dakanji_db_core/parsing/yomitan/in_memory_cache/kanji/kanji_bank_v3_parser_context.dart';
import 'package:dakanji_db_core/parsing/yomitan/in_memory_cache/kanji_meta/kanji_meta_bank_v3_parser.dart';
import 'package:dakanji_db_core/parsing/yomitan/in_memory_cache/kanji_meta/kanji_meta_bank_v3_parser_context.dart';
import 'package:dakanji_db_core/parsing/yomitan/in_memory_cache/media/media_importer.dart';
import 'package:dakanji_db_core/parsing/yomitan/in_memory_cache/tag/tag_bank_v3_parser.dart';
import 'package:dakanji_db_core/parsing/yomitan/in_memory_cache/term/term_bank_v3_parser.dart';
import 'package:dakanji_db_core/parsing/yomitan/in_memory_cache/term/term_bank_v3_parser_context.dart';
import 'package:dakanji_db_core/parsing/yomitan/in_memory_cache/term_meta/term_meta_bank_v3_parser.dart';
import 'package:dakanji_db_core/parsing/yomitan/in_memory_cache/term_meta/term_meta_bank_v3_parser_context.dart';
import 'package:dakanji_db_core/util/memory_usage.dart';
import 'package:drift/isolate.dart';
import 'package:language_processing/language_processor.dart';
import 'package:path/path.dart' as p;

import '/database/dakanji_db.dart';



/// A list containing the names of files that are valid yomtain files
List<String> validDictionaryFiles = [
  audioFileNamingScheme,
  indexFileNamingScheme,
  tagBankFileNamingScheme,
  kanjiBankFileNamingScheme, kanjiMetaBankFileNamingScheme,
  termBankFileNamingScheme, termMetaBankFileNamingScheme
];
/// The name of the audio source list file
String audioFileNamingScheme = "audio_list";
/// The name of the dictionary index files
String indexFileNamingScheme = "index.json";
/// The naming pattern for tag bank files
String tagBankFileNamingScheme = "tag_bank";
/// The naming pattern for kanji bank files
String kanjiBankFileNamingScheme = "kanji_bank";
/// the naming pattern for kanji meta bank files
String kanjiMetaBankFileNamingScheme = "kanji_meta_bank";
/// the naming pattern for term bank terms
String termBankFileNamingScheme = "term_bank";
/// the naming pattern for term meta bank files
String termMetaBankFileNamingScheme = "term_meta_bank";


/// Parses the given yomitan dictionary folder
Future<Stream<String>> parseDictionaryDataSource({
  String? dataSourcePath,
  Uint8List? archiveBytes,
  required bool isDefaultDictionary,
  required DaKanjiDB db,
  required bool addStructuredContentJsonDefs,
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
    addFullJsonDefinitions: addStructuredContentJsonDefs,
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
  bool addFullJsonDefinitions,
  String languageProcessorJson,
  SendPort mainIsolateSendPort,
  bool inMemory,
  bool isDefaultDictionary
}) params) async {

  final db = DaKanjiDB(
    executor: await params.dbConnection.connect(),
    inMemory: params.inMemory,
    languageProcessor: LanguageProcessor.fromJsonString(params.languageProcessorJson)
  );
  await db.languageProcessor.init();
  printMemoryUsage();

  try {
    Iterable<({String filePath, Uint8List fileContent})> dataSources = dakanjiDBDataSourceIterator(
      archivePath: params.dataSourcePath,
      fileOrder: [indexFileNamingScheme, tagBankFileNamingScheme],
    );
    
    // parse the index file -> get dict index
    final indexFile = dataSources.first;
    int indexId = await parseAndInsertIndex(
      utf8.decode(indexFile.fileContent), db, DictionaryTypes.yomitan, params.isDefaultDictionary);
    final IndexTableData indexEntry = (await db.indexDao.getById(indexId))!;

    // create import context for parsing
    TermBankV3ParserContext? termImportContext;
    TermMetaBankV3ParserContext? termMetaImportContext;
    KanjiBankV3ParserContext? kanjiImportContext;
    KanjiMetaBankV3ParserContext? kanjiMetaImportContext;

    // parse the rest of the files (first tag bank, then the rest in sorted order)
    int progressCounter = 0;
    final int noEntries = dataSources.length;
    List<({String filePath, Uint8List mediaContent, int indexId, int? insertId})> filesToInsert = [];
    for (final ({String filePath, Uint8List fileContent}) data in dataSources) {

      progressCounter++;
      params.mainIsolateSendPort.send("Parsing ${data.filePath} ($progressCounter/$noEntries) ...");
      printMemoryUsage();

      if(p.basename(data.filePath).contains(indexFileNamingScheme)) continue; // skip index file (already parsed)
      if(!validDictionaryFiles.any((scheme) => p.basename(data.filePath).contains(scheme))){
        params.mainIsolateSendPort.send("Copying ${data.filePath} to DB ...");
        filesToInsert.add((filePath: data.filePath, mediaContent: data.fileContent,
          indexId: indexId, insertId: null));
      }
      else {
        // manage import contexts
        termImportContext = await manageImportContext(
          termImportContext, data.filePath, termBankFileNamingScheme,
          () => TermBankV3ParserContext.create(db, indexId));
        termMetaImportContext = await manageImportContext(
          termMetaImportContext, data.filePath, termMetaBankFileNamingScheme,
          () => TermMetaBankV3ParserContext.create(db, indexId));
        kanjiImportContext = await manageImportContext(
          kanjiImportContext, data.filePath, kanjiBankFileNamingScheme,
          () => KanjiBankV3ParserContext.create(db, indexId));
        kanjiMetaImportContext = await manageImportContext(
          kanjiMetaImportContext, data.filePath, kanjiMetaBankFileNamingScheme,
          () => KanjiMetaBankV3ParserContext.create(db));
          
        await parseDictionaryFile(
          filePath: data.filePath,
          fileContent: utf8.decode(data.fileContent),
          importContext: [termImportContext, termMetaImportContext, kanjiImportContext, kanjiMetaImportContext]
            .nonNulls.firstOrNull,
          db: db,
          ind: indexEntry,
          addFullJsonDefinitions: params.addFullJsonDefinitions,
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
  required DaKanjiDB db,
  required IndexTableData ind,
  required bool addFullJsonDefinitions,
}) async {
  
  // create config to pass the different arguments to the functions
  final parserConfig = {
    audioFileNamingScheme: () => parseAudio(fileContent, db, ind.id),
    kanjiMetaBankFileNamingScheme: () => parseKanjiMetaBankV3(fileContent, importContext as KanjiMetaBankV3ParserContext, db, ind.id),
    kanjiBankFileNamingScheme: () => parseKanjiBankV3(fileContent, importContext as KanjiBankV3ParserContext, db, ind.id),
    tagBankFileNamingScheme: () => parseTagBankv3(fileContent, db, ind.id),
    termMetaBankFileNamingScheme: () => parseTermMetaBankV3(fileContent, importContext as TermMetaBankV3ParserContext, db, ind.id),
    termBankFileNamingScheme: () => parseTermBankV3(fileContent, importContext as TermBankV3ParserContext, db, ind.id, addFullJsonDefinitions),
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
