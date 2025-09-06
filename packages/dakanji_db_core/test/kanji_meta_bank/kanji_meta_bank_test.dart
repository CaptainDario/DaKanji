// Package imports:
import 'package:test/test.dart';
import 'package:universal_io/io.dart';

// Project imports:
import 'package:dakanji_db_core/database/dakanji_db.dart';
import 'package:dakanji_db_core/parsing/dictionary_parser.dart';
import 'package:dakanji_db_shared/paths.dart';
import 'kanji_meta_bank_test_values.dart';

void main() async {
  
  // create the testing database (delete any existing database)
  DaKanjiDB db = DaKanjiDB(path: dakanjiDbPath);
  db.clearDB();

  // convert the test files
  Stopwatch s = Stopwatch()..start();
  await parseDictionaryFolder(Directory(yomitanSampleDictionaryPath), db, false);
  print("Conversion took ${s.elapsedMilliseconds} ms");
  
  test('Test importing samples', () async {
    await testKanjiMetaBankV3(db);
  });

}

/// tests the kanjiMetaBankV3 import of the sample database from the yomitan dictionary
Future testKanjiMetaBankV3(DaKanjiDB db) async {
  // Check some kanji bank queries
  for (var testCase in kanjiMetaBankTetsCases) {
    Stopwatch s = Stopwatch()..start();
    List result = (await db.kanjiMetaBankV3Dao.getKanjiMetaBankEntriesFromKanji([testCase]))!;
    print("Looking up $testCase took ${s.elapsedMilliseconds}ms");
    print("testesrtaeta $result");

    expect(result.isNotEmpty, true);
    for (var entry in result) {
      expect(kanjiMetaBankTetsCaseExpectations.contains(entry), true);
    }
  }
}