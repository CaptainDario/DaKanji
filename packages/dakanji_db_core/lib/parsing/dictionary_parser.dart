
import 'dart:async';
import 'dart:convert';
import 'dart:isolate';
import 'dart:typed_data';

import 'package:dakanji_db_core/parsing/audio_source_list/audio_source_list_parser.dart';
import 'package:dakanji_db_core/parsing/kanji/kanji_bank_v3_parser_context.dart';
import 'package:dakanji_db_core/parsing/kanji_meta/kanji_meta_bank_v3_parser_context.dart';
import 'package:dakanji_db_core/parsing/media/media_importer.dart';
import 'package:dakanji_db_core/parsing/term/term_bank_v3_parser_context.dart';
import 'package:dakanji_db_core/parsing/term_meta/term_meta_bank_v3_parser_context.dart';
import 'package:dakanji_db_core/parsing/util/db_optimization.dart';
import 'package:dakanji_db_core/parsing/util/import_context.dart';
import 'package:dakanji_db_core/parsing/util/parsing_util.dart';
import 'package:drift/isolate.dart';
import 'package:mecab_for_dart/mecab_dart.dart';
import 'package:path/path.dart' as p;

import '/database/dakanji_db.dart';
import '/parsing/index/index_parser.dart';
import '/parsing/kanji/kanji_bank_v3_parser.dart';
import '/parsing/kanji_meta/kanji_meta_bank_v3_parser.dart';
import '/parsing/tag/tag_bank_v3_parser.dart';
import '/parsing/term_meta/term_meta_bank_v3_parser.dart';
import 'term/term_bank_v3_parser.dart';

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
  required DaKanjiDB db,
  required bool addFullJsonDefinitions,
  required Mecab mecab,
}) async {

  assert(dataSourcePath != null);

  // Stream so that the 'outside' can listen to the progress
  final StreamController<String> controller = StreamController();

  /// get parameters for isolate and spawn it
  final connection = await db.attachedDatabase.serializableConnection();
  String libmecabPath = mecab.libmecabPath!;
  String mecabDicPath = mecab.mecabDictDirPath!;

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
    addFullJsonDefinitions: addFullJsonDefinitions,
    libmecabPath: libmecabPath,
    mecabDictDir: mecabDicPath,
    mainIsolateSendPort: receivePort.sendPort,
    inMemory: inMemory
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
  String libmecabPath,
  String mecabDictDir,
  SendPort mainIsolateSendPort,
  bool inMemory
}) params) async {

  final db = DaKanjiDB(
    executor: await params.dbConnection.connect(),
    inMemory: params.inMemory
  );
  final mecab = Mecab();
  await mecab.init(params.libmecabPath, params.mecabDictDir, true);

  try {
    Iterable<({String filePath, Uint8List fileContent})> dataSources = dakanjiDBDataSourceIterator(
      archivePath: params.dataSourcePath,
      fileOrder: [indexFileNamingScheme, tagBankFileNamingScheme],
    );
    
    // parse the index file -> get dict index
    final indexFile = dataSources.first;
    int indexId = await parseAndInsertIndex(utf8.decode(indexFile.fileContent), db);
    final IndexTableData indexEntry = (await db.indexDao.getById(indexId))!;

    // create import context for parsing
    TermBankV3ParserContext? termImportContext;
    TermMetaBankV3ParserContext? termMetaImportContext;
    KanjiBankV3ParserContext? kanjiImportContext;
    KanjiMetaBankV3ParserContext? kanjiMetaImportContext;

    // parse the rest of the files (first tag bank, then the rest in sorted order)
    int progressCounter = 0;
    final int noEntries = dataSources.length;
    for (final ({String filePath, Uint8List fileContent}) data in dataSources) {

      progressCounter++;
      params.mainIsolateSendPort.send("Parsing ${data.filePath} ($progressCounter/$noEntries) ...");

      if(p.basename(data.filePath).contains(indexFileNamingScheme)) continue; // skip index file (already parsed)
      if(!validDictionaryFiles.any((scheme) => p.basename(data.filePath).contains(scheme))){
        params.mainIsolateSendPort.send("Copying ${data.filePath} to DB ...");
        await importMediaFile(data.filePath, data.fileContent, indexId, db, null);
        continue;
      }

      // manage import contexts
      termImportContext = await manageImportContext(termImportContext, data.filePath, termBankFileNamingScheme,
        () => TermBankV3ParserContext.create(db));
      termMetaImportContext = await manageImportContext(termMetaImportContext, data.filePath, termMetaBankFileNamingScheme,
        () => TermMetaBankV3ParserContext.create(db));
      kanjiImportContext = await manageImportContext(kanjiImportContext, data.filePath, kanjiBankFileNamingScheme,
        () => KanjiBankV3ParserContext.create(db, indexEntry.id));
      kanjiMetaImportContext = await manageImportContext(kanjiMetaImportContext, data.filePath, kanjiMetaBankFileNamingScheme,
        () => KanjiMetaBankV3ParserContext.create(db));
        
      await parseDictionaryFile(
        filePath: data.filePath,
        fileContent: utf8.decode(data.fileContent),
        importContext: [termImportContext, termMetaImportContext, kanjiImportContext, kanjiMetaImportContext]
          .nonNulls.firstOrNull,
        db: db,
        ind: indexEntry,
        addFullJsonDefinitions: params.addFullJsonDefinitions,
        mecab: mecab
      );
    }

    await optimizeDbAfterImport(db);
  }
  catch (e) {
    params.mainIsolateSendPort.send(e);
    params.mainIsolateSendPort.send(null);
  }

  // close mecab
  mecab.destroy();

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
  required Mecab mecab
}) async {
  
  // create config to pass the different arguments to the functions
  final parserConfig = {
    audioFileNamingScheme: () => parseAudio(fileContent, db, ind.id),
    kanjiMetaBankFileNamingScheme: () => parseKanjiMetaBankV3(fileContent, importContext as KanjiMetaBankV3ParserContext, db, ind.id),
    kanjiBankFileNamingScheme: () => parseKanjiBankV3(fileContent, importContext as KanjiBankV3ParserContext, db, ind.id),
    tagBankFileNamingScheme: () => parseTagBankv3(fileContent, db, ind.id),
    termMetaBankFileNamingScheme: () => parseTermMetaBankV3(fileContent, importContext as TermMetaBankV3ParserContext, db, ind.id, mecab),
    termBankFileNamingScheme: () => parseTermBankV3(fileContent, importContext as TermBankV3ParserContext, db, ind.id, addFullJsonDefinitions, mecab),
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
