import 'package:da_db/database/example/example_entry.dart';
import 'package:da_db/database/example/example_search_result.dart';
import 'package:da_db/database/index/index_table_entry.dart';
import 'package:language_processing/language_processing.dart';

final List<(String, List<Iso639_3>, String)> groupingTestQueries = [
  ("猫", [Iso639_3.jpn], "Basic 1-to-1 Grouping"),
  ("犬", [Iso639_3.jpn], "Missing Target / Unrelated Dictionary"),
  ("リンゴ", [Iso639_3.jpn], "Base Match Multiple (Both Group 10 entries)"),
  ("Apple", [Iso639_3.eng], "Reverse / No-Rule Search"),
];

List<List<ExampleSearchResult>> getExpectedGroupingResults(
  IndexEntry sourceIndex,
  IndexEntry target1Index,
  IndexEntry target2Index,
) {
  return [
    // Scenario 1: "猫" (Hit JPN, fetch ENG target)
    [
      ExampleSearchResult(
        sourceEntries: [
          ExampleEntry(id: 0, indexEntry: sourceIndex, groupId: 12, sentence: "猫", languageCode: "jpn", tags: [], stats: [], audios: [])
        ],
        targetEntries: [
          ExampleEntry(id: 0, indexEntry: target1Index, groupId: 12, sentence: "Cat", languageCode: "eng", tags: [], stats: [], audios: [])
        ],
      )
    ],

    // Scenario 2: "犬" (Target 1 lacks groupId 11, Target 2 is ignored by rule)
    [
      ExampleSearchResult(
        sourceEntries: [
          ExampleEntry(id: 0, indexEntry: sourceIndex, groupId: 11, sentence: "犬", languageCode: "jpn", tags: [], stats: [], audios: [])
        ],
        targetEntries: [],
      )
    ],

    // Scenario 3: "リンゴ" (Both source entries match, grouped together!)
    [
      ExampleSearchResult(
        sourceEntries: [
          ExampleEntry(id: 0, indexEntry: sourceIndex, groupId: 10, sentence: "リンゴ", languageCode: "jpn", tags: [], stats: [], audios: []),
          ExampleEntry(id: 0, indexEntry: sourceIndex, groupId: 10, sentence: "青いリンゴ", languageCode: "jpn", tags: [], stats: [], audios: [])
        ],
        targetEntries: [
          ExampleEntry(id: 0, indexEntry: target1Index, groupId: 10, sentence: "Apple", languageCode: "eng", tags: [], stats: [], audios: [])
        ],
      )
    ],

    // Scenario 4: "Apple" (Searched English directly, no rules apply)
    [
      ExampleSearchResult(
        sourceEntries: [
          ExampleEntry(id: 0, indexEntry: target1Index, groupId: 10, sentence: "Apple", languageCode: "eng", tags: [], stats: [], audios: [])
        ],
        targetEntries: [],
      )
    ],
  ];
}