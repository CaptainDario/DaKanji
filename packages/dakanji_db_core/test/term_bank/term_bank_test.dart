// Package imports:
import 'dart:io';

import 'package:test/test.dart';
import 'package:path/path.dart' as p;

// Project imports:
import 'package:dakanji_db_core/database/dakanji_db.dart';
import 'package:dakanji_db_shared/paths.dart';
import '../util/db_files.dart';
import 'term_bank_test_cases_1.dart';
import 'term_bank_test_cases_2.dart';
import 'term_bank_v3_entry_matcher.dart';



void main() async {
  final List testCases = [
    (termBankTestCases1, termBankTestCaseExpectations1),
    (termBankTestCases2, termBankTestCaseExpectations2)
  ];

  late DaKanjiDB db;
  
  // Group all related term bank tests together.
  for (var testCaseIndex = 0; testCaseIndex < testCases.length; testCaseIndex++) {
    final termBankTestCases = testCases[testCaseIndex].$1;
    final termBankTestCaseExpectations = testCases[testCaseIndex].$2;

    group('Term Bank V3 test cases: $testCaseIndex', () {

      setUpAll(() async {
        db = DaKanjiDB(path: dakanjiDbPath);
        db.clearDB();
        bool shouldIncludeFile(File file) =>
          (p.basename(file.path) == "term_bank_${testCaseIndex+1}.json" ||
          !p.basename(file.path).contains("term_bank"));
        await partialInit(db, shouldIncludeFile); 
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

}