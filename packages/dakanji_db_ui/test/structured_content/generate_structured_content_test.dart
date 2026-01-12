import 'dart:convert';
import 'dart:io';

import 'package:dakanji_db_example/search_results/structured_content/structured_content_to_html.dart';
import 'package:dakanji_db_shared/dakanji_db_shared.dart';
import 'package:path/path.dart' as p;
import 'package:test/test.dart';



void main() {
  List<dynamic> termBankEntries = [];
  List<dynamic> testResults = [];

  // load term bank entries
  for (var i = 1; i < 3; i++) {
    termBankEntries.addAll(
      jsonDecode(
        File(p.join(
          yomitanSampleDictionaryPath, 'term_bank_$i.json'
        )).readAsStringSync()
      )
    );
  }

  // load test results
  testResults.addAll(jsonDecode(
    File(p.join(
      "test", "structured_content", "generate_structured_content_test_cases.json"
    )).readAsStringSync()
  ));

  group('Yomitan glossary HTML generation', () {
    for (var i = 0; i < termBankEntries.length; i++) {
      test('Render $i', () {
        final expectedGlossaryHtml = testResults[i];

        final actualHtml = renderDefinitions(termBankEntries);
        print("Test case $i");
        print("Actual: $actualHtml");
        print("Expected: $expectedGlossaryHtml");
        expect(actualHtml, equals(expectedGlossaryHtml));
      });
    }
  });
}
