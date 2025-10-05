// Package imports:
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
Future parseDictionaryDataSource({
  String? dataSourcePath,
  Uint8List? archiveBytes,
  required DaKanjiDB db,
  required bool addFullJsonDefinitions,
  required Mecab mecab
}) async {

  assert(dataSourcePath != null);

  final connection = await db.attachedDatabase.serializableConnection();

  String libmecabPath = mecab.libmecabPath;
  String mecabDicPath = mecab.dictDir;

  // spawn isolate
  await Isolate.run(() async {
    await _parseDictionaryDataSource(
      dataSourcePath: dataSourcePath,
      archiveBytes: archiveBytes,
      dbConnection: connection,
      addFullJsonDefinitions: addFullJsonDefinitions,
      libmecabPath: libmecabPath,
      mecabDictDir: mecabDicPath
    );
  });

}

/// Actual implementation of the [_parseDictionaryDataSource] that runs in an
/// isolate
Future _parseDictionaryDataSource({
  String? dataSourcePath,
  Uint8List? archiveBytes,
  required DriftIsolate dbConnection,
  required bool addFullJsonDefinitions,
  required String libmecabPath,
  required String mecabDictDir,
}) async {

  final db = DaKanjiDB(executor: await dbConnection.connect());
  final mecab = Mecab()..init(libmecabPath, mecabDictDir, true);

  Iterable<({String fileName, String fileContent})> dataSource = dakanjiDBDataSourceIterator(
    archivePath: dataSourcePath,
    fileOrder: [indexFileNamingScheme, tagBankFileNamingScheme]
  );
  
  // parse the index file -> get dict index
  final indexFile = dataSource.first;
  int dictId = await parseIndex(indexFile.fileContent, db);
  final dictEntry = await db.indexDao.getById(dictId);

  // create import context for term bank parsing
  TermBankV3ParserImportContext? importContext;

  // parse the rest of the files (first tag bank, then the rest in sorted order)
  for (final ({String fileName, String fileContent}) data in dataSource) {

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
      addFullJsonDefinitions: addFullJsonDefinitions,
      mecab: mecab
    );
  }

  // Optimize db
  await db.customStatement('VACUUM;');
  await db.customStatement('ANALYZE;');

  // commit all changes to DB
  await db.customStatement("PRAGMA wal_checkpoint(TRUNCATE);");

  // close mecab
  mecab.destroy();

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
      print("Parsing $baseName as `$scheme`");
      await parserFunction();
      break;
    }
  }

}
