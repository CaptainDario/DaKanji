import 'package:da_db/database/da_db.dart';
import 'package:da_db_shared/paths.dart';
import 'package:test/test.dart';

import '../test_utils/ignore_database_generated_data.dart';
import '../test_utils/setup_fresh_db.dart';
import 'example_bank_test_cases.dart';

void main() {
  late DaDb db;

  setUpAll(() async {
    db = await setupFreshDb(devExampleSentencesPath);
  });

  tearDownAll(() async {
    await db.close();
  });

  group("Test importing example sentences", () {
    for (int i = 0; i < exampleSentencesTestQueries.length; i++) {
      test('Query: ${exampleSentencesTestQueries[i].$1}', () async {
      
        Stopwatch s = Stopwatch()..start();
        
        final results = await db.exampleDao.searchExamples(
          exampleSentencesTestQueries[i].$1, 
          exampleSentencesTestQueries[i].$2
        );
        
        print("Looking up '${exampleSentencesTestQueries[i].$1}' took ${s.elapsedMilliseconds}ms");

        bool allFound = true;
        expect(results.isNotEmpty, true, reason: "DAO returned empty results for query ${exampleSentencesTestQueries[i].$1}");

        for (int j = 0; j < results.length; j++) {
          final result = results[j];
          final expected = exampleSentenceTestExpectedValues[i][j];

          // Use the utility to strip out DB-generated IDs!
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
  });
}
