// Package imports:
import 'package:test/test.dart';
import 'package:universal_io/io.dart';

// Project imports:
import 'package:dakanji_db_core/database/dakanji_db.dart';
import 'package:dakanji_db_core/parsing/dictionary_parser.dart';
import 'package:dakanji_db_shared/paths.dart';
import 'kanji_bank_test_cases.dart';

void main() async {
  
  // create the testing database (delete any existing database)
  DaKanjiDB db = DaKanjiDB(path: dakanjiDbPath);
  db.clearDB();

  // convert the test files
  Stopwatch s = Stopwatch()..start();
  await parseDictionaryFolder(Directory(yomitanSampleDictionaryPath), db, false);
  print("Conversion took ${s.elapsedMilliseconds} ms");
  
  test('Test importing samples', () async {
    await testKanjiBankV3(db);
  });

}

/// tests the kanjiBankV3 import of the sample database from the yomitan dictionary
Future testKanjiBankV3(DaKanjiDB db) async {
  // Check some kanji bank queries
  for (var testCase in kanjiBankTetsCases) {
    Stopwatch s = Stopwatch()..start();
    List result = (await db.kanjiBankV3Dao.getKanjiBankEntriesFromKanji(testCase))!;
    print("Looking up $testCase took ${s.elapsedMilliseconds}ms");
    print(result);

    expect(result.isNotEmpty, true);
    for (var entry in result) {
      expect(kanjiBankTestCaseExpectations.contains(entry), true);
    }
  }
}
