import 'dart:io';

import 'package:dakanji_db_core/database/dakanji_db.dart';
import 'package:dakanji_db_core/parsing/yomitan_staging_db_parser.dart';
import 'package:dakanji_db_shared/paths.dart';
import 'package:test/test.dart';

import '../dictionary_test_variables.dart';
import '../test_utils/db_files.dart';
import '../test_utils/ignore_database_generated_data.dart';
import 'kanji_meta_bank_test_cases.dart';

void main() {
  
  late DaKanjiDB db;
   setUpAll(() async {
     db = await setupFreshDB();
   });
   tearDownAll(() async {
     await db.close();
   });
  
  group("Test importing kanji meta bank", () {
    // Check some kanji bank queries
    for (var testCase in kanjiMetaBankTetsCases) {
      test('Looking up $testCase', () async {
        Stopwatch s = Stopwatch()..start();
        List result = (await db.kanjiMetaBankV3Dao.search(testCase))
          .map((e) => kanjiMetaBankEntryIgnoreDatabaseGeneratedData(e)).toList();
        print("Looking up $testCase took ${s.elapsedMilliseconds}ms");
        print("result $result");
        print("Expectation $kanjiMetaBankTetsCaseExpectations");

        expect(result.isNotEmpty, true);
        for (var entry in result) {
          expect(kanjiMetaBankTetsCaseExpectations.contains(entry), true);
        }
      });
    }
  });

}

Future<DaKanjiDB> setupFreshDB() async {

  // create the testing database (delete any existing database)
  if (File(dakanjiDbTestPath).existsSync()) File(dakanjiDbTestPath).deleteSync();
  DaKanjiDB db = DaKanjiDB(
    dbPath: dakanjiDbTestPath, inMemory: true, languageProcessor: await japaneseProcessor);

  // convert the test files
  Stopwatch s = Stopwatch()..start();
  String dataSourceZipPath = await createTmpZip(Directory(yomitanSampleDictionaryPath));
  Stream progress = await parseDictionaryDataSource(
    dataSourcePath: dataSourceZipPath,
    db: db,
    isDefaultDictionary: false
  );
  await for (var line in progress) {
    print(line);
  }
  print("Conversion took ${s.elapsedMilliseconds} ms");

  return db;

}

