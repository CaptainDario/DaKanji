// Package imports:
import 'package:mecab_for_dart/mecab_dart.dart';
import 'package:test/test.dart';
import 'package:universal_io/io.dart';

// Project imports:
import 'package:dakanji_db_core/database/dakanji_db.dart';
import 'package:dakanji_db_core/parsing/dictionary_parser.dart';
import 'package:dakanji_db_shared/paths.dart';
import '../util/db_files.dart';
import 'kanji_bank_test_cases.dart';

void main() async {
  
  // create the testing database (delete any existing database)
  DaKanjiDB db = DaKanjiDB(dbPath: dakanjiDbPath);
  await db.clearDB();

  final mecab = Mecab();
  await mecab.init(mecabDynamicLibPath, mecabDicPath, true);

  // convert the test files
  Stopwatch s = Stopwatch()..start();
  String dataSourceZipPath = await createTmpZip(Directory(yomitanSampleDictionaryPath));
  Stream<String> progress = await parseDictionaryDataSource(
    dataSourcePath: dataSourceZipPath,
    db: db,
    addFullJsonDefinitions: false,
    mecab: mecab
  );
  await for (var line in progress) {
    print(line);
  }
  print("Conversion took ${s.elapsedMilliseconds} ms");
  
  await testKanjiBankV3(db);

}

/// tests the kanjiBankV3 import of the sample database from the yomitan dictionary
Future testKanjiBankV3(DaKanjiDB db) async {
  group('KanjiBankV3 Tests', () {
    // Check some kanji bank queries
    for (var testCase in kanjiBankTestCases) {
      test('Looking up $testCase', () async {
        Stopwatch s = Stopwatch()..start();
        List result = (await db.kanjiBankV3Dao.search(testCase))!;
        print("Looking up $testCase took ${s.elapsedMilliseconds}ms");
        print(result);

        expect(result.isNotEmpty, true);
        for (var entry in result) {
          expect(kanjiBankTestCaseExpectations.contains(entry), true);
        }
      });
    }
  });
}
