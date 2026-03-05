import 'package:da_db/data/dictionary_types.dart';
import 'package:da_db/database/example/example_audio_entry.dart';
import 'package:da_db/database/example/example_entry.dart';
import 'package:da_db/database/index/index_table_entry.dart';
import 'package:da_db/database/stats/stat_entry.dart';
import 'package:da_db/database/tag/tag_bank_v3_entry.dart';
import 'package:language_processing/language_processing.dart';

final List<(String, List<Iso639_3>)> exampleSentencesTestQueries = [
  ("リンゴ", [Iso639_3.jpn]), // 1. Fully Loaded & Sorted
  ("犬", [Iso639_3.jpn]),    // 2. Bare Minimum (Testing defaults)
  ("猫", [Iso639_3.jpn]),    // 3. Missing Tokens
  ("apples", [Iso639_3.eng]), // 4. English
];

final dummyIndex = IndexEntry(
  id: 0, isDefaultDictionary: true, enabled: true, dictionaryType: DictionaryTypes.examples, 
  currentSortingOrder: 0, currentFrequencyDictionary: false, title: "Test Example Dictionary", 
  revision: "2024-01-01", format: 3, sequenced: true, author: "Test Author", 
  description: "A dictionary for testing the example parser.",
);

/// Helper to generate the fully populated tags we expect to be pulled from the Yomitan tag banks
TagBankV3Entry expectedTag(String name, String category, int order, String notes) => TagBankV3Entry(
  id: 0, indexEntry: dummyIndex, name: name, category: category, sortingOrder: order, notes: notes, score: 0
);

final List<List<ExampleEntry>> exampleSentenceTestExpectedValues = [
  // Query 1: Fully Loaded. Everything alphabetically sorted!
  [
    ExampleEntry(
      id: 0, indexEntry: dummyIndex, groupId: 100,
      sentence: "リンゴを食べます", languageCode: "jpn",
      tags: [
        // Sorted alphabetically: f -> l -> t, populated with real tag_bank metadata!
        expectedTag("fruit", "category", 1, "Food related examples"),
        expectedTag("license:CC-BY-4.0", "license", 3, "Creative Commons Attribution 4.0"),
        expectedTag("tatoeba", "source", 2, "Imported from Tatoeba project"),
      ], 
      stats: [
        const StatEntry(statName: "JLPT", value: 1.0, displayValue: "N5"), 
        const StatEntry(statName: "difficulty", displayName: "Difficulty", value: 2.5),
        const StatEntry(statName: "freq", displayName: "Frequency", value: 120.0, displayValue: "uncommon"),
        const StatEntry(statName: "quality", value: 5.0),
      ],
      audios: [
        ExampleAudioEntry(
          path: "media/apple_a.mp3", name: "apple_a.mp3",
          tags: [], stats: [],
        ),
        ExampleAudioEntry(
          path: "media/apple_b.mp3", name: "apple_b.mp3",
          tags: [
            // Sorted alphabetically: f -> n -> t
            expectedTag("female", "gender", 1, "Female voice"),
            expectedTag("native", "speaker", 1, "Native speaker audio"),
            expectedTag("tokyo", "accent", 2, "Tokyo pitch accent"),
          ], 
          stats: [
            const StatEntry(statName: "clarity", displayName: "Clarity", value: 4.0),
            const StatEntry(statName: "speed", displayName: "Speed", value: 3.5, displayValue: "normal"),
          ],
        ),
      ],
    )
  ],

  // Query 2: Bare Minimum 
  [
    ExampleEntry(
      id: 0, indexEntry: dummyIndex, groupId: 101,
      sentence: "犬が走る", 
      languageCode: "jpn",
      tags: [], stats: [], audios: [],
    )
  ],

  // Query 3: Missing Tokens Only
  [
    ExampleEntry(
      id: 0, indexEntry: dummyIndex, groupId: 102,
      sentence: "猫が寝る", languageCode: "jpn",
      tags: [], 
      stats: [const StatEntry(statName: "quality", value: 3.5)],
      audios: [
        ExampleAudioEntry(
          path: "media/cat.mp3", name: "cat.mp3",
          tags: [
            expectedTag("tts", "speaker", 3, "Text-to-speech generated audio")
          ],
          stats: [const StatEntry(statName: "quality", value: 2.0)],
        ),
      ],
    )
  ],

  // Query 4: English
  [
    ExampleEntry(
      id: 0, indexEntry: dummyIndex, groupId: 103,
      sentence: "I eat apples.", 
      languageCode: "eng",
      tags: [], 
      stats: [const StatEntry(statName: "quality", value: 4.5)], 
      audios: [],
    )
  ],
];