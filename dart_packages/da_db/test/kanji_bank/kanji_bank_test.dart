
import 'package:da_db/database/da_db.dart';
import 'package:da_db/database/kanji/kanji_bank_v3_entry.dart';
import 'package:da_db/parsing/unified_staging_parser.dart';
import 'package:test/test.dart';
import 'package:universal_io/io.dart';

import '../../../shared_utils/lib/da_db_paths.dart';
import '../dictionary_test_variables.dart';
import '../test_utils/db_files.dart';
import '../test_utils/ignore_database_generated_data.dart';
import 'kanji_bank_test_cases.dart';

void main() {
  
  late DaDb db;
   setUpAll(() async {
     db = await setupFreshDB();
   });
   tearDownAll(() async {
     await db.close();
   });
  
  group('KanjiBankV3 Tests', () {
    // Check some kanji bank queries
    for (var testCase in kanjiBankTestCases) {
      test('Looking up $testCase', () async {
        Stopwatch s = Stopwatch()..start();
        List<KanjiBankV3Entry> result = (await db.kanjiBankV3Dao.search(testCase))
          .map((e) => kanjiBankEntryIgnoreDatabaseGeneratedData(e)).toList();
        print("Looking up $testCase took ${s.elapsedMilliseconds}ms");
        print("Actual: $result");
        print("Expected: $kanjiBankTestCaseExpectations");

        expect(result.isNotEmpty, true);
        for (var entry in result) {
          expect(kanjiBankTestCaseExpectations.contains(entry), true);
        }
      });
    }
  });

}

Future setupFreshDB() async {

  // create the testing database (delete any existing database)
  DaDb db = DaDb(
    dbPath: daDbTestPath, inMemory: true, languageProcessor: await japaneseProcessor);
  await db.clearDB();

  // convert the test files
  Stopwatch s = Stopwatch()..start();
  String dataSourceZipPath = await createTmpZip(Directory(yomitanSampleDictionaryPath));
  Stream<String> progress = await parseDaDbDataSource(
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
