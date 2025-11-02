import 'package:language_processing/japanese/spellfix/forbidden_sequences.dart';
import 'package:language_processing/japanese/spellfix/spellfix.dart';
import 'package:test/test.dart';

import 'spellfix_param_optim_test_cases.dart'; 

void main() {
  group('Spellfix Variation Generator Tests', () {
    // Loop through all defined test cases
    for (final tc in spellfixTestCases) {
      test(tc.description, () {
        final variations = generateSpellingVariations(
          word: tc.word,
          n: 20,
          maxCost: 10,
          substitutionPenalty: 2,
          forbiddenSequences: forbiddenSequences
        );

        // Check that all expected items are present (order doesn't matter)
        expect(variations, containsAll(tc.expected));
      });
    }
  });
}