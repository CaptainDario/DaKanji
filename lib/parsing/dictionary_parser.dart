import 'dart:io';
import 'package:dakanji_db/database/dakanji_db.dart';
import 'package:dakanji_db/parsing/index/index_parser.dart';
import 'package:dakanji_db/parsing/kanji/kanji_bank_v3_parser.dart';
import 'package:dakanji_db/parsing/tag/tag_bank_v3_parser.dart';
import 'package:path/path.dart' as p;
import 'package:tuple/tuple.dart';



/// A list containing the names of files that are valid yomtain files
List<String> validDictionaryFiles = [
  indexFile,
  tagBankFile,
  kanjiBankFile,
];

/// The name of the dictionary index file
String indexFile = "index.json";
/// The naming patter for kanji bank terms
String kanjiBankFile = "kanji_bank";
/// The naming patter for tag bank terms
String tagBankFile = "tag_bank";

/// Parses the given yomitan dictionary zip
Future parseDictionaryZip (File dictZip, DaKanjiDB db) async {

  // TODO implement

}


/// Parses the given yomitan dictionary folder
Future parseDictionaryFolder(Directory dictDir, DaKanjiDB db) async {

  /// Get all files from the given folder that can be parsed
  List<File> validFiles = dictDir.listSync().where((f) => 
    f.statSync().type == FileSystemEntityType.file &&
    validDictionaryFiles.any((ext) => p.basename(f.path).contains(ext))
  )
  .map((f) => File(f.path)).toList();
  //print("Found the following files that can be imported: \n$validFiles");

  // parse the index file -> get dict index
  int dictId = await parseIndex(
    validFiles.where((e) => p.basename(e.path) == indexFile).first,
    db
  );
  final dictEntry = await db.indexDao.getById(dictId);
  
  // parse the tags
  Iterable<File> tagFiles = validFiles.where((e) => p.basename(e.path).contains(tagBankFile));
  for (var tagFile in tagFiles) {
    await parseTagBankv3(tagFile, db);
  }

  // parse the remaining files
  for (var file in validFiles) {
    await parseDictionaryFile(Tuple3(file, db, dictEntry!));
  }

}

/// Depending on the file name applies the correct conversion method
Future parseDictionaryFile(Tuple3<File, DaKanjiDB, IndexTableData> args) async {

  File dictFile = args.item1;
  DaKanjiDB db = args.item2;
  IndexTableData ind = args.item3;

  // parse all files that are `kanji_bank`
  if(p.basename(dictFile.path).contains(kanjiBankFile)){

    print("Parsing ${p.basename(dictFile.path)} as `$kanjiBankFile`");
    await parseKanjiBankV3(dictFile, db, ind.id);
    
  }
  // TODO other dictionary file types

}