
import 'package:da_db/database/da_db.dart';
import 'package:da_db/database/db_queries/kanji_dictionary_search/kanji_dictionary_search_result.dart';
import 'package:da_db/parsing/yomitan_staging_db_parser.dart';
import 'package:da_db_shared/paths.dart';
import 'package:path/path.dart' as p;
import 'package:test/test.dart';
import 'package:universal_io/io.dart';

import '../../dictionary_test_variables.dart';
import '../../test_utils/db_files.dart';
import '../../test_utils/ignore_database_generated_data.dart';
import 'kanji_dictionary_search_test_cases.dart';

void main() {
  
  late DaDb db;
  setUpAll(() async {
    db = await setupFreshDB();
  },);
  tearDownAll(() async {
    await db.close();
  },);

  group('KanjiBankV3 Tests', () {
    // Check some kanji bank queries
    for (int i = 0; i < kanjiDictionaryTestCases.length; i++) {
      final testCase = kanjiDictionaryTestCases[i];
      test('Looking up $testCase', () async {
        Stopwatch s = Stopwatch()..start();

        // setup the indexes
        for (var indexId in [1, 2])
          await db.indexDao.setEnabled(indexId, testCase.enabledIndexes.contains(indexId));
        await db.indexDao.setSortingOrders([1, 2], testCase.indexOrder);

        // run the actual search
        List<KanjiDictionarySearchResult> result =
          (await db.kanjiSearchDao.kanjiDictionarySearch(kanjis: testCase.query))
          .map((e) => kanjiDictionarySearchResultIgnoreDatabaseGeneratedData(e))
          .toList();
        print("Looking up $i took ${s.elapsedMilliseconds}ms");

        // 1. First, check that the number of results we got from the DB
        expect(result.length, equals(kanjiDictionarySearchTestCaseExpectations[i].length));

        for (int j = 0; j < result.length; j++) {
          final actualResult = result[j];
          final expectedResult = kanjiDictionarySearchTestCaseExpectations[i][j];
          print("Actual result: $actualResult");
          print("Expected kanji result: ${expectedResult.kanjiBankEntry}");
          print("Expected kanji meta result: ${expectedResult.kanjiMetaBankEntries}");

          // Compare the kanji bank entry
          expect(
            actualResult.kanjiBankEntry, 
            equals(expectedResult.kanjiBankEntry),
            reason: "KanjiBankV3Entry for '${actualResult.kanjiBankEntry.kanji}' did not match expectation."
          );

          // Compare the list of meta entries
          for (var l = 0; l < expectedResult.kanjiMetaBankEntries.length; l++) {
            expect(
              actualResult.kanjiMetaBankEntries[l],
              equals(expectedResult.kanjiMetaBankEntries[l]),
              reason: "KanjiMetaBankV3Entry at index $l for '${actualResult.kanjiBankEntry.kanji}' did not match expectation."
            ); 
          }
        }
      });
    }
  });

}

Future<DaDb> setupFreshDB() async {

  // create the testing database (delete any existing database)
  if (File(daDbTestPath).existsSync()) File(daDbTestPath).deleteSync();
  DaDb db = DaDb(
    dbPath: daDbTestPath, inMemory: true, languageProcessor: await japaneseProcessor);

  // import the yomitan test files
  Stopwatch s = Stopwatch()..start();
  String dataSourceZipPath = await createTmpZip(Directory(yomitanSampleDictionaryPath));
  Stream<String> progress = await parseDictionaryDataSource(
    dataSourcePath: dataSourceZipPath,
    db: db,
    isDefaultDictionary: false
  );
  await for (var line in progress) {
    print(line);
  }
  print("Conversion took ${s.elapsedMilliseconds} ms");

  // import the custom database
  s = Stopwatch()..start();
  await partialInit(db, (File f) => true, "term_search_test",
    otherFilesToCopy: [
      File(p.join(daDbDataFilesPath, "testing_db", "kanji_bank_1.json")),
      File(p.join(daDbDataFilesPath, "testing_db", "kanji_meta_bank_1.json")),
    ],
    isDefaultDictionary: true
  );

  return db;

}
