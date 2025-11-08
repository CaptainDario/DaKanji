import 'package:dakanji_db_core/database/db_queries/dictionary_search/dictionary_search_utils.dart';
import 'package:test/test.dart';

import 'preprocess_input_test_cases.dart';

void main() {
  group('preprocessInput', () {
    for (var i = 0; i < preprocessInputTestCases.length; i++) {
      final testCase = preprocessInputTestCases[i];
      final input = testCase.$1;
      final convertRomajiToHiragana = testCase.$2;
      final expectedNormalizedTerm = testCase.$3;
      final expectedTermVariants = testCase.$4;

      test('Test Case $input', () {
        final result = preprocessInput(input, convertRomajiToHiragana);
        expect(result.normalizedTerms, equals(expectedNormalizedTerm));
        expect(
          result.termVariants.map((e) => e.deconjugatedTerm).toList(),
          equals(expectedTermVariants)
        );
      });
    }
  });
}