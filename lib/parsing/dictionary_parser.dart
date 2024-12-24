// Package imports:
import 'package:dakanji_db/parsing/term/term_bank_v3_parser.dart';
import 'package:path/path.dart' as p;
import 'package:tuple/tuple.dart';
import 'package:universal_io/io.dart';

// Project imports:
import 'package:dakanji_db/database/dakanji_db.dart';
import 'package:dakanji_db/parsing/index/index_parser.dart';
import 'package:dakanji_db/parsing/kanji/kanji_bank_v3_parser.dart';
import 'package:dakanji_db/parsing/kanji_meta/kanji_meta_bank_v3_parser.dart';
import 'package:dakanji_db/parsing/tag/tag_bank_v3_parser.dart';
import 'package:dakanji_db/parsing/term_meta/term_meta_bank_v3_parser.dart';

/// A list containing the names of files that are valid yomtain files
List<String> validDictionaryFiles = [
  indexFile,
  tagBankFile,
  kanjiBankFile, kanjiMetaBankFile,
  termBankFile, termMetaBankFile
];

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
Future parseDictionaryZip (File dictZip, DaKanjiDB db) async {



}


/// Parses the given yomitan dictionary folder
Future parseDictionaryFolder(Directory dictDir, DaKanjiDB db) async {

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

  // parse the kanji bank files
  for (var file in validFiles) {
    await parseDictionaryFile(Tuple3(file, db, dictEntry!));
  }

}

/// Depending on the file name applies the correct conversion method
Future parseDictionaryFile(Tuple3<File, DaKanjiDB, IndexTableData> args) async {

  File dictFile = args.item1;
  DaKanjiDB db = args.item2;
  IndexTableData ind = args.item3;

  // TODO parse audio files

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
    await parseTermBankV3File(dictFile, db, ind.id); 
  }

  // parse `term_meta_bank`-files
  if(p.basename(dictFile.path).contains(termMetaBankFile)){
    print("Parsing ${p.basename(dictFile.path)} as `$termMetaBankFile`");
    await parseTermMetaBankV3File(dictFile, db, ind.id); 
  }

}
