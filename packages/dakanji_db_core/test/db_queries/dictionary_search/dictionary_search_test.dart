// dictionary_search_test.dart

import 'dart:io';

import 'package:dakanji_db_core/database/dakanji_db.dart';
import 'package:dakanji_db_shared/dakanji_db_shared.dart';
import 'package:language_processing/iso/iso_table.dart';
import 'package:mecab_for_dart/mecab_dart.dart';
import 'package:path/path.dart' as p;
import 'package:test/test.dart';

import '../../util/db_files.dart';
import 'dictionary_search_deconjugation_test_cases.dart';
import 'dictionary_search_fuzzy_test_cases.dart';
import 'dictionary_search_input_preprocessing_test_cases.dart';
import 'dictionary_search_language_filtering_test_cases.dart';
import 'dictionary_search_meta_bank_test_cases.dart';
import 'dictionary_search_sorting_test_cases.dart';
import 'dictionary_search_tag_filtering_test_cases.dart';
import 'dictionary_search_test_cases.dart';
import 'dictionary_search_test_helper_classes.dart';
import 'dictionary_search_test_util.dart';
import 'dictionary_search_wildcard_test_cases.dart';


// Lists are defined at the top level (this is fine)
final List<List<SearchTestCase>> testCases = [
  searchTestCases,
  deconjugationTestCases,
  wildcardSearchTestCases,
  inputPreprocessingSearchTestCases,
  sortingTestCases,
  fuzzySearchTestCases,
  tagFilteringTestCases,
  languageFilteringTestCases,
  metaBankTestCases
];
final List<String> testCaseNames = [
  "Search Test Cases",
  "Deconjugation Test Cases",
  "Wildcard Search Test Cases",
  "Input processing Test Cases",
  "Sorting Test Cases",
  "Fuzzy Search Test Cases",
  "Tag Filtering Test Cases",
  "Language Filtering Test Cases",
  "Meta bank test cases"
];


void main() {
  // Define db here so it's accessible to setUpAll and tearDownAll
  late DaKanjiDB db;

  setUpAll(() async {
    db = await setupFreshDB();
  });

  tearDownAll(() async {
    await db.close();
  });

  // The loop is now inside main, which is the standard way.
  // The key is that `group()` is called within the main test scope.
  for (int i = 0; i < testCases.length; i++) {
    final subTestCases = testCases[i];
    final testCaseName = testCaseNames[i];
    
    // This `group` call is now correctly discovered.
    group(testCaseName, () {
      for (final testCase in subTestCases) {
        test(
          testCase.description,
          () async {
            // Perform the search
            final results = await db.daKanjiDBDao.dictionarySearch(
              testCase.query,
              [Iso639_1.en],
              testCase.tags, 
              true, 
            );
            print("Results:\n $results");
            print("Expected:\n $testCase");
            
            expectMatchGroup(results.queryMatches, testCase.queryMatches, testCase.query, 'termMatches');
            expectMatchGroup(results.normalizedQueryMatches, testCase.hiraganaQueryMatches, testCase.query, 'hiraganaMatches');

            final actualVariants = results.queryVariantMatches;
            final expectedVariants = testCase.queryVariantMatches;

            if (actualVariants.length != expectedVariants.length) {
              fail(
                'Unexpected number of variant match groups for query \'${testCase.query}\'.\n'
                'Expected length: ${expectedVariants.length}\n'
                '  Actual length: ${actualVariants.length}\n'
                '   ACTUAL CONTENTS:\n${actualVariants.map((g) => g.toFormattedString(indent: "    ")).join("\n")}'
              );
            }

            for (int i = 0; i < expectedVariants.length; i++) {
              expectMatchGroup(
                actualVariants[i], 
                expectedVariants[i], 
                testCase.query, 
                'variantMatches[$i]'
              );
            }
          },
        );
      }
    });
  }
}

Future setupFreshDB() async {

    if(File(dakanjiDbPath).existsSync()) File(dakanjiDbPath).deleteSync();
    DaKanjiDB db = DaKanjiDB(dbPath: dakanjiDbPath, inMemory: false);

    // init mecab
    final mecab = Mecab();
    await mecab.init(mecabDynamicLibPath, mecabDicPath, true);

    bool shouldIncludeFile(File file) => !p.basename(file.path).contains("term_bank");
    await partialInit(db, shouldIncludeFile, "term_search_test", mecab,
        otherFilesToCopy: [
          File(p.join(dataFilesPath, "testing_db", 'term_bank_1.json')),
          File(p.join(dataFilesPath, "testing_db", 'tag_bank_1.json')),
        ]);

  return db;
  
}