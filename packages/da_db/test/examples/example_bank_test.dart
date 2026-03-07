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
    db = await setupFreshDb(devExampleSentencesPath, true, inMemory: false);
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

        expect(results.length, expected.length);

        for (var j = 0; j < results.length; j++) {
          final actual = exampleEntryIgnoreDatabaseGeneratedData(results[j]);
          expect(actual, expected[j]);
        }
      });
    }
  });

  group('Relational Token / Term Search', () {
    for (var i = 0; i < exampleTokenTestQueries.length; i++) {
      final termString = exampleTokenTestQueries[i].$1;
      final languages = exampleTokenTestQueries[i].$2;
      final expected = exampleTokenTestExpectedValues[i];

      test('searchExamplesByTermString returns expected results for "$termString"', () async {
        final results = await db.exampleDao.searchExamplesByTermString(termString, languages);

        expect(results.length, expected.length);

        for (var j = 0; j < results.length; j++) {
          final actual = exampleEntryIgnoreDatabaseGeneratedData(results[j]);
          expect(actual, expected[j]);
        }
      });
    }

    test('searchExamplesByTermIds returns expected results for exact ID', () async {
      final targetTerm = exampleTokenTestQueries.first.$1;
      final languages = exampleTokenTestQueries.first.$2;
      final expected = exampleTokenTestExpectedValues.first;

      // Fetch the DB-generated ID for the term
      final termRecord = await (db.select(db.termTable)
          ..where((t) => t.term.equals(targetTerm))
          ..limit(1))
        .getSingle();

      final resultsId = await db.exampleDao.searchExamplesByTermIds([termRecord.id], languages);
      final resultsTerm = await db.exampleDao.searchExamplesByTermString(termRecord.term, languages);

      expect(resultsId.length, expected.length);
      expect(resultsTerm.length, expected.length);

      for (var j = 0; j < resultsId.length; j++) {
        var actual = exampleEntryIgnoreDatabaseGeneratedData(resultsId[j]);
        expect(actual, expected[j]);
        actual = exampleEntryIgnoreDatabaseGeneratedData(resultsTerm[j]);
        expect(actual, expected[j]);
      }
    });
  });
}