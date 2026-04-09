import 'package:collection/collection.dart';
import 'package:language_processing/language_processing.dart';
import 'package:test/test.dart';

import 'preprocess_input_test_cases.dart';

void main() { 

  JapaneseProcessor jp = JapaneseProcessor(
    mecabTransferableState: null
  );

  group('preprocessInput', () {
    for (var i = 0; i < preprocessInputTestCases.length; i++) {
      final testCase = preprocessInputTestCases[i];
      final input = testCase.$1;
      final convertRomajiToHiragana = testCase.$2;
      final expectedNormalizedTerm = testCase.$3;
      final expectedTermVariants = testCase.$4;

      test('Test Case $input', () {
        final normalized = jp.normalize(input, ProcessorOptions(japaneseOptions: 
          JapaneseProcessorOptions(
            normalizationConvertsRomajiToHiragana: convertRomajiToHiragana
        )));
        expect(normalized, equals(expectedNormalizedTerm));
        final deconjugated = jp.deconjugateAll(normalized);
        expect(
          deconjugated.flattened.map((e) => e.deconjugatedTerm).toList(),
          equals(expectedTermVariants)
        );
      });
    }
  });
}