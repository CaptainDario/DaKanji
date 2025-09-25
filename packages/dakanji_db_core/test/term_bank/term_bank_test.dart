// Package imports:
import 'dart:io';

import 'package:test/test.dart';
import 'package:path/path.dart' as p;

// Project imports:
import 'package:dakanji_db_core/database/dakanji_db.dart';
import 'package:dakanji_db_core/parsing/dictionary_parser.dart';
import 'package:dakanji_db_shared/paths.dart';
import 'term_bank_test_cases_1.dart';
import 'term_bank_test_cases_2.dart';
import 'term_bank_v3_entry_matcher.dart';

void main() {
  final List testCases = [
    (termBankTestCases1, termBankTestCaseExpectations1),
    (termBankTestCases2, termBankTestCaseExpectations2)
  ];

  DaKanjiDB db = DaKanjiDB(path: dakanjiDbPath);
  for (var i = 0; i < testCases.length; i++) {
    setUpAll(() async {
      db.clearDB();

      print("Copying neccessary files to tmp location...");
      Directory d = Directory(p.joinAll([tmpPath, "term_bank_test"]));
      if(d.existsSync()) d.deleteSync(recursive: true);
      d.createSync();
      for (var file in Directory(yomitanSampleDictionaryPath).listSync()) {
        if (file is File &&
          (p.basename(file.path) == "term_bank_$i.json" || !p.basename(file.path).contains("term_bank"))) {
          await file.copy(p.joinAll([d.path, p.basename(file.path)]));
        }
      }

      print("Setting up test database...");
      Stopwatch s = Stopwatch()..start();
      await parseDictionaryFolder(Directory(yomitanSampleDictionaryPath), db, true);
      print("Database setup and conversion took ${s.elapsedMilliseconds} ms.");
    });

    // Group all related term bank tests together.
    for (var part = 0; part < testCases.length; part++) {
      // FIX: Access tuple elements correctly with $1 and $2
      final termBankTestCases = testCases[part].$1;
      final termBankTestCaseExpectations = testCases[part].$2;

      group('Term Bank V3 test cases: $part', () {
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
}