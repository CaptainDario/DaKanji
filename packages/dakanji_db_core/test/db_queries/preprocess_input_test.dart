import 'package:dakanji_db_core/database/db_queries/dictionary_search_utils.dart';
import 'package:test/test.dart';

import 'preprocess_input_test_cases.dart';

void main() {
  group('preprocessInput', () {
    for (var i = 0; i < preprocessInputTestCases.length; i++) {
      final testCase = preprocessInputTestCases[i];
      final input = testCase.$1;
      final convertRomaji = testCase.$2;
      final expectedTerm = testCase.$3;
      final expectedHiragana = testCase.$4;

      test('Test Case ${i + 1}: input="$input", convertRomaji=$convertRomaji', () {
        final result = preprocessInput(input, convertRomaji);
        expect(result.term, equals(expectedTerm));
        expect(result.hiraganaTerm, equals(expectedHiragana));
      });
    }
  });
}