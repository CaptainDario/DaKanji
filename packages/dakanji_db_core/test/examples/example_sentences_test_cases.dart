
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

List<List<ExampleEntry>> exampleSentenceTestExpectedValues = _loadTestData();

// The private helper function that contains the complex logic
List<List<ExampleEntry>> _loadTestData() {
  try {
    final testFiles = Directory(p.join(coreTestsPath, "examples"))
      .listSync()
      .whereType<File>()
      .where((e) => p.basename(e.path).startsWith("example_sentences_test_case_"))
      .toList()
      ..sort((a, b) => (extractNumber(a)).compareTo(extractNumber(b))); // Use cascade operator for sorting in place

    // This is the key part: process each file within its own try-catch
    return testFiles.map((file) {
      final fileName = p.basename(file.path);
      try {
        final content = file.readAsStringSync();
        final List<dynamic> decodedJson = jsonDecode(content);
        return decodedJson
            .map((e) => ExampleEntry.fromJson(e))
            .toList();
      } catch (e) {
        // This is your debugging print! It tells you which file failed and why.
        print("❌ FAILED to parse test case file: $fileName. Error: $e");
        return <ExampleEntry>[]; // Return an empty list for the failing file
      }
    }).toList();

  } catch (e) {
    // This catches errors in the directory listing or sorting
    print("❌ FAILED to load test directory. Error: $e");
    return []; // Return an empty list if the whole process fails
  }
}