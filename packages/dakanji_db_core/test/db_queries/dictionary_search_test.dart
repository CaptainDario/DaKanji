// term_search_test.dart

import 'dart:io';

import 'package:dakanji_db_core/database/db_queries/dictionary_search_result.dart';
import 'package:dakanji_db_shared/dakanji_db_shared.dart';
import 'package:language_processing/iso/iso_table.dart';
import 'package:test/test.dart';
import 'package:path/path.dart' as p;

import 'package:dakanji_db_core/database/dakanji_db.dart';

import '../util/db_files.dart';
import 'dictionary_search_test_cases.dart';

/// UPDATED: Custom matcher that verifies a `DictionarySearchResult` object.
///
/// It checks the `match` text and the nested `entry`'s term, reading,
/// and the simple `List<String>` of definitions.
Matcher matchesSearchResult(ExpectedSearchResult expected) {
  return isA<DictionarySearchResult>()
      .having((res) => res.match, 'match', expected.match)
      .having((res) => res.entry.term, 'entry.term', expected.term)
      .having((res) => res.entry.reading, 'entry.reading', expected.reading)
      // This is the corrected line, using your provided structure.
      .having((res) => res.entry.definitions, 'entry.definitions', orderedEquals(expected.definitions));
}

final List<SearchTestCase> testCases = [...termSearchTestCases];

void main() async {
  late DaKanjiDB db;

  setUpAll(() async {
    db = DaKanjiDB(path: dakanjiDbPath);
    db.clearDB();
    bool shouldIncludeFile(File file) => !p.basename(file.path).contains("term_bank");
    await partialInit(db, shouldIncludeFile, "term_search_test",
        otherFilesToCopy: [
          File(p.join(dataFilesPath, "testing_db", 'term_bank_1.json'))
        ]);
  });

  tearDownAll(() async {
    await db.close();
  });

  group('Term Search', () {
    for (final testCase in testCases) {
      test(
        testCase.description,
        () async {
          // 1. Perform the search.
          final results = await db.daKanjiDBDao.dictionarySearch(
            testCase.query,
            [Iso639_1.en],
            <String>[],
            true, // Enable romaji conversion for tests that need it.
          );

          // 2. Assert against the search result categories, always expecting an ordered list.
          
          // Assert Exact Matches
          final exactMatchers = testCase.expectedExactMatchs.map(matchesSearchResult).toList();
          expect(results.exactMatchs, orderedEquals(exactMatchers), reason: "ExactMatches for query '${testCase.query}' did not match.");

          // Assert Prefix Matches
          final prefixMatchers = testCase.expectedPrefixMatchs.map(matchesSearchResult).toList();
          expect(results.prefixMatchs, orderedEquals(prefixMatchers), reason: "PrefixMatches for query '${testCase.query}' did not match.");
          
          // Assert Token Matches
          final tokenMatchers = testCase.expectedTokenMatchs.map(matchesSearchResult).toList();
          expect(results.tokenMatchs, orderedEquals(tokenMatchers), reason: "TokenMatches for query '${testCase.query}' did not match.");

          // Assert Fuzzy Matches
          final fuzzyMatchers = testCase.expectedFuzzyMatchs.map(matchesSearchResult).toList();
          expect(results.fuzzyMatchs, orderedEquals(fuzzyMatchers), reason: "FuzzyMatches for query '${testCase.query}' did not match.");
          
          // Assert Wildcard Matches
          final wildcardMatchers = testCase.expectedWildcardMatchs.map(matchesSearchResult).toList();
          expect(results.wildcardMatchs, orderedEquals(wildcardMatchers), reason: "WildcardMatches for query '${testCase.query}' did not match.");
        },
      );
    }
  });
}