// Package imports:
import 'package:dakanji_db/iso/iso_table.dart';
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
  await parseDictionaryFolder(Directory(devYomitanPath), db);
  print("Conversion took ${s.elapsedMilliseconds} ms");
  
  test('Test importing samples', () async {
    await testTermBankV3(db);
  });

}

/// tests the termBankV3 import of the sample database from the yomitan dictionary
Future testTermBankV3(DaKanjiDB db) async {
  // Check some kanji bank queries
  for (int i = 0; i < termBankTestCases.length; i++) {
    Stopwatch s = Stopwatch()..start();
    final testCase = termBankTestCases[i];
    final result = (await db.termBankV3Dao.searchTerm(testCase, [Iso639_1.en]));
    print("Looking up $testCase took ${s.elapsedMilliseconds}ms");

    print("\n\n$i: ${termBankTestCases[i]}");
    for (var res in result) {
      print(res);
    }
    expect(result.isNotEmpty , true);
    final pass = result.any((e) => termBankTestCaseExpectations[i] == e);
    expect(pass, true);
  }
}
