// Package imports:
import 'dart:io';

import 'package:test/test.dart';

// Project imports:
import 'package:dakanji_db_core/database/dakanji_db.dart';
import 'package:dakanji_db_core/parsing/dictionary_parser.dart';
import 'package:dakanji_db_shared/paths.dart';
import 'term_bank_test_cases_1.dart';
import 'term_bank_v3_entry_matcher.dart';

void main() {
  // Group all related term bank tests together.
  group('Term Bank V3 Entry Verification', () {

    late DaKanjiDB db;
    setUpAll(() async {
      db = DaKanjiDB(path: dakanjiDbPath);
      db.clearDB();

      print("Setting up test database...");
      Stopwatch s = Stopwatch()..start();
      await parseDictionaryFolder(Directory(yomitanSampleDictionaryPath), db, true);
      print("Database setup and conversion took ${s.elapsedMilliseconds} ms.");
    });

    // Loop through the test cases and dynamically create a test for each one.
    for (int i = 0; i < termBankTestCases.length; i++) {
      final testCase = termBankTestCases[i];
      final expected = termBankTestCaseExpectations[i];

      test('Search for "$testCase" should return correct entries', () async {
        // Perform the database search
        final result = await db.termBankV3Dao.search(testCase);

        // 1. First, check if the number of results is correct.
        expect(
          result.length,
          expected.length,
          reason: "For search term '$testCase', expected ${expected.length} result(s) but found ${result.length}.",
        );

        // 2. If counts match, compare the content of each entry.
        expect(
          result,
          orderedEquals(
            expected.map((e) => matchesTermBankEntry(e)).toList(),
          ),
          reason: "The entries for '$testCase' did not match the expected data.",
        );
      });
    }
  });
}