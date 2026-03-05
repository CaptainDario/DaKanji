import 'package:da_db/database/da_db.dart';
import 'package:da_db_shared/paths.dart';
import 'package:test/test.dart';

import '../test_utils/ignore_database_generated_data.dart';
import '../test_utils/setup_fresh_db.dart';
import 'example_bank_token_test_cases.dart';

void main() {
  late DaDb db;

  setUpAll(() async {
    db = await setupFreshDb(devExampleSentencesPath);
  });

  tearDownAll(() async {
    await db.close();
  });

  group("Test direct token/term searches", () {
    
    // 1. Loop through and test the Term String searches
    for (int i = 0; i < exampleTokenTestQueries.length; i++) {
      test('Query (Term String): ${exampleTokenTestQueries[i].$1}', () async {
      
        Stopwatch s = Stopwatch()..start();
        
        final results = await db.exampleDao.searchExamplesByTermString(
          exampleTokenTestQueries[i].$1, 
          exampleTokenTestQueries[i].$2
        );
        
        print("Looking up term string '${exampleTokenTestQueries[i].$1}' took ${s.elapsedMilliseconds}ms");

        bool allFound = true;
        expect(results.isNotEmpty, true, reason: "DAO returned empty results for term string ${exampleTokenTestQueries[i].$1}");

        for (int j = 0; j < results.length; j++) {
          final result = results[j];
          final expected = exampleTokenTestExpectedValues[i][j];

          // Strip out DB-generated IDs for clean comparison
          final resultForTesting = exampleEntryIgnoreDatabaseGeneratedData(result);

          if (resultForTesting != expected) {
            allFound = false;
            print("--- MISMATCH FOUND ---");
            print("EXPECTED: $expected");
            print("ACTUAL:   $resultForTesting");
          }
        }
        
        expect(allFound, true);
      });
    }

    // 2. Test the Term ID search dynamically
    test('Query (Term ID): Fetch examples matching exact term ID', () async {
      final testQueryString = exampleTokenTestQueries[0].$1; // "リンゴ"
      final testQueryLang = exampleTokenTestQueries[0].$2;   // [Iso639_3.jpn]

      // Fetch the actual DB-generated ID for "リンゴ" using Drift's type-safe builder
      final termRecord = await (db.select(db.termTable)
        ..where((t) => t.term.equals(testQueryString))
        ..limit(1)
      ).getSingleOrNull();

      if (termRecord == null) {
        markTestSkipped("Term '$testQueryString' not found in DB during setup. Skipping ID search test.");
        return;
      }

      final termId = termRecord.id;
      
      Stopwatch s = Stopwatch()..start();
      
      final results = await db.exampleDao.searchExamplesByTermIds(
        [termId], 
        testQueryLang
      );
      
      print("Looking up term ID '$termId' took ${s.elapsedMilliseconds}ms");

      expect(results.isNotEmpty, true, reason: "DAO returned empty results for term ID $termId");

      // Verify it fetched the correct expected value
      final resultForTesting = exampleEntryIgnoreDatabaseGeneratedData(results.first);
      final expected = exampleTokenTestExpectedValues[0].first;
      
      expect(resultForTesting, expected);
    });
  });
}
