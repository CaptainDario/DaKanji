// Package imports:
import 'package:test/test.dart';
import 'package:universal_io/io.dart';

// Project imports:
import 'package:dakanji_db/database/dakanji_db.dart';
import 'package:dakanji_db/parsing/dictionary_parser.dart';
import '../bin/paths.dart';
import 'samples_test_values.dart';

void main() async {
  
  // create the testing database (delete any existing database)
  DaKanjiDB db = DaKanjiDB(path: dakanjiDbPath);
  await db.deleteDB();

  // convert the test files
  Stopwatch s = Stopwatch()..start();
  await parseDictionaryFolder(Directory(samplesPath), db);
  print("Conversion took ${s.elapsedMilliseconds} ms");
  
  test('Test importing samples', () async {
    //await testKanjiBankV3(db);
    //await testKanjiMetaBankV3(db);
    await testTermMetaBankV3(db);
  });

}

/// tests the kanjiBankV3 import of the sample database from the yomitan dictionary
Future testKanjiBankV3(DaKanjiDB db) async {
  // Check some kanji bank queries
  for (var testCase in kanjiBankTetsCases) {
    Stopwatch s = Stopwatch()..start();
    List result = (await db.kanjiBankV3Dao.getKanjiBankEntriesFromKanji([testCase]))!;
    print("Looking up $testCase took ${s.elapsedMilliseconds}ms");
    print(result);

    for (var entry in result) {
      expect(kanjiBankTetsCaseExpectations.contains(entry), true);
    }
  }
}

/// tests the kanjiMetaBankV3 import of the sample database from the yomitan dictionary
Future testKanjiMetaBankV3(DaKanjiDB db) async {
  // Check some kanji bank queries
  for (var testCase in kanjiMetaBankTetsCases) {
    Stopwatch s = Stopwatch()..start();
    List result = (await db.kanjiMetaBankV3Dao.getKanjiMetaBankEntriesFromKanji([testCase]))!;
    print("Looking up $testCase took ${s.elapsedMilliseconds}ms");
    print(result);

    for (var entry in result) {
      expect(kanjiMetaBankTetsCaseExpectations.contains(entry), true);
    }
  }
}

/// tests the kanjiMetaBankV3 import of the sample database from the yomitan dictionary
Future testTermMetaBankV3(DaKanjiDB db) async {
  // Check some kanji bank queries
  for (var testCase in termMetaBankTetsCases) {
    Stopwatch s = Stopwatch()..start();
    List result = (await db.kanjiMetaBankV3Dao.getKanjiMetaBankEntriesFromKanji([testCase]))!;
    print("Looking up $testCase took ${s.elapsedMilliseconds}ms");
    print(result);

    for (var entry in result) {
      expect(termMetaBankTetsCaseExpectations.contains(entry), true);
    }
  }
}
