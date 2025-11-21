
import 'dart:io';

import 'package:dakanji_db_core/database/dakanji_db.dart';
import 'package:dakanji_db_core/database/term/term_bank_v3_entry.dart';
import 'package:dakanji_db_shared/paths.dart';
import 'package:mecab_for_dart/mecab_dart.dart';
import 'package:path/path.dart' as p;
import 'package:test/test.dart';

import '../util/db_files.dart';
import 'term_bank_test_cases_1.dart';
import 'term_bank_test_cases_2.dart';
import 'term_bank_v3_entry_matcher.dart';


final List<(List<String>, List<List<TermBankV3Entry>>)> testCases = [
  (termBankTestCases1, termBankTestCaseExpectations1),
  (termBankTestCases2, termBankTestCaseExpectations2)
];


void main() async {

  // Group all related term bank tests together.
  for (var testCaseIndex = 0; testCaseIndex < testCases.length; testCaseIndex++) {
    final termBankTestCases = testCases[testCaseIndex].$1;
    final termBankTestCaseExpectations = testCases[testCaseIndex].$2;

    group('Term Bank V3 test cases: $testCaseIndex', () {

      late DaKanjiDB db;
      setUpAll(() async {
        db = await setupFreshDB(testCaseIndex+1);
      });
      tearDownAll(() async {
        await db.close();
      });

      // Loop through the test cases and dynamically create a test for each one.
      for (int i = 0; i < termBankTestCases.length; i++) {
        final testCase = termBankTestCases[i];
        final expected = termBankTestCaseExpectations[i];

        test('Search for "$testCase" should return correct entries', () async {
          // Perform the database search
          final result = (await db.termBankV3Dao.search(testCase))
            .map((e) => e.copyWith(
              id: 0, // ignore ids in comparison;
              tags: e.tags.map((tag) => tag.copyWith(id: 0)).toList(),
              definitionTags: e.definitionTags.map((tag) => tag.copyWith(id: 0)).toList()  
            )) // ignore tag ids in comparison
          .toList(); 
          print("result: $result");
          print("expectation: $expected");

          // 1. First, check if the number of results is correct.
          expect(
            result.length,
            expected.length,
            reason: "For search term '$testCase', expected ${expected.length} result(s) but found ${result.length}.",
          );

          // 2. If counts match, compare the content of each entry.
          expect(
            result,
            unorderedEquals(
              expected.map((e) => matchesTermBankEntry(e)).toList(),
            ),
            reason: "The entries for '$testCase' did not match the expected data.",
          );
        });
      }
    });
  }

}

Future<DaKanjiDB> setupFreshDB(int testCaseIndex) async {

  DaKanjiDB db = DaKanjiDB(dbPath: dakanjiDbPath, inMemory: true);
  db.clearDB();

  Mecab mecab = Mecab();
  await mecab.init(mecabDynamicLibPath, mecabDicPath, true);
  
  bool shouldIncludeFile(File file) =>
    (p.basename(file.path) == "term_bank_$testCaseIndex.json" ||
    !p.basename(file.path).contains("term_bank"));
  await partialInit(db, shouldIncludeFile, "term_bank_test", mecab,
    isDefaultDictionary: false); 

  return db;

}