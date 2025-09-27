// term_search_test.dart

import 'dart:io';

import 'package:dakanji_db_core/database/term/term_bank_v3_entry.dart';
import 'package:dakanji_db_shared/paths.dart';
import 'package:language_processing/iso/iso_table.dart';
import 'package:test/test.dart';
import 'package:path/path.dart' as p;

import 'package:dakanji_db_core/database/dakanji_db.dart';


import '../util/db_files.dart';
import 'term_search_test_cases.dart';


/// Custom matcher to verify the essential fields of a search result.
/// This confirms that the correct items are returned. (No change needed here)
Matcher matchesSearchResult(ExpectedSearchResult expected) {
  return isA<TermBankV3Entry>()
      .having((res) => res.term, 'term', expected.term)
      .having((res) => res.reading, 'reading', expected.reading);
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
          final results = await db.daKanjiDBDao.searchTerm(
            testCase.query,
            [Iso639_1.en],
            <String>[],
            true, // Enable romaji conversion for tests that need it.
          );

          // 2. Determine the ordering for the assertion.
          final orderingMatcher = (List<Matcher> matchers) =>
              testCase.expectOrdered
                  ? orderedEquals(matchers)
                  : unorderedEquals(matchers);

          // 3. UPDATED: Assert against the new nested structure for termMatches.
          final expectedTerms = testCase.expectedTermMatches;
          expect(results.termMatches.exactMatch, orderingMatcher(expectedTerms.exactMatch.map(matchesSearchResult).toList()), reason: "Term/Exact");
          expect(results.termMatches.prefixMatch, orderingMatcher(expectedTerms.prefixMatch.map(matchesSearchResult).toList()), reason: "Term/Prefix");
          expect(results.termMatches.tokenMatch, orderingMatcher(expectedTerms.tokenMatch.map(matchesSearchResult).toList()), reason: "Term/Token");
          expect(results.termMatches.wildcardMatch, orderingMatcher(expectedTerms.wildcardMatch.map(matchesSearchResult).toList()), reason: "Term/Wildcard");


          // 4. UPDATED: Assert against the new nested structure for hiraganaTermMatches.
          final expectedHiragana = testCase.expectedHiraganaTermMatches;
          expect(results.hiraganaTermMatches.exactMatch, orderingMatcher(expectedHiragana.exactMatch.map(matchesSearchResult).toList()), reason: "Hiragana/Exact");
          expect(results.hiraganaTermMatches.prefixMatch, orderingMatcher(expectedHiragana.prefixMatch.map(matchesSearchResult).toList()), reason: "Hiragana/Prefix");
          expect(results.hiraganaTermMatches.tokenMatch, orderingMatcher(expectedHiragana.tokenMatch.map(matchesSearchResult).toList()), reason: "Hiragana/Token");
          expect(results.hiraganaTermMatches.wildcardMatch, orderingMatcher(expectedHiragana.wildcardMatch.map(matchesSearchResult).toList()), reason: "Hiragana/Wildcard");

          // 5. UPDATED: Assert against the list of preprocessed term matches.
          expect(results.preprocessedTermsMatches.length, testCase.expectedPreprocessedTermsMatches.length, reason: "Preprocessed list should have the same number of elements.");

          for (var i = 0; i < testCase.expectedPreprocessedTermsMatches.length; i++) {
            final expectedGroup = testCase.expectedPreprocessedTermsMatches[i];
            final actualGroup = results.preprocessedTermsMatches[i];
            
            expect(actualGroup.exactMatch, orderingMatcher(expectedGroup.exactMatch.map(matchesSearchResult).toList()), reason: "Preprocessed[$i]/Exact");
            expect(actualGroup.prefixMatch, orderingMatcher(expectedGroup.prefixMatch.map(matchesSearchResult).toList()), reason: "Preprocessed[$i]/Prefix");
            expect(actualGroup.tokenMatch, orderingMatcher(expectedGroup.tokenMatch.map(matchesSearchResult).toList()), reason: "Preprocessed[$i]/Token");
            expect(actualGroup.wildcardMatch, orderingMatcher(expectedGroup.wildcardMatch.map(matchesSearchResult).toList()), reason: "Preprocessed[$i]/Wildcard");
          }
        },
        skip: testCase.isFuture
            ? 'This test is for a feature that is not yet implemented.'
            : false,
      );
    }
  });
}