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
    example: "新しい環境に慣れるまで時間がかかる。",
    translations: []
  ),
  ExampleEntry(
    id: 0,
    indexEntry: exampleTextsIndexEntry,
    example: "彼はその家の持ち主です。",
    translations: []
  ),
  ExampleEntry(
    id: 0,
    indexEntry: exampleTextsIndexEntry,
    example: "最新のアニメーション映画を見に行った。",
    translations: []
  ),
];