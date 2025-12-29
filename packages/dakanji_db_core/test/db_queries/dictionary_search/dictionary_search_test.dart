// dictionary_search_test.dart

import 'dart:io';

import 'package:dakanji_db_core/database/dakanji_db.dart';
import 'package:dakanji_db_core/database/db_queries/grouping_strategy.dart';
import 'package:dakanji_db_shared/dakanji_db_shared.dart';
import 'package:mecab_for_dart/mecab_dart.dart';
import 'package:path/path.dart' as p;
import 'package:test/test.dart';

import '../../util/db_files.dart';
import 'dictionary_popularity_override_test_cases.dart';
import 'dictionary_search_deconjugation_test_cases.dart';
import 'dictionary_search_filtering_test_cases.dart';
import 'dictionary_search_fuzzy_test_cases.dart';
import 'dictionary_search_grouping_by_sequence_test_cases.dart';
import 'dictionary_search_grouping_by_term.dart';
import 'dictionary_search_grouping_by_term_and_reading_test_cases.dart';
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
  List<ExpectedDictionarySearchResult> expectations,
  GroupingStrategy groupingStrategy
  )> testCases = [
  (searchTestCases, GroupingStrategy.none),
  (deconjugationTestCases, GroupingStrategy.none),
  (wildcardSearchTestCases, GroupingStrategy.none),
  (inputPreprocessingSearchTestCases, GroupingStrategy.none),
  (sortingTestCases, GroupingStrategy.none),
  (fuzzySearchTestCases, GroupingStrategy.none),
  (tagFilteringTestCases, GroupingStrategy.none),
  (metaBankTestCases, GroupingStrategy.none),
  (popularityOverrideTestCases, GroupingStrategy.none),
  (groupBySequenceTests, GroupingStrategy.bySequence),
  (groupByTermTests, GroupingStrategy.byTerm),
  (groupByTermAndReadingTests, GroupingStrategy.byTermAndReading),
  (indexOnOffTestCases, GroupingStrategy.none),
];
final List<String> testCaseNames = [
  "Search Test Cases",
  "Deconjugation Test Cases",
  "Wildcard Search Test Cases",
  "Input processing Test Cases",
  "Sorting Test Cases",
  "Fuzzy Search Test Cases",
  "Tag Filtering Test Cases",
  "Meta bank test cases",
  "Popularity Override",
  "Grouping Sequences Test Cases",
  "Grouping by Term Test Cases",
  "Grouping by Term and Reading Test Cases",
  "Index On/Off Test Cases",
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
      for (int i=0; i < subTestCases.$1.length; i++) {
        final testCase = subTestCases.$1[i];
        test(
          testCase.description,
          () async {
            // set frequency overrides if any
            if(testCaseName == "Popularity Override")
              await db.indexDao.updatePopularityOverride(3);
            else 
              await db.indexDao.clearFrequencyOverride();
            // Perform the search
            final results = (await db.dBQueriesDao.dictionarySearch(
              testCase.query,
              tags: testCase.tags, 
              normalizedSearch: true,
              normalizedSearchConvertsRomajiToHiragana: true,
              deconjugationSearch: true,
              spellfixSearch: true,
              groupingStrategy: subTestCases.$2,
              indexesToInclude: testCase.indexesToInclude,
              useOnlyEnabledIndexes: testCase.useOnlyEnabledDictionaries,
              useOnlyDefaultIndexes: testCase.useOnlyDefaultDictionaries,
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

            for (int i = 0; i < expectedNormalized.length; i++) {
              expectMatchGroup(
                actualNormalized[i], 
                expectedNormalized[i], 
                testCase.query, 
                'variantMatches[$i]'
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

            for (int i = 0; i < expectedVariants.length; i++) {
              expectMatchGroup(
                actualVariants[i], 
                expectedVariants[i], 
                testCase.query, 
                'variantMatches[$i]'
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