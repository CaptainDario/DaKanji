
// Expanded Record to pass stat filter/sort arguments into the test loop
// Format: (Query, StatName, ExpectedValue, ApplySort, IsDesc)
import 'package:da_db/database/example/example_entry.dart';
import 'package:da_db/database/example/example_search_result.dart';
import 'package:da_db/database/stats/stat_entry.dart';

import 'example_test_constants.dart';

final List<(String, String?, double?, bool, bool)> exampleSentencesStatFtsTestQueries = [
  // 1. Sort by Quality DESC (Expected: 201 then 200)
  ("車", "quality", null, true, true),
  
  // 2. Filter exactly by JLPT = 5.0 (Expected: 200 only)
  ("車", "JLPT", 5.0, false, false),
  
  // 3. Sort by Difficulty ASC (Expected: 200 then 201)
  ("車", "difficulty", null, true, false),
  
  // 4. Standard FTS fallback query, no stats (Expected: 202)
  ("水", null, null, false, false),
  
  // 5. Standard FTS fallback query, no stats (Expected: 203)
  ("山", null, null, false, false),
];


final List<List<ExampleSearchResult>?> exampleSentenceStatFtsTestExpectedValues = [
  
  // --- Test 1: Query "車", Sort Quality DESC ---
  // 201 has quality 5.0, 200 has quality 4.0
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

  // --- Test 2: Query "車", Filter JLPT = 5.0 ---
  // Only 200 matches this exact stat filter
  [
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

  // --- Test 3: Query "車", Sort Difficulty ASC ---
  // 200 has difficulty 1.5, 201 has difficulty 2.0
  [
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
    ),
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

  // --- Test 4: Query "水", No Stats Filter/Sort ---
  [
    ExampleSearchResult(
      sourceEntries: [ExampleEntry(
        id: 0, indexEntry: dummyIndexBank2Jpn, groupId: 202,
        sentence: "冷たい水を飲む",
        tags: [], 
        stats: [
          const StatEntry(id: 0, statName: "freq", displayName: "Frequency", value: 500.0, displayValue: "common"),
          const StatEntry(id: 0, statName: "quality", value: 3.0),
        ],
        audios: [],
      )],
      targetEntries: [],
    )
  ],

  // --- Test 5: Query "山", No Stats Filter/Sort ---
  [
    ExampleSearchResult(
      sourceEntries: [ExampleEntry(
        id: 0, indexEntry: dummyIndexBank2Jpn, groupId: 203,
        sentence: "高い山に登る",
        tags: [], 
        stats: [
          const StatEntry(id: 0, statName: "difficulty", displayName: "Difficulty", value: 3.5),
        ],
        audios: [],
      )],
      targetEntries: [],
    )
  ],

];