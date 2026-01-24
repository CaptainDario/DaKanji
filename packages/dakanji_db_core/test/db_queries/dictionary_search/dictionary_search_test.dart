// dictionary_search_test.dart

import 'dart:io';

import 'package:dakanji_db_core/database/dakanji_db.dart';
import 'package:dakanji_db_core/database/db_queries/dictionary_search/dictionary_search_params.dart';
import 'package:dakanji_db_shared/dakanji_db_shared.dart';
import 'package:mecab_for_dart/mecab_dart.dart';
import 'package:path/path.dart' as p;
import 'package:test/test.dart';

import '../../test_utils/db_files.dart';
import 'dictionary_popularity_override_test_cases.dart';
import 'dictionary_search_deconjugation_test_cases.dart';
import 'dictionary_search_filtering_test_cases.dart';
import 'dictionary_search_fuzzy_test_cases.dart';
import 'dictionary_search_grouping_by_sequence_test_cases.dart';
import 'dictionary_search_grouping_by_term.dart';
import 'dictionary_search_grouping_by_term_and_reading_test_cases.dart';
import 'dictionary_search_grouping_multiple_types_test_cases.dart';
import 'dictionary_search_index_on_off_test_cases.dart';
import 'dictionary_search_input_preprocessing_test_cases.dart';
import 'dictionary_search_meta_bank_test_cases.dart';
import 'dictionary_search_sorting_test_cases.dart';
import 'dictionary_search_test_cases.dart';
import 'dictionary_search_test_helper_classes.dart';
import 'dictionary_search_test_util.dart';
import 'dictionary_search_wildcard_test_cases.dart';



// Lists are defined at the top level (this is fine)
final List<(
  List<DictionarySearchTestCase> expectations, 
  )> testCases = [
  (searchTestCases, ),
  (deconjugationTestCases, ),
  (wildcardSearchTestCases, ),
  (inputPreprocessingSearchTestCases, ),
  (sortingTestCases, ),
  (fuzzySearchTestCases, ),
  (tagFilteringTestCases, ),
  (metaBankTestCases, ),
  (popularityOverrideTestCases, ),
  (groupBySequenceTests, ),
  (groupByTermTests, ),
  (groupByTermAndReadingTests, ),
  (groupByMultipleTypesTests, ),
  (indexOnOffTestCases, ),
];
final List<String> testCaseNames = [
  "Search",
  "Deconjugation",
  "Wildcard Search",
  "Input processing",
  "Sorting",
  "Fuzzy Search",
  "Tag Filtering",
  "Meta bank test cases",
  "Popularity Override",
  "Grouping Sequences",
  "Grouping by Term",
  "Grouping by Term + Reading",
  "Multi Grouping Types",
  "Index On/Off",
];

String currentTestCase = "";
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
      for (int j=0; j < subTestCases.$1.length; j++) {
        final testCase = subTestCases.$1[j];
        test(
          "$testCaseName (${j+1}): ${testCase.description}",
          () async {
            // set frequency overrides if any
            if(testCaseName == "Popularity Override")
              await db.indexDao.updateFrequencyOverride(3);
            else 
              await db.indexDao.clearFrequencyOverride();
            // Perform the search
            final results = (await db.dictionarySearchDao.dictionarySearch(
              DictionarySearchParams(
                query: testCase.query,

                normalizedSearch: true,
                normalizedSearchConvertsRomajiToHiragana: true,
                deconjugationSearch: true,
                spellfixSearch: true,
                
                groupingRules: testCase.groupingRules,

                indexesToInclude: testCase.indexesToInclude,
                useOnlyEnabledIndexes: testCase.useOnlyEnabledDictionaries,
                useOnlyDefaultIndexes: testCase.useOnlyDefaultDictionaries,
                
              ),
              printDebugInfo: true
            ));

            print("Results:\n $results");
            print("Expected:\n $testCase");

            // --- direct matches ---            
            expectMatchGroup(results.queryMatches, testCase.queryMatches, testCase.query, 'termMatches');

            // --- normalized matches ---
            final actualNormalized = results.normalizedQueryMatchGroups;
            final expectedNormalized = testCase.normalizedQueryMatchGroups;

            if (actualNormalized.length != expectedNormalized.length) {
              fail(
                  'Unexpected number of normalized match groups for query \'${testCase.query}\'.\n'
                  'Expected length: ${expectedNormalized.length}\n'
                  '  Actual length: ${actualNormalized.length}\n'
                  '   ACTUAL CONTENTS:\n${actualNormalized.map((g) => g.toFormattedString(indent: "    ")).join("\n")}');
            }

            for (int k = 0; k < expectedNormalized.length; k++) {
              expectMatchGroup(
                actualNormalized[k], 
                expectedNormalized[k], 
                testCase.query, 
                'variantMatches[$k]'
              );
            }

            // --- variant matches ---
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

            for (int k = 0; k < expectedVariants.length; k++) {
              expectMatchGroup(
                actualVariants[k], 
                expectedVariants[k], 
                testCase.query, 
                'variantMatches[$k]'
              );
            }

            // --- fuzzy matches ---
            final actualFuzzy = results.fuzzyMatches;
            final expectedFuzzy = testCase.fuzzyMatches;

            if (actualFuzzy.length != expectedFuzzy.length) {
              fail(
                'Unexpected number of fuzzy matches for query \'${testCase.query}\'.\n'
                'Expected length: ${expectedFuzzy.length}\n'
                '  Actual length: ${actualFuzzy.length}\n'
                '   ACTUAL CONTENTS:\n${actualFuzzy.map((m) => m.toFormattedString(indent: "    ")).join("\n")}'
              );
            }
          },
        );
      }
    });
  }
}

Future setupFreshDB() async {

  //if(File(dakanjiDbPath).existsSync()) File(dakanjiDbPath).deleteSync();
  DaKanjiDB db = DaKanjiDB(dbPath: dakanjiDbPath, inMemory: true);

  // init mecab
  final mecab = Mecab();
  await mecab.init(mecabDynamicLibPath, mecabDicPath, true);

  // emulate importing 5 dictionaries
  // take all data form the yomitan sample dictionary except term banks
  for (int i in [2, 1, 3, 4, 5]) {
    bool shouldIncludeFile(File file) =>
      // take the full dictionary only once
      (i == 1 && !p.basename(file.path).contains("term_bank")) || 
      p.basename(file.path).contains("index"); // always include index files

    await partialInit(db, shouldIncludeFile, "term_search_test", mecab,
      otherFilesToCopy: [
        File(p.join(dataFilesPath, "testing_db", 'term_bank_$i.json')),
        if(i == 3)File(p.join(dataFilesPath, "testing_db", 'term_meta_bank_2.json')),
        if(i == 1) File(p.join(dataFilesPath, "testing_db", 'tag_bank_1.json')),
      ],
      isDefaultDictionary: i==4,
    );
    await db.indexDao.setEnabled(i, i==5);
  }

  return db;
  
}