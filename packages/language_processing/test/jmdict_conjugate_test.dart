import 'package:language_processing/japanese/conjugation/jmdict_conjugate.dart';
import 'package:language_processing/japanese/conjugation/jmdict_conjugation_data/kwpos.dart';
import 'package:test/test.dart';

import 'jmdict_conjugate_test_cases.dart';

void main() {

  group('JM Dict get all conjugations', () {
    for (final testCase in conjugationTestCases) {
    
      final verb = testCase['verb'] as String;
      final posName = testCase['pos'] as String;
      final expectedConjugations = testCase['expected'] as List<String>;

      test('should return correct conjugations for "$verb"', () {
        final pos = posDescriptionToPosEnum[posName]!;
        final result = getAllConjugations(verb, pos);
        expect(result, containsAll(expectedConjugations));
      });
    }
  });
}
