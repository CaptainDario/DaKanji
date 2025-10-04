// Package imports:
import 'package:mecab_for_dart/mecab_dart.dart';
import 'package:test/test.dart';
import 'package:universal_io/io.dart';

// Project imports:
import 'package:dakanji_db_core/database/dakanji_db.dart';
import 'package:dakanji_db_core/parsing/dictionary_parser.dart';
import 'package:dakanji_db_shared/paths.dart';
import 'kanji_meta_bank_test_cases.dart';

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
  
  await testKanjiMetaBankV3(db);

}

/// tests the kanjiMetaBankV3 import of the sample database from the yomitan dictionary
Future testKanjiMetaBankV3(DaKanjiDB db) async {

  group("Test importing kanji meta bank", () {
    // Check some kanji bank queries
    for (var testCase in kanjiMetaBankTetsCases) {
      test('Looking up $testCase', () async {
        Stopwatch s = Stopwatch()..start();
        List result = (await db.kanjiMetaBankV3Dao.getKanjiMetaBankEntriesFromKanji([testCase]))!;
        print("Looking up $testCase took ${s.elapsedMilliseconds}ms");
        print("testesrtaeta $result");

        expect(result.isNotEmpty, true);
        for (var entry in result) {
          expect(kanjiMetaBankTetsCaseExpectations.contains(entry), true);
        }
      });
    }
  });
}