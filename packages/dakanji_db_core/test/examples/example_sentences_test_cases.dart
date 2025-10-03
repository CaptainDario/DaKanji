
import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:dakanji_db_core/database/example/example_entry.dart';
import 'package:language_processing/iso/iso_table.dart';
import 'package:universal_io/io.dart';
import 'package:path/path.dart' as p;

import 'package:dakanji_db_shared/paths.dart';
import '../util/files.dart';


List<(String, List<Iso639_1>)> exampleSentencesTestQueries = [
  ("勉強", [Iso639_1.en, Iso639_1.de]),
  ("勉強", [Iso639_1.de]),
];

List<List<ExampleEntry>> exampleSentenceTestExpectedValues = Directory(p.join(coreTestsPath, "examples"))
  .listSync().whereType<File>()
  .map((e) => File(e.absolute.path))
  .where((e) => p.basename(e.path).startsWith("example_sentences_test_case_"))
  .toList()
  .sorted((a, b) => (extractNumber(a)).compareTo(extractNumber(b)))
  .map((e) => List.from(jsonDecode(e.readAsStringSync())))
  .map((List testCase) =>
    testCase.map((e) => ExampleEntry.fromJson(e)).toList()
  )
  .toList();