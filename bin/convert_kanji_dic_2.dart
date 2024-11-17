import 'package:dakanji_db/database/dakanji_db.dart';
import 'package:dakanji_db/parsing/dictionary_parser.dart';
import 'dart:io';
import 'package:path/path.dart' as p;



void main() async {
  
  // get path to the testing files
  String dictPath = p.joinAll([Directory.current.path, "samples"]);
  print("Reading json from $dictPath");

  // create the testing database (delete any existing database)
  String dbPath = p.joinAll([Directory.current.path, "tmp", "dakanji.db"]);
  if(File(dbPath).existsSync()){
    File(dbPath).deleteSync();
  }
  DaKanjiDB db = DaKanjiDB(path: dbPath);

  // convert the test files
  Stopwatch s = Stopwatch()..start();
  await parseDictionaryFolder(Directory(dictPath), db);
  print("Conversion took ${s.elapsedMilliseconds} ms");
  
  
  exit(0);

}
