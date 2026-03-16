import 'package:da_db/database/da_db.dart';
import 'package:da_db_shared/paths.dart';
import 'package:test/test.dart';

import '../test_utils/ignore_database_generated_data.dart';
import '../test_utils/setup_fresh_db.dart';
import 'example_stat_get_all_stats_test_cases.dart';
import 'example_stat_search_examples_base_form_test_cases.dart';
import 'example_stat_search_examples_fts_test_cases.dart';

void main() {
  late DaDb db;

  setUpAll(() async {
    db = await setupFreshDb(devExampleBank1Path, true, inMemory: true);
    await setupFreshDb(devExampleBank2Path, true, existingDb: db);
    await setupFreshDb(devExampleBank3Path, true, existingDb: db);
  });

  tearDownAll(() async {
    await db.close();
  });

  group('FTS5 Search with Stat Filtering & Sorting (Surface Form)', () {
    for (var i = 0; i < exampleSentencesStatFtsTestQueries.length; i++) {
      final testData = exampleSentencesStatFtsTestQueries[i];
      final query = testData.$1;
      final statName = testData.$2;
      final expectedStatValue = testData.$3;
      final applySort = testData.$4;
      final isDesc = testData.$5;
      
      final expected = exampleSentenceStatFtsTestExpectedValues[i];

      String testConfig = 'Default';
      if (statName != null) {
        if (expectedStatValue != null) {
          testConfig = 'Filter: $statName = $expectedStatValue';
        } else if (applySort) {
          testConfig = 'Sort: $statName ${isDesc ? "DESC" : "ASC"}';
        }
      }

      test('searchExamples: Returns expected results for "$query" [$testConfig]', () async {
        final results = await db.exampleDao.searchExamples(
          query,
          statName: statName,
          expectedStatValue: expectedStatValue,
          orderDescending: isDesc,
        );

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

  group('FTS5 Search with Stat Filtering & Sorting (Base Form)', () {
    for (var i = 0; i < exampleSentencesStatBaseFormsTestQueries.length; i++) {
      final testData = exampleSentencesStatBaseFormsTestQueries[i];
      final queryList = testData.$1;
      final requireAllTokens = testData.$2; // Unpack the new boolean
      final statName = testData.$3;
      final expectedStatValue = testData.$4;
      final applySort = testData.$5;
      final isDesc = testData.$6;
      
      final expected = exampleSentenceStatBaseFormsTestExpectedValues[i];

      // Add the AND/OR status to the test printout so you know exactly what failed
      String testConfig = requireAllTokens ? 'AND' : 'OR';
      if (statName != null) {
        if (expectedStatValue != null) {
          testConfig += ' | Filter: $statName = $expectedStatValue';
        } else if (applySort) {
          testConfig += ' | Sort: $statName ${isDesc ? "DESC" : "ASC"}';
        }
      }

      test('searchExamplesByBaseForms: Returns expected results for "$queryList" [$testConfig]', () async {
        final results = await db.exampleDao.searchExamplesByBaseForms(
          queryList,
          requireAllTokens: requireAllTokens, // Dynamically passed!
          statName: statName,
          expectedStatValue: expectedStatValue,
          orderDescending: isDesc,
        );

        if (expected == null) {
          expect(results, isNull, reason: "Query '$queryList' should have failed FTS5 syntax validation.");
        } else {
          expect(results, isNotNull, reason: "Query '$queryList' failed unexpectedly.");
          expect(results.length, expected.length);

          for (var j = 0; j < results.length; j++) {
            final actual = exampleSearchResultIgnoreDatabaseGeneratedData(results[j]);
            expect(actual, expected[j]);
          }
        }
      });
    }
  });

  group('Get All stats', () {
    test('getAllExampleStats returns expected stats', () async {
      final results = await db.exampleDao.getAllExampleStats();
      print("Expected stats: $getAllExampleStatsExpectation");
      print("Actual stats: ${results.map((e) => "${e.displayName} (${e.statName})").toList()}");

      expect(results.length, getAllExampleStatsExpectation.length);
      expect(results, getAllExampleStatsExpectation);
    });
  });
}