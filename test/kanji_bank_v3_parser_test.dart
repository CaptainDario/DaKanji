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

    // create the testing database
    String dbPath = p.joinAll([Directory.current.path, "tmp", "dakanji_db.sqlite"]);
    DaKanjiDB db = DaKanjiDB(dbPath);
    print("Using database at $dbPath");

    // convert the test files
    await parseKanjiBankV3(File(jsonPath), db);

    // measure time for regression
    
    // check some entries    

  });
}
