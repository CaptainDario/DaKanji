import 'package:da_db/database/da_db.dart';
import 'package:da_db_shared/paths.dart';
import 'package:test/test.dart';

import '../test_utils/ignore_database_generated_data.dart';
import '../test_utils/setup_fresh_db.dart';
import 'example_bank_fts_test_cases.dart';
import 'example_bank_token_test_cases.dart';

void main() {
  late DaDb db;

  setUpAll(() async {
    db = await setupFreshDb(devExampleBank1Path, true, inMemory: false);
  });

  tearDownAll(() async {
    await db.close();
  });

  group('FTS5 Search (better-trigram)', () {
    for (var i = 0; i < exampleSentencesTestQueries.length; i++) {
      final query = exampleSentencesTestQueries[i].$1;
      final languages = exampleSentencesTestQueries[i].$2;
      final expected = exampleSentenceTestExpectedValues[i];

      test('Returns expected FTS results for "$query"', () async {
        final results = await db.exampleDao.searchExamples(query, languages);

        if (expected == null) {
          expect(results, isNull, reason: "Query '$query' should have failed FTS5 syntax validation.");
        } else {
          expect(results, isNotNull, reason: "Query '$query' failed unexpectedly.");
          expect(results!.length, expected.length);

          for (var j = 0; j < results.length; j++) {
            final actual = exampleSearchResultIgnoreDatabaseGeneratedData(results[j]);
            expect(actual, expected[j]);
          }
        }
      });
    }
  });

  group('Lemmatized Token Search', () {
    for (var i = 0; i < exampleTokenTestQueries.length; i++) {
      final terms = exampleTokenTestQueries[i].$1; 
      final languages = exampleTokenTestQueries[i].$2;
      final expected = exampleTokenTestExpectedValues[i]!;

      test('searchExamplesByTokens returns expected results for "$terms"', () async {
        // UPDATED: Now points to the new unicode61 FTS architecture
        final results = await db.exampleDao.searchExamplesByTokens(terms, languages);
        
        expect(results.length, expected.length);

        for (var j = 0; j < results.length; j++) {
          final actual = exampleSearchResultIgnoreDatabaseGeneratedData(results[j]);
          expect(actual, expected[j]);
        }
      });
    }
  });
}