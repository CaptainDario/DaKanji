import 'package:da_db/data/dictionary_types.dart';
import 'package:da_db/database/example/example_entry.dart';
import 'package:da_db/database/example/example_search_result.dart';
import 'package:da_db/database/index/index_table_entry.dart';
import 'package:da_db/database/stats/stat_entry.dart';
import 'package:da_db/database/tag/tag_bank_v3_entry.dart';
import 'package:language_processing/language_processing.dart';

final dummyIndex = IndexEntry(
  id: 0, isDefaultDictionary: true, enabled: true, dictionaryType: DictionaryTypes.examples, 
  currentSortingOrder: 0, currentFrequencyDictionary: false, title: "Test Example Dictionary", 
  revision: "2024-01-01", format: 3, sequenced: true, author: "Test Author", 
  description: "A dictionary for testing the example parser.",
);

TagBankV3Entry dummyTag(String name) => TagBankV3Entry(
  id: 0, indexEntry: dummyIndex, name: name, category: 'tag', sortingOrder: 0, notes: '', score: 0
);

final List<(List<String>, List<Iso639_3>)> exampleTextTestQueries = [
  (["リンゴ"], [Iso639_3.jpn]),
  (["犬"], [Iso639_3.jpn]),
  (["猫"], [Iso639_3.jpn]),
  
  (["入れ替わる"], [Iso639_3.jpn]),
  (["戸惑いつつ"], [Iso639_3.jpn]),
  (["思い始めた"], [Iso639_3.jpn]),
  (["新海誠"], [Iso639_3.jpn]),
];

final List<List<ExampleSearchResult>> exampleTextTestExpectedValues = [
  [
    ExampleSearchResult(
      sourceEntries: [ExampleEntry(
        id: 0, indexEntry: dummyIndex, groupId: 200,
        sentence: "リンゴを食べます。", 
        languageCode: "jpn",
        tags: [dummyTag("test_tag"), dummyTag("text_import")], 
        stats: [const StatEntry(id: 0, statName: "quality", value: 5.0)],
        audios: [],
      )],
      targetEntries: [],
    )
  ],
  [
    ExampleSearchResult(
      sourceEntries: [ExampleEntry(
        id: 0, indexEntry: dummyIndex, groupId: 200,
        sentence: "犬が走る。", 
        languageCode: "jpn",
        tags: [dummyTag("test_tag"), dummyTag("text_import")],
        stats: [const StatEntry(id: 0, statName: "quality", value: 5.0)],
        audios: [],
      )],
      targetEntries: [],
    )
  ],
  [
    ExampleSearchResult(
      sourceEntries: [ExampleEntry(
        id: 0, indexEntry: dummyIndex, groupId: 0, 
        sentence: "猫が寝る。", 
        languageCode: "jpn", 
        tags: [], stats: [], audios: [],
      )],
      targetEntries: [],
    )
  ],
  
  [
    ExampleSearchResult(
      sourceEntries: [ExampleEntry(
        id: 0, indexEntry: dummyIndex, groupId: 0, 
        sentence: "東京に暮らす男子高校生・瀧は、夢を見ることをきっかけに田舎町の女子高生・三葉と入れ替わるようになる。", 
        languageCode: "jpn", 
        tags: [], stats: [], audios: [],
      )],
      targetEntries: [],
    )
  ],
  [
    ExampleSearchResult(
      sourceEntries: [ExampleEntry(
        id: 0, indexEntry: dummyIndex, groupId: 0, 
        sentence: "慣れない女子の身体、未知の田舎暮らしに戸惑いつつ、徐々に馴染んでいく瀧。", 
        languageCode: "jpn", 
        tags: [], stats: [], audios: [],
      )],
      targetEntries: [],
    )
  ],
  [
    ExampleSearchResult(
      sourceEntries: [ExampleEntry(
        id: 0, indexEntry: dummyIndex, groupId: 0, 
        sentence: "身体の持ち主である三葉のことをもっと知りたいと瀧が思い始めたころ、普段と違う三葉を疑問に思った周りの人たちも彼女のことを考え出して――。", 
        languageCode: "jpn", 
        tags: [], stats: [], audios: [],
      )],
      targetEntries: [],
    )
  ],
  [
    ExampleSearchResult(
      sourceEntries: [ExampleEntry(
        id: 0, indexEntry: dummyIndex, groupId: 0, 
        sentence: "新海誠監督長編アニメーション『君の名は。』の世界を掘り下げる、スニーカー文庫だけの特別編。", 
        languageCode: "jpn", 
        tags: [], stats: [], audios: [],
      )],
      targetEntries: [],
    )
  ],
];