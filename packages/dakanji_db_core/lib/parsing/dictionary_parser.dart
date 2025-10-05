// Package imports:
import 'dart:async';
import 'dart:isolate';
import 'dart:typed_data';

import 'package:dakanji_db_core/parsing/audio/audio_parser.dart';
import 'package:dakanji_db_core/parsing/parsing_util.dart';
import 'package:dakanji_db_core/parsing/term/term_bank_v3_parser_import_context.dart';
import 'package:drift/isolate.dart';
import 'package:mecab_for_dart/mecab_dart.dart';

import 'term/term_bank_v3_parser.dart';
import 'package:path/path.dart' as p;

// Project imports:
import '/database/dakanji_db.dart';
import '/parsing/index/index_parser.dart';
import '/parsing/kanji/kanji_bank_v3_parser.dart';
import '/parsing/kanji_meta/kanji_meta_bank_v3_parser.dart';
import '/parsing/tag/tag_bank_v3_parser.dart';
import '/parsing/term_meta/term_meta_bank_v3_parser.dart';

/// A list containing the names of files that are valid yomtain files
List<String> validDictionaryFiles = [
  audioFileNamingScheme,
  indexFileNamingScheme,
  tagBankFileNamingScheme,
  kanjiBankFileNamingScheme, kanjiMetaBankFileNamingScheme,
  termBankFileNamingScheme, termMetaBankFileNamingScheme

];
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

  // Use a completer to wait for the isolate to finish
  final StreamController<String> controller = StreamController();

  /// get parameters for isolate and spawn it
  final connection = await db.attachedDatabase.serializableConnection();
  String libmecabPath = mecab.libmecabPath;
  String mecabDicPath = mecab.dictDir;

  // setup isolate communication
  ReceivePort receivePort = ReceivePort();
  receivePort.listen((message) {
    if(message is String) controller.add(message);
    else if(message == null) {
      receivePort.close();
      controller.close();
    }
  });

  await Isolate.spawn(_parseDictionaryDataSource, (
    dataSourcePath: dataSourcePath,
    archiveBytes: archiveBytes,
    dbConnection: connection,
    addFullJsonDefinitions: addFullJsonDefinitions,
    libmecabPath: libmecabPath,
    mecabDictDir: mecabDicPath,
    mainIsolateSendPort: receivePort.sendPort
  ));

  return controller.stream;

}

/// Actual implementation of the [_parseDictionaryDataSource] that runs in an
/// isolate.
Future _parseDictionaryDataSource(({
  String? dataSourcePath,
  Uint8List? archiveBytes,
  DriftIsolate dbConnection,
  bool addFullJsonDefinitions,
  String libmecabPath,
  String mecabDictDir,
  SendPort mainIsolateSendPort
}) params) async {

  final db = DaKanjiDB(executor: await params.dbConnection.connect());
  final mecab = Mecab();
  await mecab.init(params.libmecabPath, params.mecabDictDir, true);

  Iterable<({String fileName, String fileContent})> dataSources = dakanjiDBDataSourceIterator(
    archivePath: params.dataSourcePath,
    fileOrder: [indexFileNamingScheme, tagBankFileNamingScheme]
  );
  
  // parse the index file -> get dict index
  final indexFile = dataSources.first;
  int dictId = await parseIndex(indexFile.fileContent, db);
  final dictEntry = await db.indexDao.getById(dictId);

  // create import context for term bank parsing
  TermBankV3ParserImportContext? importContext;

  // parse the rest of the files (first tag bank, then the rest in sorted order)
  int progressCounter = 2;
  for (final ({String fileName, String fileContent}) data in dataSources) {

    params.mainIsolateSendPort.send("Parsing ${data.fileName} ($progressCounter/${dataSources.length}) ...");

    // As the tags are parsed first, create the import context when parsing the
    // the first term bank file
    if (importContext == null && data.fileName.contains(termBankFileNamingScheme)) 
      importContext = await TermBankV3ParserImportContext.create(db);

    await parseDictionaryFile(
      fileName: data.fileName,
      fileContent: data.fileContent,
      importContext: importContext,
      db: db,
      ind: dictEntry!,
      addFullJsonDefinitions: params.addFullJsonDefinitions,
      mecab: mecab
    );

    progressCounter++;
  }

  // Optimize db
  await db.customStatement('VACUUM;');
  await db.customStatement('ANALYZE;');

  // commit all changes to DB
  await db.customStatement("PRAGMA wal_checkpoint(TRUNCATE);");

  // close mecab
  mecab.destroy();

  // close isolate communication
  params.mainIsolateSendPort.send(null);

}

/// Depending on the file name applies the correct parsing method
Future parseDictionaryFile({
  required String fileName,
  required String fileContent,
  required TermBankV3ParserImportContext? importContext,
  required DaKanjiDB db,
  required IndexTableData ind,
  required bool addFullJsonDefinitions,
  required Mecab mecab
}) async {

  // create config to pass the different arguments to the functions
  final parserConfig = {
    audioFileNamingScheme: () => parseAudio(fileContent, db, ind.id),
    kanjiBankFileNamingScheme: () => parseKanjiBankV3(fileContent, db, ind.id),
    kanjiMetaBankFileNamingScheme: () => parseKanjiMetaBankV3(fileContent, db, ind.id),
    tagBankFileNamingScheme: () => parseTagBankv3(fileContent, db),
    termBankFileNamingScheme: () => parseTermBankV3(fileContent, importContext!, db, ind.id, addFullJsonDefinitions, mecab),
    termMetaBankFileNamingScheme: () => parseTermMetaBankV3(fileContent, db, ind.id),
  };

  final baseName = p.basename(fileName);
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
