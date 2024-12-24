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
  db.clearDB();

  // convert the test files
  Stopwatch s = Stopwatch()..start();
  await parseDictionaryFolder(Directory(samplesPath), db);
  print("Conversion took ${s.elapsedMilliseconds} ms");
  
  test('Test importing samples', () async {
    //await testKanjiBankV3(db);
    //await testKanjiMetaBankV3(db);
    //await testTermMetaBankV3(db);
    await testTermBankV3(db);
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

    expect(result.isNotEmpty, true);
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
    print("testesrtaeta $result");

    expect(result.isNotEmpty, true);
    for (var entry in result) {
      expect(kanjiMetaBankTetsCaseExpectations.contains(entry), true);
    }
  }
}

/// tests the termMetaBankV3 import of the sample database from the yomitan dictionary
Future testTermMetaBankV3(DaKanjiDB db) async {
  // Check some kanji bank queries
  for (int i = 0; i < termMetaBankTetsCases.length; i++) {
    Stopwatch s = Stopwatch()..start();
    final testCase = termMetaBankTetsCases[i];
    final result = (await db.termMetaBankV3Dao.getTermMetaBankEntriesFromTerm(testCase));
    print("Looking up $testCase took ${s.elapsedMilliseconds}ms");

    print("\n\n$i: ${termMetaBankTetsCases[i]}");
    for (var res in result) {
      print(res);
    }
    expect(result.isNotEmpty , true);
    final pass = result.any((e) => termMetaBankTetsCaseExpectations[i] == e);
    expect(pass, true);
  }
}

/// tests the termBankV3 import of the sample database from the yomitan dictionary
Future testTermBankV3(DaKanjiDB db) async {
  // Check some kanji bank queries
  for (int i = 0; i < termBankTetsCases.length; i++) {
    Stopwatch s = Stopwatch()..start();
    final testCase = termBankTetsCases[i];
    final result = (await db.termBankV3Dao.getTermBankEntriesFromTerm(testCase));
    print("Looking up $testCase took ${s.elapsedMilliseconds}ms");

    print("\n\n$i: ${termBankTetsCases[i]}");
    for (var res in result) {
      print(res);
    }
    expect(result.isNotEmpty , true);
    final pass = result.any((e) => termBankTetsCaseExpectations[i] == e);
    expect(pass, true);
  }
}
