import 'package:language_processing/japanese/spellfix/spellfix.dart';
import 'package:test/test.dart';

void main() {
  group('generateSpellingVariations', () {
    test('does not reapply the same substitution at the same index', () {
      const rules = <(String, String, int)>[
        ('ab', 'abb', 1),
      ];

      final variations = generateSpellingVariations(
        word: 'ab',
        n: 5,
        maxCost: 5,
        rules: rules,
      );

      expect(variations, equals(['abb']));
    });

    test('penalizes multi-step paths via substitutionPenalty', () {
      const rules = <(String, String, int)>[
        ('a', 'c', 1),
        ('c', 'd', 1),
        ('a', 'e', 2),
      ];

      final variations = generateSpellingVariations(
        word: 'ab',
        n: 5,
        maxCost: 4,
        substitutionPenalty: 2,
        rules: rules,
      );

      expect(variations, equals(['cb', 'eb']));
      expect(variations, isNot(contains('db')));
    });

    test('prunes outputs containing forbidden sequences', () {
      const rules = <(String, String, int)>[
        ('ab', 'cd', 1),
      ];
      const forbidden = <String>['cd'];

      final variations = generateSpellingVariations(
        word: 'ab',
        n: 5,
        maxCost: 5,
        rules: rules,
        forbiddenSequences: forbidden,
      );

      expect(variations, isEmpty);
    });
  });
}