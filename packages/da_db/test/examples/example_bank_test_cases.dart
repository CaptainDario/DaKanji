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
  id: 0, isDefaultDictionary: true, enabled: true, dictionaryType: DictionaryTypes.yomitan, 
  currentSortingOrder: 0, currentFrequencyDictionary: false, title: "Test Example Dictionary", 
  revision: "2024-01-01", format: 3, sequenced: true, author: "Test Author", 
  description: "A dictionary for testing the example parser.",
);

TagBankV3Entry dummyTag(String name) => TagBankV3Entry(
  id: 0, indexEntry: dummyIndex, name: name, category: 'tag', sortingOrder: 0, notes: '', score: 0
);

final List<List<ExampleEntry>> exampleSentenceTestExpectedValues = [
  // Query 1: Fully Loaded. Everything alphabetically sorted!
  [
    ExampleEntry(
      id: 0, indexEntry: dummyIndex, groupId: 100,
      sentence: "リンゴを食べます", reading: "りんごをたべます", languageCode: "jpn",
      tags: [dummyTag("fruit"), dummyTag("license:CC-BY-4.0"), dummyTag("tatoeba")], // Sorted f -> l -> t
      stats: [
        const StatEntry(statName: "JLPT", value: 1.0, displayValue: "N5"), // Sorted J -> d -> f -> q
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
          tags: [dummyTag("female"), dummyTag("native"), dummyTag("tokyo")], // Sorted f -> n -> t
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
      reading: null, 
      languageCode: "jpn",
      tags: [], stats: [], audios: [],
    )
  ],

  // Query 3: Missing Tokens Only
  [
    ExampleEntry(
      id: 0, indexEntry: dummyIndex, groupId: 102,
      sentence: "猫が寝る", reading: "ねこがねる", languageCode: "jpn",
      tags: [], 
      stats: [const StatEntry(statName: "quality", value: 3.5)],
      audios: [
        ExampleAudioEntry(
          path: "media/cat.mp3", name: "cat.mp3",
          tags: [dummyTag("tts")],
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
      reading: null, 
      languageCode: "eng",
      tags: [], 
      stats: [const StatEntry(statName: "quality", value: 4.5)], 
      audios: [],
    )
  ],
];