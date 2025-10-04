// Package imports:
import 'package:mecab_for_dart/mecab_dart.dart';
import 'package:test/test.dart';
import 'package:universal_io/io.dart';

// Project imports:
import 'package:dakanji_db_core/database/dakanji_db.dart';
import 'package:dakanji_db_core/parsing/dictionary_parser.dart';
import 'package:dakanji_db_shared/paths.dart';
import 'term_meta_bank_test_cases.dart';

void main() async {
  
  // create the testing database (delete any existing database)
  DaKanjiDB db = DaKanjiDB(path: dakanjiDbPath);
  db.clearDB();

  final mecab = Mecab();
  await mecab.init(mecabDynamicLibPath, mecabDicPath, true);

  // convert the test files
  Stopwatch s = Stopwatch()..start();
  await parseDictionaryDataSource(
    dataSourcePath: yomitanSampleDictionaryPath,
    db: db,
    addFullJsonDefinitions: false,
    mecab: mecab
  );
  print("Conversion took ${s.elapsedMilliseconds} ms");
  
  await testTermMetaBankV3(db);

}

/// tests the termMetaBankV3 import of the sample database from the yomitan dictionary
Future testTermMetaBankV3(DaKanjiDB db) async {
  
  group('Term meta bank import test', () {
    // Check some kanji bank queries
    for (int i = 0; i < termMetaBankTestCases.length; i++) {
    
      test('should return correct metadata for "${termMetaBankTestCases[i]}"', () async {
        Stopwatch s = Stopwatch()..start();
        final testCase = termMetaBankTestCases[i];
        final result = (await db.termMetaBankV3Dao.getTermMetaBankEntriesFromTerm(testCase));
        print("Looking up $testCase took ${s.elapsedMilliseconds}ms");

        print("\n\n$i: ${termMetaBankTestCases[i]}");
        for (var res in result) {
          print(res);
        }
        expect(result.isNotEmpty , true);
        final pass = result.any((e) => termMetaBankTestCaseExpectations[i] == e);
        expect(pass, true);
      });
    }
  });
}

