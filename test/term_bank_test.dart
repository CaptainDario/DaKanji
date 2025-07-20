// Package imports:
import 'package:test/test.dart';
import 'package:universal_io/io.dart';

// Project imports:
import 'package:dakanji_db/database/dakanji_db.dart';
import 'package:dakanji_db/parsing/dictionary_parser.dart';
import '../bin/paths.dart';
import 'term_bank_test_values.dart';

void main() async {
  
  // create the testing database (delete any existing database)
  DaKanjiDB db = DaKanjiDB(path: dakanjiDbPath);
  db.clearDB();

  // convert the test files
  Stopwatch s = Stopwatch()..start();
  await parseDictionaryFolder(Directory(samples_exampleSentencesPath), db);
  print("Conversion took ${s.elapsedMilliseconds} ms");
  
  test('Test importing samples', () async {
    await testTermMetaBankV3(db);
    await testTermBankV3(db);
  });

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
    final result = null;
      // TODO termBank test
      //(await db.termBankV3Dao.getTermBankEntriesFromTerm(testCase));
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
