import 'package:da_db/database/example/example_entry.dart';
import 'package:da_db/database/example/example_search_result.dart';
import 'package:da_db/database/stats/stat_entry.dart';

import 'example_stat_search_examples_fts_test_cases.dart';
import 'example_test_constants.dart';

// Format: (QueryList, RequireAllTokens, StatName, ExpectedValue, ApplySort, IsDesc)
final List<(List<String>, bool, String?, double?, bool, bool)> exampleSentencesStatBaseFormsTestQueries = [
  
  // Single-word queries don't care about AND/OR, so we just default them to false
  ...exampleSentencesStatFtsTestQueries.sublist(0, 5)
    .map((test) => ( [test.$1], false, test.$2, test.$3, test.$4, test.$5 )),

  // 6. MULTI-TERM SEARCH (AND): Require all tokens (Expected: 201 only)
  (["好き", "車"], true, null, null, false, false),

  // 7. MULTI-TERM SEARCH (OR): Match any token (Expected: 201 AND 200)
  (["好き", "車"], false, null, null, false, false),
];

final List<List<ExampleSearchResult>?> exampleSentenceStatBaseFormsTestExpectedValues = [

  ...exampleSentenceStatFtsTestExpectedValues.sublist(0, 5),

  // --- Test 6: Query ["速い", "車"], AND logic ---
  // Only 201 contains both concepts
  [
    ExampleSearchResult(
      sourceEntries: [ExampleEntry(
        id: 0, indexEntry: dummyIndexBank2Jpn, groupId: 201,
        sentence: "速い車が好きです",
        tags: [], 
        stats: [
          const StatEntry(id: 0, statName: "JLPT", value: 4.0, displayValue: "N4"), 
          const StatEntry(id: 0, statName: "difficulty", displayName: "Difficulty", value: 2.0),
          const StatEntry(id: 0, statName: "quality", value: 5.0),
        ],
        audios: [],
      )],
      targetEntries: [],
    )
  ],

  // --- Test 7: Query ["速い", "車"], OR logic ---
  // 201 contains both (highest BM25 score), 200 contains "車" (lower BM25 score)
  [
    ExampleSearchResult(
      sourceEntries: [ExampleEntry(
        id: 0, indexEntry: dummyIndexBank2Jpn, groupId: 201,
        sentence: "速い車が好きです",
        tags: [], 
        stats: [
          const StatEntry(id: 0, statName: "JLPT", value: 4.0, displayValue: "N4"), 
          const StatEntry(id: 0, statName: "difficulty", displayName: "Difficulty", value: 2.0),
          const StatEntry(id: 0, statName: "quality", value: 5.0),
        ],
        audios: [],
      )],
      targetEntries: [],
    ),
    ExampleSearchResult(
      sourceEntries: [ExampleEntry(
        id: 0, indexEntry: dummyIndexBank2Jpn, groupId: 200,
        sentence: "車を運転します",
        tags: [], 
        stats: [
          const StatEntry(id: 0, statName: "JLPT", value: 5.0, displayValue: "N5"), 
          const StatEntry(id: 0, statName: "difficulty", displayName: "Difficulty", value: 1.5),
          const StatEntry(id: 0, statName: "quality", value: 4.0),
        ],
        audios: [],
      )],
      targetEntries: [],
    )
  ],
];