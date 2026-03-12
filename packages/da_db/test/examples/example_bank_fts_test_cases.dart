import 'package:da_db/database/example/example_audio_entry.dart';
import 'package:da_db/database/example/example_entry.dart';
import 'package:da_db/database/example/example_search_result.dart';
import 'package:da_db/database/index/index_table_entry.dart';
import 'package:da_db/database/stats/stat_entry.dart';
import 'package:da_db/database/tag/tag_bank_v3_entry.dart';

import 'example_test_constants.dart';

final List<(String, )> exampleSentencesTestQueries = [
  ("リンゴ", ),
  ("犬", ),
  ("猫", ),
  ("apples", ),
  ("apple", ),
  
  ("THIS_DOES_NOT_EXIST", ),
  ("", ),
  ("   ", ),
  ("ゴを食", ),
  ("APPLES", ),

  // fts5 syntax tests
  ("像 AND 走る", ),    // 1. Boolean AND
  ("リンゴ OR 図書館", ), // 2. Boolean OR
  ("勉強*", ),         // 3. Prefix search
  ("赤い*", ),         // 4. Prefix search
  ("リンゴ AND OR", ), // 5. invalid fts5 Syntax
];



TagBankV3Entry expectedTag(
  String name,
  String category,
  int order,
  String notes,
  IndexEntry index) => TagBankV3Entry(
    id: 0,
    indexEntry: index,
    name: name,
    category: category,
    sortingOrder: order,
    notes: notes,
    score: 0
);

final List<List<ExampleSearchResult>?> exampleSentenceTestExpectedValues = [
  [
    ExampleSearchResult(
      sourceEntries: [ExampleEntry(
        id: 0, indexEntry: dummyIndexBank1Jpn, groupId: 100,
        sentence: "リンゴを食べます",
        tags: [
          expectedTag("fruit", "category", 1, "Food related examples", dummyIndexBank1Jpn),
          expectedTag("license:CC-BY-4.0", "license", 3, "Creative Commons Attribution 4.0", dummyIndexBank1Jpn),
          expectedTag("tatoeba", "source", 2, "Imported from Tatoeba project", dummyIndexBank1Jpn),
        ], 
        stats: [
          const StatEntry(id: 0, statName: "JLPT", value: 1.0, displayValue: "N5"), 
          const StatEntry(id: 0, statName: "difficulty", displayName: "Difficulty", value: 2.5),
          const StatEntry(id: 0, statName: "freq", displayName: "Frequency", value: 120.0, displayValue: "uncommon"),
          const StatEntry(id: 0, statName: "quality", value: 5.0),
        ],
        audios: [
          ExampleAudioEntry(
            id: 0,
            path: "media/apple_a.mp3", name: "apple_a.mp3",
            tags: [], stats: [],
          ),
          ExampleAudioEntry(
            id: 0,
            path: "media/apple_b.mp3", name: "apple_b.mp3",
            tags: [
              expectedTag("female", "gender", 1, "Female voice", dummyIndexBank1Jpn),
              expectedTag("native", "speaker", 1, "Native speaker audio", dummyIndexBank1Jpn),
              expectedTag("tokyo", "accent", 2, "Tokyo pitch accent", dummyIndexBank1Jpn),
            ], 
            stats: [
              const StatEntry(id: 0, statName: "clarity", displayName: "Clarity", value: 4.0),
              const StatEntry(id: 0, statName: "speed", displayName: "Speed", value: 3.5, displayValue: "normal"),
            ],
          ),
        ],
      )],
      targetEntries: [],
    )
  ],

  [
    ExampleSearchResult(
      sourceEntries: [ExampleEntry(
        id: 0, indexEntry: dummyIndexBank1Jpn, groupId: 101,
        sentence: "犬が走る", 
        tags: [], stats: [], audios: [],
      )],
      targetEntries: [],
    )
  ],

  [
    ExampleSearchResult(
      sourceEntries: [ExampleEntry(
        id: 0, indexEntry: dummyIndexBank1Jpn, groupId: 102,
        sentence: "猫が寝る",
        tags: [], 
        stats: [const StatEntry(id: 0, statName: "quality", value: 3.5)],
        audios: [
          ExampleAudioEntry(
            id: 0,
            path: "media/cat.mp3", name: "cat.mp3",
            tags: [
              expectedTag("tts", "speaker", 3, "Text-to-speech generated audio", dummyIndexBank1Jpn)
            ],
            stats: [const StatEntry(id: 0, statName: "quality", value: 2.0)],
          ),
        ],
      )],
      targetEntries: [],
    )
  ],

  [
    ExampleSearchResult(
      sourceEntries: [ExampleEntry(
        id: 0, indexEntry: dummyIndexBank3Eng, groupId: 103,
        sentence: "I eat apples.", 
        tags: [], 
        stats: [const StatEntry(id: 0, statName: "quality", value: 4.5)], 
        audios: [],
      )],
      targetEntries: [],
    )
  ],

  [
    ExampleSearchResult(
      sourceEntries: [ExampleEntry(
        id: 0, indexEntry: dummyIndexBank1Jpn, groupId: 102,
        sentence: "「apple」を食べます", 
        tags: [], stats: [], audios: [],
      )],
      targetEntries: [],
    ),
    ExampleSearchResult(
      sourceEntries: [ExampleEntry(
        id: 0, indexEntry: dummyIndexBank3Eng, groupId: 10,
        sentence: "Apple", 
        tags: [], stats: [], audios: [],
      )],
      targetEntries: [],
    )
  ],

  [],

  [],

  [],

  [
    ExampleSearchResult(
      sourceEntries: [ExampleEntry(
        id: 0, indexEntry: dummyIndexBank1Jpn, groupId: 100,
        sentence: "リンゴを食べます",
        tags: [
          expectedTag("fruit", "category", 1, "Food related examples", dummyIndexBank1Jpn),
          expectedTag("license:CC-BY-4.0", "license", 3, "Creative Commons Attribution 4.0", dummyIndexBank1Jpn),
          expectedTag("tatoeba", "source", 2, "Imported from Tatoeba project", dummyIndexBank1Jpn),
        ], 
        stats: [
          const StatEntry(id: 0, statName: "JLPT", value: 1.0, displayValue: "N5"), 
          const StatEntry(id: 0, statName: "difficulty", displayName: "Difficulty", value: 2.5),
          const StatEntry(id: 0, statName: "freq", displayName: "Frequency", value: 120.0, displayValue: "uncommon"),
          const StatEntry(id: 0, statName: "quality", value: 5.0),
        ],
        audios: [
          ExampleAudioEntry(
            id: 0,
            path: "media/apple_a.mp3", name: "apple_a.mp3",
            tags: [], stats: [],
          ),
          ExampleAudioEntry(
            id: 0,
            path: "media/apple_b.mp3", name: "apple_b.mp3",
            tags: [
              expectedTag("female", "gender", 1, "Female voice", dummyIndexBank1Jpn),
              expectedTag("native", "speaker", 1, "Native speaker audio", dummyIndexBank1Jpn),
              expectedTag("tokyo", "accent", 2, "Tokyo pitch accent", dummyIndexBank1Jpn),
            ], 
            stats: [
              const StatEntry(id: 0, statName: "clarity", displayName: "Clarity", value: 4.0),
              const StatEntry(id: 0, statName: "speed", displayName: "Speed", value: 3.5, displayValue: "normal"),
            ],
          ),
        ],
      )],
      targetEntries: [],
    )
  ],

  [
    ExampleSearchResult(
      sourceEntries: [ExampleEntry(
        id: 0, indexEntry: dummyIndexBank3Eng, groupId: 103,
        sentence: "I eat apples.", 
        tags: [], 
        stats: [const StatEntry(id: 0, statName: "quality", value: 4.5)], 
        audios: [],
      )],
      targetEntries: [],
    )
  ],


  // --- fts5 tests ---
  // Query: "猫 AND 走る" (Matches groupId 104)
  [
    ExampleSearchResult(
      sourceEntries: [ExampleEntry(
        id: 0, indexEntry: dummyIndexBank1Jpn, groupId: 104,
        sentence: "速い像が赤い家を走る",
        tags: [], stats: [], audios: [],
      )],
      targetEntries: [],
    )
  ],

  // Query: "リンゴ OR 図書館" (Matches groupId 100 and 105)
  [
    ExampleSearchResult(
      sourceEntries: [ExampleEntry(
        id: 0, indexEntry: dummyIndexBank1Jpn, groupId: 100,
        sentence: "リンゴを食べます",
        tags: [
          expectedTag("fruit", "category", 1, "Food related examples", dummyIndexBank1Jpn),
          expectedTag("license:CC-BY-4.0", "license", 3, "Creative Commons Attribution 4.0", dummyIndexBank1Jpn),
          expectedTag("tatoeba", "source", 2, "Imported from Tatoeba project", dummyIndexBank1Jpn),
        ], 
        stats: [
          const StatEntry(id: 0, statName: "JLPT", value: 1.0, displayValue: "N5"), 
          const StatEntry(id: 0, statName: "difficulty", displayName: "Difficulty", value: 2.5),
          const StatEntry(id: 0, statName: "freq", displayName: "Frequency", value: 120.0, displayValue: "uncommon"),
          const StatEntry(id: 0, statName: "quality", value: 5.0),
        ],
        audios: [
          ExampleAudioEntry(id: 0, path: "media/apple_a.mp3", name: "apple_a.mp3", tags: [], stats: []),
          ExampleAudioEntry(
            id: 0, path: "media/apple_b.mp3", name: "apple_b.mp3",
            tags: [
              expectedTag("female", "gender", 1, "Female voice", dummyIndexBank1Jpn),
              expectedTag("native", "speaker", 1, "Native speaker audio", dummyIndexBank1Jpn),
              expectedTag("tokyo", "accent", 2, "Tokyo pitch accent", dummyIndexBank1Jpn),
            ], 
            stats: [
              const StatEntry(id: 0, statName: "clarity", displayName: "Clarity", value: 4.0),
              const StatEntry(id: 0, statName: "speed", displayName: "Speed", value: 3.5, displayValue: "normal"),
            ],
          ),
        ],
      )],
      targetEntries: [],
    ),
    ExampleSearchResult(
      sourceEntries: [ExampleEntry(
        id: 0, indexEntry: dummyIndexBank1Jpn, groupId: 105,
        sentence: "図書館で静かに勉強する",
        tags: [], stats: [], audios: [],
      )],
      targetEntries: [],
    )
  ],

  // Query: "勉強*" (Matches groupId 105)
  [
    ExampleSearchResult(
      sourceEntries: [ExampleEntry(
        id: 0, indexEntry: dummyIndexBank1Jpn, groupId: 105,
        sentence: "図書館で静かに勉強する",
        tags: [], stats: [], audios: [],
      )],
      targetEntries: [],
    )
  ],

  // Query: "赤い*" (Matches groupId 104)
  [
    ExampleSearchResult(
      sourceEntries: [ExampleEntry(
        id: 0, indexEntry: dummyIndexBank1Jpn, groupId: 104,
        sentence: "速い像が赤い家を走る",
        tags: [], stats: [], audios: [],
      )],
      targetEntries: [],
    )
  ],

  // Query: "リンゴ AND OR" (Invalid Syntax)
  null,
];

