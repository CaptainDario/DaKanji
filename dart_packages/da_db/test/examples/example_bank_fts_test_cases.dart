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

  // --- fts5 syntax tests ---
  ("像 AND 走る", ),    // 1. Boolean AND
  ("リンゴ OR 図書館", ), // 2. Boolean OR
  ("勉強*", ),         // 3. Prefix search
  ("赤い*", ),         // 4. Prefix search
  ("リンゴ AND OR", ), // 5. Invalid fts5 Syntax
  
  ('"速い像"', ),      // 6. Exact phrase match
  ("リンゴ NOT 図書館", ), // 7. Boolean NOT
  ("NEAR(速い 家, 5)", ), // 8. Proximity Search
  ("(リンゴ OR 猫) AND 食べます", ), // 9. Grouping / Precedence

  // --- Syntax Crash Tests ---
  ('"リンゴ', ),          // 10. Unmatched quotes (Should fail gracefully)
  ("(リンゴ OR 猫", ),     // 11. Unclosed parentheses (Should fail gracefully)
  ("NEAR(リンゴ, )", ),   // 12. Dangling NEAR (Should fail gracefully)
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
  // 1. "リンゴ"
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
            id: 0, path: "media/apple_a.mp3", name: "apple_a.mp3",
            tags: [], stats: [],
          ),
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
    )
  ],

  // 2. "犬"
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

  // 3. "猫"
  [
    ExampleSearchResult(
      sourceEntries: [ExampleEntry(
        id: 0, indexEntry: dummyIndexBank1Jpn, groupId: 102,
        sentence: "猫が寝る",
        tags: [], 
        stats: [const StatEntry(id: 0, statName: "quality", value: 3.5)],
        audios: [
          ExampleAudioEntry(
            id: 0, path: "media/cat.mp3", name: "cat.mp3",
            tags: [expectedTag("tts", "speaker", 3, "Text-to-speech generated audio", dummyIndexBank1Jpn)],
            stats: [const StatEntry(id: 0, statName: "quality", value: 2.0)],
          ),
        ],
      )],
      targetEntries: [],
    )
  ],

  // 4. "apples"
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

  // 5. "apple"
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

  // 6. "THIS_DOES_NOT_EXIST"
  [],

  // 7. ""
  [],

  // 8. "   "
  [],

  // 9. "ゴを食"
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
    )
  ],

  // 10. "APPLES"
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


  // =========================================================================
  // --- fts5 Syntax Tests ---
  // =========================================================================

  // 1. "像 AND 走る"
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

  // 2. "リンゴ OR 図書館" 
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

  // 3. "勉強*"
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

  // 4. "赤い*"
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

  // 5. "リンゴ AND OR" (Invalid Syntax)
  null,

  // 6. '"速い像"' (Exact Phrase Match)
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

  // 7. "リンゴ NOT 図書館" (Boolean NOT)
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
    )
  ],

  // 8. "NEAR(速い 家, 5)" (Proximity Search)
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

  // 9. "(リンゴ OR 猫) AND 食べます" (Grouping / Precedence)
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
    )
  ],

  // =========================================================================
  // --- Crash Tests (These should all gracefully return null) ---
  // =========================================================================
  
  // 10. '"リンゴ' (Unmatched quote)
  null,

  // 11. "(リンゴ OR 猫" (Unclosed parentheses)
  null,

  // 12. "NEAR(リンゴ, )" (Malformed NEAR)
  null,
];