import 'package:dakanji_db_core/database/example/example_entry.dart';

import '../dictionary_test_variables.dart';


List<String> exampleTextsTestQueries = [
  "東京",
  "慣れる",
  "持ち主",
  "アニメーション"
];

List<ExampleEntry> exampleTextTestsExpectedValues = [
  ExampleEntry(
    id: 0,
    indexEntry: exampleTextsIndexEntry,
    example: "東京に暮らす男子高校生・瀧は、夢を見ることをきっかけに田舎町の女子高生・三葉と入れ替わるようになる。",
    translations: []
  ),
  ExampleEntry(
    id: 0,
    indexEntry: exampleTextsIndexEntry,
    example: "慣れない女子の身体、未知の田舎暮らしに戸惑いつつ、徐々に馴染んでいく瀧。",
    translations: []
  ),
  ExampleEntry(
    id: 0,
    indexEntry: exampleTextsIndexEntry,
    example: "身体の持ち主である三葉のことをもっと知りたいと瀧が思い始めたころ、普段と違う三葉を疑問に思った周りの人たちも彼女のことを考え出して――。",
    translations: []
  ),
  ExampleEntry(
    id: 0,
    indexEntry: exampleTextsIndexEntry,
    example: "新海誠監督長編アニメーション『君の名は。』の世界を掘り下げる、スニーカー文庫だけの特別編。",
    translations: []
  ),
];