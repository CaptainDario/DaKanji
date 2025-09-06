// Package imports:
import 'package:dakanji_db_core/iso/iso_table.dart';
import 'package:test/test.dart';
import 'package:universal_io/io.dart';

// Project imports:
import 'package:dakanji_db_core/database/dakanji_db.dart';
import 'package:dakanji_db_core/parsing/dictionary_parser.dart';
import 'package:dakanji_db_shared/paths.dart';
import 'term_bank_test_values.dart';

void main() async {
  
  // create the testing database (delete any existing database)
  DaKanjiDB db = DaKanjiDB(path: dakanjiDbPath);
  db.clearDB();

  // convert the test files
  Stopwatch s = Stopwatch()..start();
  await parseDictionaryFolder(Directory(yomitanSampleDictionaryPath), db, true);
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
    expect(result, equals(termBankTestCaseExpectations[i])); 
  }
}
