import 'package:dakanji_db/database/dakanji_db.dart';
import 'package:dakanji_db/parsing/kanji/kanji_bank_v3_parser.dart';
import 'package:test/test.dart';
import 'dart:io';
import 'package:path/path.dart' as p;



void main() {
  test('Test importing kanjidic 2', () async {
    
    // get path to the testing files
    String jsonPath = p.joinAll([Directory.current.path, "samples",
      "KANJIDIC_english", "kanji_bank_2.json"]);
    print("Reading json from $jsonPath");

    // create the testing database (delete any existing database)
    String dbPath = p.joinAll([Directory.current.path, "tmp", "dakanji.db"]);
    if(File(dbPath).existsSync()){
      File(dbPath).deleteSync();
    }
    DaKanjiDB db = DaKanjiDB(dbPath);
    print("Using database at $dbPath");

    // convert the test files
    Stopwatch s = Stopwatch()..start();
    await parseKanjiBankV3(File(jsonPath), db);
    print("Conversion took ${s.elapsedMilliseconds} ms");
    
    // TODO check some entries    

  });
}
