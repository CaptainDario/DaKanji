import 'package:da_db/data/grouping_rules.dart';
import 'package:da_db/database/da_db.dart';
import 'package:da_db/database/example/example_search_result.dart';
import 'package:da_db/database/index/index_table_entry.dart';
import 'package:da_db/parsing/unified_staging_parser.dart';
import 'package:da_db_shared/da_db_shared.dart';
import 'package:test/test.dart';
import 'package:universal_io/universal_io.dart';

import '../dictionary_test_variables.dart';
import '../test_utils/db_files.dart';
import '../test_utils/ignore_database_generated_data.dart';
import 'example_grouping_test_cases.dart';

void main() {
  late DaDb db;
  late IndexEntry sourceDict;
  late IndexEntry targetDict1;
  late IndexEntry targetDict2;
  late Set<SequenceGroupingRule> activeRules;
  late List<List<ExampleSearchResult>> expectedValues;

  setUpAll(() async {
    // 1. Setup DB with our three minimal test dictionaries
    db = await setupGroupedDb([
      '$devExampleBanksPath/example_bank_2', // Source
      '$devExampleBanksPath/example_bank_3', // Target 1
      '$devExampleBanksPath/example_bank_4', // Target 2
    ]);

    // 2. Fetch the dynamically assigned Index Entries
    final indexes = await db.indexDao.getAllIndexes();
    sourceDict = indexes.firstWhere((i) => i.title == "Source Japanese");
    targetDict1 = indexes.firstWhere((i) => i.title == "Target English 1");
    targetDict2 = indexes.firstWhere((i) => i.title == "Target English 2");

    // 3. Define the grouping rule: Source Japanese -> Target English 1 ONLY
    activeRules = {
      SequenceGroupingRule(
        sourceDictId: sourceDict.id, 
        targetDictIds: {targetDict1.id}
      )
    };

    // 4. Build expected outputs
    expectedValues = getExpectedGroupingResults(sourceDict, targetDict1, targetDict2);
  });

  tearDownAll(() async {
    await db.close();
  });

  group('Example Sentence Grouping by GroupID', () {
    for (var i = 0; i < groupingTestQueries.length; i++) {
      final query = groupingTestQueries[i].$1;
      final languages = groupingTestQueries[i].$2;
      final testName = groupingTestQueries[i].$3;

      test('Scenario ${i + 1}: $testName (Query: "$query")', () async {
        // MOVE THIS INSIDE THE TEST CALLBACK!
        // Now it runs after setUpAll is finished.
        final expected = expectedValues[i];

        final results = await db.exampleDao.searchExamples(
          query, languages, groupingRules: activeRules
        );

        expect(results, isNotNull, reason: "Query '$query' returned null.");
        
        // Filter out matches from other testing banks that might be lingering
        final filteredResults = results!.where(
          (r) => r.sourceEntries.isNotEmpty && 
                {sourceDict.id, targetDict1.id, targetDict2.id}.contains(r.sourceEntries.first.indexEntry.id)
        ).toList();

        expect(filteredResults.length, expected.length, 
          reason: "Length mismatch for query '$query'."
        );

        for (var j = 0; j < filteredResults.length; j++) {
          expect(
            exampleSearchResultIgnoreDatabaseGeneratedData(filteredResults[j]),
            exampleSearchResultIgnoreDatabaseGeneratedData(expected[j])
          );
        }
      });
    }
  });
}


Future<DaDb> setupGroupedDb(List<String> dictionaryPaths, {bool inMemory = true}) async {
  if (File(daDbTestPath).existsSync()) File(daDbTestPath).deleteSync();

  DaDb db = DaDb(
    dbPath: daDbTestPath, 
    inMemory: inMemory,
    languageProcessor: await japaneseProcessor
  );

  for (int i = 0; i < dictionaryPaths.length; i++) {
    String dataSourceZipPath = await createTmpZip(Directory(dictionaryPaths[i]));
    
    Stream<String> stream = await parseDaDbDataSource(
      dataSourcePath: dataSourceZipPath,
      db: db,
      // Just make the first one default for testing purposes
      isDefaultDictionary: i == 0, 
    );
    
    await for (final event in stream) {
      // print("Parser [Dict ${i + 1}]: $event");
    }
  }

  return db;
}