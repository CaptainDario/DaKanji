import 'package:collection/collection.dart';
import 'package:language_processing/japanese/conjugation/yomitan_conjugation_data/language_transformer.dart';
import 'package:test/test.dart';

// Your library imports

import 'package:language_processing/japanese/conjugation/yomitan_conjugation_data/japanese_transforms.dart';

// Import the externally defined test cases
import 'yomitan_conjugate_test_cases.dart';

/// A data class to hold test case data for better type safety.
class DeconjugationTestCase {
  final String source;
  final String term;
  final String? rule;
  final List<String>? reasons;

  DeconjugationTestCase({
    required this.source,
    required this.term,
    this.rule,
    this.reasons,
  });
}

/// This is the Dart equivalent of the `hasTermReasons` helper function from the JS test runner.
///
/// It checks if any deconjugation path for [source] perfectly matches the
/// expected term, rule, and reasons.
bool _findMatch(
  LanguageTransformer transformer,
  DeconjugationTestCase testCase,
) {
  final results = transformer.transform(testCase.source);

  for (final result in results) {
    if (result.text != testCase.term) {
      continue;
    }

    if (testCase.rule != null) {
      final expectedConditions =
          transformer.getConditionFlagsFromConditionType(testCase.rule!);
      if (!LanguageTransformer.conditionsMatch(
          result.conditions, expectedConditions)) {
        continue;
      }
    }

    // If reasons are null in the test case, we don't check them.
    // If they are not null, we check for a perfect match.
    if (testCase.reasons != null) {
      final actualReasons = result.trace.map((f) => f.transformId).toList();
      if (!const ListEquality().equals(actualReasons, testCase.reasons)) {
        // If reasons don't match, this path is not the one we're looking for.
        continue;
      }
    }

    // If we get here, it means all conditions (term, rule, reasons) matched.
    return true;
  }

  // No perfect match was found across all possible deconjugation paths.
  return false;
}

void main() {
  final transformer = LanguageTransformer();
  transformer.addDescriptor(japaneseTransforms);

  group('De-inflections', () {
    // This loop structure now uses the imported test case data.
    for (final data in yomitanConjugateTestCases) {
      final category = data['category'] as String;
      final isValid = data['valid'] as bool;
      final tests = data['tests'] as List;

      group('$category', () {
        for (final testCaseMap in tests) {
          // Convert the map from the file into our typed data class.
          final testCase = DeconjugationTestCase(
            source: testCaseMap['source'],
            term: testCaseMap['term'],
            rule: testCaseMap['rule'],
            reasons: (testCaseMap['reasons'] as List?)?.cast<String>(),
          );

          final testName =
              'should ${isValid ? '' : 'NOT '}deconjugate "${testCase.source}" to "${testCase.term}"'
              ' with reasons ${testCase.reasons}';

          test(testName, () {
            final hasMatch = _findMatch(transformer, testCase);

            // The final, crucial assertion: does the result match the expected validity?
            expect(hasMatch, isValid);
          });
        }
      });
    }
  });
}