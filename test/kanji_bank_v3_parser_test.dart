import 'package:dakanji_db/database/dakanji_db.dart';
import 'package:dakanji_db/parsing/kanji/kanji_bank_v3_parser.dart';
import 'package:test/test.dart';
import 'dart:io';
import 'package:path/path.dart' as p;



void main() {
  test('Test importing kanji_bank_2.json', () async {
    
    // get path to the testing files
    String jsonPath = p.joinAll([Directory.current.path, "samples", "kanji_bank_1.json"]);
    print("Reading json from $jsonPath");

    // create the testing database (delete any existing database)
    String dbPath = p.joinAll([Directory.current.path, "tmp", "dakanji.db"]);
    if(File(dbPath).existsSync()){
      File(dbPath).deleteSync();
    }
    DaKanjiDB db = DaKanjiDB(path: dbPath);
    print("Using database at $dbPath");

    // convert the test files
    Stopwatch s = Stopwatch()..start();
    await parseKanjiBankV3(File(jsonPath), db, 0);
    print("Conversion took ${s.elapsedMilliseconds} ms");
    
    // TODO check some entries    

  });
}
