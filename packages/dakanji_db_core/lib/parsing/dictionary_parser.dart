// Package imports:
import 'dart:typed_data';

import 'package:dakanji_db_core/parsing/audio/audio_parser.dart';
import 'package:dakanji_db_core/parsing/parsing_util.dart';
import 'package:mecab_for_dart/mecab_dart.dart';

import 'term/term_bank_v3_parser.dart';
import 'package:path/path.dart' as p;
import 'package:universal_io/io.dart';

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
Future parseDictionaryDataSource(String? dataSourcePath,
  DaKanjiDB db, bool addFullJsonDefinitions, Mecab mecab) async {
  
  assert(dataSourcePath != null);

  print(dataSourcePath);

  Iterable<({String fileName, String fileContent})> dataSource = dakanjiDBDataSourceIterator(
    archivePath: dataSourcePath,
    fileOrder: [indexFileNamingScheme, tagBankFileNamingScheme]
  );
  
  // parse the index file -> get dict index
  final indexFile = dataSource.first;
  int dictId = await parseIndex(indexFile.fileContent, db);
  final dictEntry = await db.indexDao.getById(dictId);

  for (final ({String fileName, String fileContent}) data in dataSource) {
    await parseDictionaryFile(
      fileName: data.fileName,
      fileContent: data.fileContent,
      db: db,
      ind: dictEntry!,
      addFullJsonDefinitions: addFullJsonDefinitions,
      mecab: mecab
    );
  }

}

/// Depending on the file name applies the correct parsing method
Future parseDictionaryFile({
  required String fileName,
  required String fileContent,
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
    termBankFileNamingScheme: () => parseTermBankV3(fileContent, db, ind.id, addFullJsonDefinitions, mecab),
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
