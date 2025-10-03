
import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:dakanji_db_core/database/example/example_entry.dart';
import 'package:universal_io/io.dart';
import 'package:path/path.dart' as p;

import 'package:dakanji_db_shared/paths.dart';
import '../util/files.dart';


List<String> exampleTextsTestQueries = [
  "東京",
  "慣れる",
  "持ち主",
  "アニメーション"
];

List<ExampleEntry> exampleTextTestsExpectedValues = Directory(p.join(coreTestsPath, "examples"))
  .listSync().whereType<File>()
  .map((e) => File(e.absolute.path))
  .where((e) => p.basename(e.path).startsWith("example_texts_test_case_"))
  .toList()
  .sorted((a, b) => (extractNumber(a)).compareTo(extractNumber(b)))
  .map((e) => ExampleEntry.fromJson(jsonDecode(e.readAsStringSync())))
  .toList();
