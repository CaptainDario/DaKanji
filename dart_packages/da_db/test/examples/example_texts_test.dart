import 'package:da_db/database/da_db.dart';
import 'package:test/test.dart';

import '../../../shared_utils/lib/da_db_paths.dart';
import '../test_utils/ignore_database_generated_data.dart';
import '../test_utils/setup_fresh_db.dart';
import 'example_texts_test_cases.dart';

void main() {
  late DaDb db;

  setUpAll(() async {
    db = await setupFreshDb(devExampleTextsPath, true);
  });

  tearDownAll(() async {
    await db.close();
  });

  group("Test importing plain text example sentences", () {
    for (int i = 0; i < exampleTextTestQueries.length; i++) {
      test('Query: ${exampleTextTestQueries[i].$1}', () async {
      
        Stopwatch s = Stopwatch()..start();
        final queryTerms = exampleTextTestQueries[i].$1;
        
        final results = await db.exampleDao.searchExamples(queryTerms.first);
        
        print("Looking up '${queryTerms.first}' took ${s.elapsedMilliseconds}ms");

        expect(results, isNotNull, reason: "DAO returned null (syntax error) for query ${queryTerms.first}");
        expect(results!.isNotEmpty, true, reason: "DAO returned empty results for query ${queryTerms.first}");

        final result = results.first;
        final expected = exampleTextTestExpectedValues[i].first; 

        final resultForTesting = exampleSearchResultIgnoreDatabaseGeneratedData(result);

        if (resultForTesting != expected) {
          print("--- MISMATCH FOUND ---");
          print("EXPECTED: $expected");
          print("ACTUAL:   $resultForTesting");
        }
        
        expect(resultForTesting, expected, reason: "The parsed entry did not match the expected values.");
      });
    }
  });
}