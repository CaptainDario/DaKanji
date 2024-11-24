import 'package:dakanji_db/database/dakanji_db.dart';
import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:tuple/tuple.dart';



/// Enum for the different dictionaries that can be converted
enum ConversionTarget {

  sample,
  stressKanji

}

/// Helper function that sets up the conversion for testing / dev purposes
Tuple2<Directory, DaKanjiDB> setupConversion(ConversionTarget c) {
  
  // get path to the testing files
  String dictPath = "";
  switch (c) {
    case ConversionTarget.sample:
      dictPath = p.joinAll([Directory.current.path, "samples"]);
      break;
    case ConversionTarget.stressKanji:
      dictPath = p.joinAll([Directory.current.path, "stresstest", "KANJIDIC_english"]);
      break;
  }

  // create the testing database (delete any existing database)
  String dbPath = p.joinAll([Directory.current.path, "tmp", "dakanji.db"]);
  if(File(dbPath).existsSync()){
    File(dbPath).deleteSync();
  }
  DaKanjiDB db = DaKanjiDB(path: dbPath);

  return Tuple2(Directory(dictPath), db);  

}
