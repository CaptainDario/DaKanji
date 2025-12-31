import 'package:language_processing/japanese/spellfix/forbidden_sequences.dart';
import 'package:language_processing/japanese/spellfix/spellfix.dart';
import 'package:test/test.dart';

void main() {
  group('generateSpellingVariations', () {
    
    test('generates valid variations using real rules (General Sanity Check)', () {
      // Input: 'あ'
      // Rules allow: 'あ' -> 'ああ' (Category 8, Cost 2)
      final variations = generateSpellingVariations(
        word: 'あ',
        n: 10,
        maxCost: 5,
        forbiddenSequences: forbiddenSequences,
      );
      print(variations);

      expect(variations, contains('ああ')); 
    });

    test('penalizes high-step paths via substitutionPenalty', () {
      // Changed input from 'な' to 'た' so valid voicing rules exist.
      //
      // Path 1 (Direct): 'た' -> 'だ' (Cost 4). 
      //    Steps: 1. Total: 4 + (1 * 5) = 9. (<= 10, KEEP)
      //
      // Path 2 (2 Steps): 'た' -> 'たあ' (Cost 2) -> 'たああ' (Cost +2 = 4).
      //    (Using rule 'あ'->'ああ' on the suffix).
      //    Steps: 2. Total: 4 + (2 * 5) = 14. (> 10, PRUNE)
      
      final variations = generateSpellingVariations(
        word: 'た',
        n: 50,
        maxCost: 10, 
        substitutionPenalty: 5,
        forbiddenSequences: forbiddenSequences,
      );

      // 'だ' is a direct neighbor (Cost 4), so it survives the penalty.
      expect(variations, contains('だ'));
      
      // 'たああ' requires 2 steps, pushing it over the maxCost.
      expect(variations, isNot(contains('たああ')));
    });

    test('prunes outputs containing forbidden sequences (e.g. ^ん)', () {
      // Input: 'な'
      // Rule: ('な', 'んあ', 3) exists in Category 11.
      // Output 'んあ' starts with 'ん', which matches forbidden pattern r"^ん".
      
      final variations = generateSpellingVariations(
        word: 'な',
        n: 50,
        maxCost: 5,
        forbiddenSequences: forbiddenSequences,
      );
      print(variations);

      // Should contain valid variations like 'なあ' (Cost 2) OR 'だ' (Cost 4)
      expect(variations, anyOf([contains('なあ'), contains('だ')]));
      
      // But MUST NOT contain the forbidden sequence 'んあ'
      expect(variations, isNot(contains('んあ')));
    });

    test('excludes the original word from results (Cycle Pruning)', () {
      // Input: 'じ'
      // Rules: ('じ', 'ぢ', 1) AND ('ぢ', 'じ', 1) exist.
      // This creates a cycle: じ -> ぢ -> じ.
      
      final variations = generateSpellingVariations(
        word: 'じ',
        n: 50,
        maxCost: 5,
        forbiddenSequences: forbiddenSequences,
      );
      print(variations);

      // Should find the variation
      expect(variations, contains('ぢ'));
      
      // Should NOT return the input word itself
      expect(variations, isNot(contains('じ')));
    });

    test('prunes regex-based forbidden sequences (e.g. triplet vowels)', () {
      // Input: 'こお'
      // Rule: 'お' -> 'おお' (Cost 2)
      // Result: 'こ' + 'おお' = 'こおお' (Matches triplet regex)
      
      final variations = generateSpellingVariations(
        word: 'こお', 
        n: 50,
        maxCost: 5,
        forbiddenSequences: forbiddenSequences,
      );
      print(variations);

      // Valid correction should exist (e.g. 'こお' -> 'こう' from Category 4)
      expect(variations, contains('こう'));

      // Forbidden triplet should be removed
      expect(variations, isNot(contains('こおお')));
    });
  });
}