import 'package:da_db/data/dictionary_types.dart';
import 'package:da_db/database/example/example_audio_entry.dart';
import 'package:da_db/database/example/example_entry.dart';
import 'package:da_db/database/example/example_search_result.dart';
import 'package:da_db/database/index/index_table_entry.dart';
import 'package:da_db/database/stats/stat_entry.dart';
import 'package:da_db/database/tag/tag_bank_v3_entry.dart';
import 'package:language_processing/language_processing.dart';

final List<(String, List<Iso639_3>)> exampleSentencesTestQueries = [
  ("リンゴ", [Iso639_3.jpn]),
  ("犬", [Iso639_3.jpn]),
  ("猫", [Iso639_3.jpn]),
  ("apples", [Iso639_3.eng]),
  ("apple", [Iso639_3.jpn]),
  
  ("THIS_DOES_NOT_EXIST", [Iso639_3.jpn]),
  ("", [Iso639_3.jpn]),
  ("   ", [Iso639_3.jpn]),
  ("ゴを食", [Iso639_3.jpn]),
  ("APPLES", [Iso639_3.eng]),

  // fts5 syntax tests
  ("像 AND 走る", [Iso639_3.jpn]),    // 1. Boolean AND
  ("リンゴ OR 図書館", [Iso639_3.jpn]), // 2. Boolean OR
  ("勉強*", [Iso639_3.jpn]),         // 3. Prefix search
  ("赤い*", [Iso639_3.jpn]),         // 4. Prefix search
  ("リンゴ AND OR", [Iso639_3.jpn]), // 5. invalid fts5 Syntax
];

final dummyIndex = IndexEntry(
  id: 0, isDefaultDictionary: true, enabled: true, dictionaryType: DictionaryTypes.examples, 
  currentSortingOrder: 0, currentFrequencyDictionary: false, title: "Test Example Dictionary", 
  revision: "2024-01-01", format: 3, sequenced: true, author: "Test Author", 
  description: "A dictionary for testing the example parser.",
);

TagBankV3Entry expectedTag(String name, String category, int order, String notes) => TagBankV3Entry(
  id: 0, indexEntry: dummyIndex, name: name, category: category, sortingOrder: order, notes: notes, score: 0
);

final List<List<ExampleSearchResult>?> exampleSentenceTestExpectedValues = [
  [
    ExampleSearchResult(
      sourceEntries: [ExampleEntry(
        id: 0, indexEntry: dummyIndex, groupId: 100,
        sentence: "リンゴを食べます", languageCode: "jpn",
        tags: [
          expectedTag("fruit", "category", 1, "Food related examples"),
          expectedTag("license:CC-BY-4.0", "license", 3, "Creative Commons Attribution 4.0"),
          expectedTag("tatoeba", "source", 2, "Imported from Tatoeba project"),
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
              expectedTag("female", "gender", 1, "Female voice"),
              expectedTag("native", "speaker", 1, "Native speaker audio"),
              expectedTag("tokyo", "accent", 2, "Tokyo pitch accent"),
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
        id: 0, indexEntry: dummyIndex, groupId: 101,
        sentence: "犬が走る", 
        languageCode: "jpn",
        tags: [], stats: [], audios: [],
      )],
      targetEntries: [],
    )
  ],

  [
    ExampleSearchResult(
      sourceEntries: [ExampleEntry(
        id: 0, indexEntry: dummyIndex, groupId: 102,
        sentence: "猫が寝る", languageCode: "jpn",
        tags: [], 
        stats: [const StatEntry(id: 0, statName: "quality", value: 3.5)],
        audios: [
          ExampleAudioEntry(
            id: 0,
            path: "media/cat.mp3", name: "cat.mp3",
            tags: [
              expectedTag("tts", "speaker", 3, "Text-to-speech generated audio")
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
        id: 0, indexEntry: dummyIndex, groupId: 103,
        sentence: "I eat apples.", 
        languageCode: "eng",
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
        id: 0, indexEntry: dummyIndex, groupId: 100,
        sentence: "「apple」を食べます", 
        languageCode: "jpn",
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
        id: 0, indexEntry: dummyIndex, groupId: 100,
        sentence: "リンゴを食べます", languageCode: "jpn",
        tags: [
          expectedTag("fruit", "category", 1, "Food related examples"),
          expectedTag("license:CC-BY-4.0", "license", 3, "Creative Commons Attribution 4.0"),
          expectedTag("tatoeba", "source", 2, "Imported from Tatoeba project"),
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
              expectedTag("female", "gender", 1, "Female voice"),
              expectedTag("native", "speaker", 1, "Native speaker audio"),
              expectedTag("tokyo", "accent", 2, "Tokyo pitch accent"),
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
        id: 0, indexEntry: dummyIndex, groupId: 103,
        sentence: "I eat apples.", 
        languageCode: "eng",
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
        id: 0, indexEntry: dummyIndex, groupId: 104,
        sentence: "速い像が赤い家を走る", languageCode: "jpn",
        tags: [], stats: [], audios: [],
      )],
      targetEntries: [],
    )
  ],

  // Query: "リンゴ OR 図書館" (Matches groupId 100 and 105)
  [
    ExampleSearchResult(
      sourceEntries: [ExampleEntry(
        id: 0, indexEntry: dummyIndex, groupId: 100,
        sentence: "リンゴを食べます", languageCode: "jpn",
        tags: [
          expectedTag("fruit", "category", 1, "Food related examples"),
          expectedTag("license:CC-BY-4.0", "license", 3, "Creative Commons Attribution 4.0"),
          expectedTag("tatoeba", "source", 2, "Imported from Tatoeba project"),
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
              expectedTag("female", "gender", 1, "Female voice"),
              expectedTag("native", "speaker", 1, "Native speaker audio"),
              expectedTag("tokyo", "accent", 2, "Tokyo pitch accent"),
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
        id: 0, indexEntry: dummyIndex, groupId: 105,
        sentence: "図書館で静かに勉強する", languageCode: "jpn",
        tags: [], stats: [], audios: [],
      )],
      targetEntries: [],
    )
  ],

  // Query: "勉強*" (Matches groupId 105)
  [
    ExampleSearchResult(
      sourceEntries: [ExampleEntry(
        id: 0, indexEntry: dummyIndex, groupId: 105,
        sentence: "図書館で静かに勉強する", languageCode: "jpn",
        tags: [], stats: [], audios: [],
      )],
      targetEntries: [],
    )
  ],

  // Query: "赤い*" (Matches groupId 104)
  [
    ExampleSearchResult(
      sourceEntries: [ExampleEntry(
        id: 0, indexEntry: dummyIndex, groupId: 104,
        sentence: "速い像が赤い家を走る", languageCode: "jpn",
        tags: [], stats: [], audios: [],
      )],
      targetEntries: [],
    )
  ],

  // Query: "リンゴ AND OR" (Invalid Syntax)
  null,
];

