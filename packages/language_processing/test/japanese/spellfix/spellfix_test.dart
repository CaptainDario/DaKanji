import 'package:language_processing/src/japanese/spellfix/forbidden_sequences.dart';
import 'package:language_processing/src/japanese/spellfix/spellfix.dart';
import 'package:test/test.dart';

import 'spellfix_test_cases.dart';

void main() {
  group('generateSpellingVariations', () {
    
    test(spellfixTestCases[0].description, () {

      final variations = generateSpellingVariationsForTest(spellfixTestCases[0]);

      expect(variations, contains('ああ')); 
    });

    test(spellfixTestCases[1].description, () {
      final variations = generateSpellingVariationsForTest(spellfixTestCases[1]);

      // 'だ' is a direct neighbor (Cost 4), so it survives the penalty.
      expect(variations, contains('だ'));
      
      // 'たああ' requires 2 steps, pushing it over the maxCost.
      expect(variations, isNot(contains('たああ')));
    });

    test(spellfixTestCases[2].description, () {
      final variations = generateSpellingVariationsForTest(spellfixTestCases[2]);

      // Should contain valid variations like 'なあ' (Cost 2) OR 'だ' (Cost 4)
      expect(variations, anyOf([contains('なあ'), contains('だ')]));
      
      // But MUST NOT contain the forbidden sequence 'んあ'
      expect(variations, isNot(contains('んあ')));
    });

    test(spellfixTestCases[3].description, () {
      final variations = generateSpellingVariationsForTest(spellfixTestCases[3]);

      // Should find the variation
      expect(variations, contains('ぢ'));
      
      // Should NOT return the input word itself
      expect(variations, isNot(contains('じ')));
    });

    test(spellfixTestCases[4].description, () {
      final variations = generateSpellingVariationsForTest(spellfixTestCases[4]);

      // Valid correction should exist (e.g. 'こお' -> 'こう' from Category 4)
      expect(variations, contains('こう'));

      // Forbidden triplet should be removed
      expect(variations, isNot(contains('こおお')));
    });

    test(spellfixTestCases[5].description, () {
      final variations = generateSpellingVariationsForTest(spellfixTestCases[5]);

      // Ensure the forbidden variation is NOT generated
      expect(variations, isNot(contains('食べるらああゆ')));
    });
  });
}

List<String> generateSpellingVariationsForTest(({
    String description,
    String word,
    int n,
    int maxCost,
    int? substitutionPenalty,
}) args) {
  return generateSpellingVariations(
    word: args.word,
    n: args.n,
    maxCost: args.maxCost,
    substitutionPenalty: args.substitutionPenalty ?? 0,
    forbiddenSequences: forbiddenSequences,
  );
}