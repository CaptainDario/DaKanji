import 'package:da_db/database/example/example_entry.dart';
import 'package:da_db/database/example/example_search_result.dart';
import 'package:da_db/database/stats/stat_entry.dart';
import 'package:da_db/database/tag/tag_bank_v3_entry.dart';

import 'example_test_constants.dart';



TagBankV3Entry dummyTag(String name) => TagBankV3Entry(
  id: 0, indexEntry: dummyIndexTexts1Jpn, name: name, category: 'tag', sortingOrder: 0, notes: '', score: 0
);

final List<(List<String>, )> exampleTextTestQueries = [
  (["リンゴ"], ),
  (["犬"], ),
  (["猫"], ),
  
  (["入れ替わる"], ),
  (["戸惑いつつ"], ),
  (["思い始めた"], ),
  (["新海誠"], ),
];

final List<List<ExampleSearchResult>> exampleTextTestExpectedValues = [
  [
    ExampleSearchResult(
      sourceEntries: [ExampleEntry(
        id: 0, indexEntry: dummyIndexTexts1Jpn, groupId: null,
        sentence: "リンゴを食べます。", 
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
        id: 0, indexEntry: dummyIndexTexts1Jpn, groupId: null,
        sentence: "犬が走る。", 
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
        id: 0, indexEntry: dummyIndexTexts1Jpn, groupId: null, 
        sentence: "猫が寝る。", 
        tags: [], stats: [], audios: [],
      )],
      targetEntries: [],
    )
  ],
  
  [
    ExampleSearchResult(
      sourceEntries: [ExampleEntry(
        id: 0, indexEntry: dummyIndexTexts1Jpn, groupId: null, 
        sentence: "東京に暮らす男子高校生・瀧は、夢を見ることをきっかけに田舎町の女子高生・三葉と入れ替わるようになる。", 
        tags: [], stats: [], audios: [],
      )],
      targetEntries: [],
    )
  ],
  [
    ExampleSearchResult(
      sourceEntries: [ExampleEntry(
        id: 0, indexEntry: dummyIndexTexts1Jpn, groupId: null, 
        sentence: "慣れない女子の身体、未知の田舎暮らしに戸惑いつつ、徐々に馴染んでいく瀧。", 
        tags: [], stats: [], audios: [],
      )],
      targetEntries: [],
    )
  ],
  [
    ExampleSearchResult(
      sourceEntries: [ExampleEntry(
        id: 0, indexEntry: dummyIndexTexts1Jpn, groupId: null, 
        sentence: "身体の持ち主である三葉のことをもっと知りたいと瀧が思い始めたころ、普段と違う三葉を疑問に思った周りの人たちも彼女のことを考え出して――。", 
        tags: [], stats: [], audios: [],
      )],
      targetEntries: [],
    )
  ],
  [
    ExampleSearchResult(
      sourceEntries: [ExampleEntry(
        id: 0, indexEntry: dummyIndexTexts1Jpn, groupId: null, 
        sentence: "新海誠監督長編アニメーション『君の名は。』の世界を掘り下げる、スニーカー文庫だけの特別編。", 
        tags: [], stats: [], audios: [],
      )],
      targetEntries: [],
    )
  ],
];