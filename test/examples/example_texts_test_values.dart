
import 'dart:convert';

import 'package:dakanji_db/database/example/example_entry.dart';
import 'package:universal_io/io.dart';


List<String> exampleTextsTestQueries = [
  "東京",
  "慣れる",
  "持ち主",
  "アニメーション"
];

List<ExampleEntry> exampleTextsTestExpected = List.generate(4, (i) => 
    "test/examples/example_texts_expected_value_${i+1}.json"
  ).map((e) => ExampleEntry.fromJson(jsonDecode(File(e).readAsStringSync())))
  .toList();