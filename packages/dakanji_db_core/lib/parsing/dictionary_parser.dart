// Package imports:
import 'package:dakanji_db_core/parsing/audio/audio_parser.dart';
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
  audioFile,
  indexFile,
  tagBankFile,
  kanjiBankFile, kanjiMetaBankFile,
  termBankFile, termMetaBankFile
];

String audioFile = "audio_list";
/// The name of the dictionary index files
String indexFile = "index.json";
/// The naming pattern for tag bank files
String tagBankFile = "tag_bank";
/// The naming pattern for kanji bank files
String kanjiBankFile = "kanji_bank";
/// the naming pattern for kanji meta bank files
String kanjiMetaBankFile = "kanji_meta_bank";
/// the naming pattern for term bank terms
String termBankFile = "term_bank";
/// the naming pattern for term meta bank files
String termMetaBankFile = "term_meta_bank";

/// Parses the given yomitan dictionary zip
Future parseDictionaryZip (File dictZip, DaKanjiDB db, Mecab mecab) async {

  // TODO

}


/// Parses the given yomitan dictionary folder
Future parseDictionaryFolder(Directory dictDir, DaKanjiDB db, bool addFullJsonDefinitions, Mecab mecab) async {

  /// Get all files from the given folder that can be parsed
  List<File> validFiles = dictDir.listSync().where((f) => 
    f.statSync().type == FileSystemEntityType.file &&
    validDictionaryFiles.any((ext) => p.basename(f.path).contains(ext))
  )
  .map((f) => File(f.path)).toList();

  // parse the index file -> get dict index
  int dictId = await parseIndexFile(
    validFiles.where((e) => p.basename(e.path) == indexFile).first,
    db
  );
  final dictEntry = await db.indexDao.getById(dictId);
  
  // parse the tags
  Iterable<File> tagFiles = validFiles.where((e) => p.basename(e.path).contains(tagBankFile));
  for (var tagFile in tagFiles) {
    await parseTagBankV3File(tagFile, db);
  }

  for (var file in validFiles) {
    await parseDictionaryFile(
      dictFile: file,
      db: db,
      ind: dictEntry!,
      addFullJsonDefinitions: addFullJsonDefinitions,
      mecab: mecab
    );
  }

}

/// Depending on the file name applies the correct parsing method
Future parseDictionaryFile({
  required File dictFile,
  required DaKanjiDB db,
  required IndexTableData ind,
  required bool addFullJsonDefinitions,
  required Mecab mecab
}) async {


  // parse audio files
  if(p.basename(dictFile.path).contains("audio_list")){
    print("Parsing ${p.basename(dictFile.path)} as `audio`");
    await parseAudioFile(dictFile, db, ind.id); 
  }

  // parse `kanji_bank`-files
  if(p.basename(dictFile.path).contains(kanjiBankFile)){
    print("Parsing ${p.basename(dictFile.path)} as `$kanjiBankFile`");
    await parseKanjiBankV3File(dictFile, db, ind.id); 
  }

  // parse `kanji_meta_bank`-files
  if(p.basename(dictFile.path).contains(kanjiMetaBankFile)){
    print("Parsing ${p.basename(dictFile.path)} as `$kanjiMetaBankFile`");
    await parseKanjiMetaBankV3File(dictFile, db, ind.id); 
  }

  // parse `term_bank`-files
  if(p.basename(dictFile.path).contains(termBankFile)){
    print("Parsing ${p.basename(dictFile.path)} as `$termBankFile`");
    await parseTermBankV3File(dictFile, db, ind.id, addFullJsonDefinitions, mecab); 
  }

  // parse `term_meta_bank`-files
  if(p.basename(dictFile.path).contains(termMetaBankFile)){
    print("Parsing ${p.basename(dictFile.path)} as `$termMetaBankFile`");
    await parseTermMetaBankV3File(dictFile, db, ind.id); 
  }

}
