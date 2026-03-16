import 'dart:convert';
import 'dart:io';

import 'package:da_db/parsing/yomitan/in_memory_cache/term/definition_parser.dart';
import 'package:da_db_shared/paths.dart';
import 'package:path/path.dart' as p;
import 'package:test/test.dart';

import 'definition_parsing_test_cases.dart';



void main() {
  group('Yomitan Dictionary Parser Tests (File-based)', () {
    
    for (int i = 0; i < testExpectations.length; i++) {
      final int caseNumber = i + 1;
      final String fileName = 'test_case_$caseNumber.json';
      
      test('Case $caseNumber: Parses $fileName correctly', () {
        // 1. Load the specific JSON file for this test case
        final file = File(p.join(coreTestsPath, 'definition_parsing/data/$fileName'));

        if (!file.existsSync()) {
          fail('Test file not found: ${file.path}. Make sure the file exists for expectation #$caseNumber.');
        }

        final String jsonString = file.readAsStringSync();
        
        // The file should contain a SINGLE dictionary entry (a List), e.g. ["Word", "Reading", ...]
        final dynamic rawEntry = jsonDecode(jsonString);

        // 2. Verify the input format
        if (rawEntry is! List || rawEntry.isEmpty) {
          fail('Invalid JSON format in $fileName. Expected a List representing a single entry.');
        }

        // 3. Run the Parser
        final actualResult = YomitanDefinitionParser.parse(rawEntry[5]);
        final expectedResult = testExpectations[i];

        print("----------------------------------");
        print("Test Case $caseNumber: $fileName");
        print("Expected:\n$expectedResult");
        print('');
        print("Actual:\n$actualResult");

        // 4. Assertions
        expect(actualResult, isNotNull, reason: "Parser returned null for valid input in $fileName");

        // This relies on the == operator we added to ParsedDictionaryEntry in the previous step
        expect(
          actualResult, 
          equals(expectedResult), 
          reason: "Parsed object does not match expectation for $fileName"
        );
      });
    }
  });
}