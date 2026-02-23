import 'package:da_db/database/da_db.dart';
import 'package:da_db/parsing/yomitan_staging_db_parser.dart';
import 'package:da_db_shared/paths.dart';
import 'package:test/test.dart';
import 'package:universal_io/io.dart';

import '../dictionary_test_variables.dart';
import '../test_utils/db_files.dart';
import '../test_utils/ignore_database_generated_data.dart';
import 'term_meta_bank_test_cases.dart';

void main() {
  
  late DaKanjiDB db;
   setUpAll(() async {
     db = await setupFreshDB();
   });
   tearDownAll(() async {
     await db.close();
   });
  
  group('Term meta bank import test', () {
    // Check some kanji bank queries
    for (int i = 0; i < termMetaBankTestCases.length; i++) {
    
      test('should return correct metadata for "${termMetaBankTestCases[i]}"', () async {
        Stopwatch s = Stopwatch()..start();
        final testCase = termMetaBankTestCases[i];
        final result = (await db.termMetaBankV3Dao.searchTermMetaBankV3Entries(testCase))
            .map((e) => termMetaBankV3EntryIgnoreDatabaseGeneratedData(e))
            .toList();
        print("Looking up $testCase took ${s.elapsedMilliseconds}ms");

        print("\n\n$i: ${termMetaBankTestCases[i]}");
        for (var res in result) {
          print("Found element: $res");
        }
        expect(result.isNotEmpty , true);
        print("Expectaiton ${termMetaBankTestCaseExpectations[i]}");
        final pass = result.any((e) => termMetaBankTestCaseExpectations[i] == e);
        expect(pass, true);
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
  Stream<String> parsingProgress = await parseDictionaryDataSource(
    dataSourcePath: dataSourceZipPath,
    db: db,
    isDefaultDictionary: false
  );
  await for (final progress in parsingProgress) {
    print(progress);
  }
  
  print("Conversion took ${s.elapsedMilliseconds} ms");

  return db;
}