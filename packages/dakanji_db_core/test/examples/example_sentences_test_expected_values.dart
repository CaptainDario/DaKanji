
import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:dakanji_db_core/database/example/example_entry.dart';
import 'package:universal_io/io.dart';
import 'package:path/path.dart' as p;

import '../../bin/paths.dart';
import '../util/files.dart';


List<String> exampleSentencesTestQueries = ["勉強"];

List<List<ExampleEntry>> exampleSentenceTestExpectedValues = Directory(p.join(testsPath, "examples"))
    .listSync().whereType<File>()
    .map((e) => File(e.absolute.path))
    .where((e) => p.basename(e.path).startsWith("example_sentences_expected_value_"))
    .toList()
    .sorted((a, b) => (extractNumber(a)).compareTo(extractNumber(b)))
    .map((e) => List.from(jsonDecode(e.readAsStringSync())))
    .map((List testCase) =>
      testCase.map((e) => ExampleEntry.fromJson(e)).toList()
    )
    .toList();