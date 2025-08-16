
import 'dart:convert';

import 'package:dakanji_db/database/example/example_entry.dart';
import 'package:universal_io/io.dart';


List<String> exampleSentencesTestQueries = ["勉強"];

List<ExampleEntry> examplesTestExpected = List.generate(2, (i) => 
    "test/examples/example_sentences_expected_value_${i+1}.json"
  ).map((e) => ExampleEntry.fromJson(jsonDecode(File(e).readAsStringSync())))
  .toList();