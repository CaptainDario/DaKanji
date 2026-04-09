import 'package:da_db/database/example/example_entry.dart';
import 'package:da_db/database/example/example_search_result.dart';

import 'example_test_constants.dart';

final List<(String, String)> groupingTestQueries = [
  ("猫", "Basic 1-to-1 Grouping"),
  ("犬", "Missing Target / Unrelated Dictionary"),
  ("リンゴ", "Base Match Multiple (Both Group 10 entries)"),
  ("Apple", "Reverse / No-Rule Search"),
];

final groupingTestQueriesExpectations = 
  [
    // Scenario 1: "猫" (Hit JPN, fetch ENG target)
    [
      ExampleSearchResult(
        sourceEntries: [
          ExampleEntry(id: 0, indexEntry: dummyIndexBank2Jpn, groupId: 12, sentence: "猫", tags: [], stats: [], audios: [])
        ],
        targetEntries: [
          ExampleEntry(id: 0, indexEntry: dummyIndexBank3Eng, groupId: 12, sentence: "Cat", tags: [], stats: [], audios: [])
        ],
      )
    ],

    // Scenario 2: "犬" (Target 1 lacks groupId 11, Target 2 is ignored by rule)
    [
      ExampleSearchResult(
        sourceEntries: [
          ExampleEntry(id: 0, indexEntry: dummyIndexBank2Jpn, groupId: 11, sentence: "犬", tags: [], stats: [], audios: [])
        ],
        targetEntries: [],
      )
    ],

    // Scenario 3: "リンゴ" (Both source entries match, grouped together!)
    [
      ExampleSearchResult(
        sourceEntries: [
          ExampleEntry(id: 0, indexEntry: dummyIndexBank2Jpn, groupId: 10, sentence: "リンゴ", tags: [], stats: [], audios: []),
          ExampleEntry(id: 0, indexEntry: dummyIndexBank2Jpn, groupId: 10, sentence: "青いリンゴ", tags: [], stats: [], audios: [])
        ],
        targetEntries: [
          ExampleEntry(id: 0, indexEntry: dummyIndexBank3Eng, groupId: 10, sentence: "Apple", tags: [], stats: [], audios: [])
        ],
      )
    ],

    // Scenario 4: "Apple" (Searched English directly, no rules apply)
    [
      ExampleSearchResult(
        sourceEntries: [
          ExampleEntry(id: 0, indexEntry: dummyIndexBank3Eng, groupId: 10, sentence: "Apple", tags: [], stats: [], audios: [])
        ],
        targetEntries: [],
      )
    ],
  ];
