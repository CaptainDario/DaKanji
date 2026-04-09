// test/yomitan_deconjugate_test.dart

import 'package:collection/collection.dart';
import 'package:da_db_shared/da_db_shared.dart';
import 'package:language_processing/src/japanese/yomitan_deconjugation/language_transformer.dart';
import 'package:language_processing/src/japanese/yomitan_deconjugation/transform_loader.dart';
import 'package:test/test.dart';
import 'package:path/path.dart' as p;

import 'yomitan_deconjugate_test_cases.dart';

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

bool _findMatch(DeinflectionEngine engine, DeconjugationTestCase testCase) {
  final nodes = engine.analyze(testCase.source);

  for (final node in nodes) {
    if (node.term != testCase.term) continue;

    if (testCase.rule != null) {
      final ruleMask = engine.maskForCondition(testCase.rule!);
      if (!DeinflectionEngine.checkOverlap(node.activeMask, ruleMask)) {
        continue;
      }
    }

    if (testCase.reasons != null) {
      final actualPath = node.pathIds;
      if (!const ListEquality().equals(actualPath, testCase.reasons)) {
        continue;
      }
    }

    return true; // Complete match found
  }

  return false;
}

void main() {
  final engine = DeinflectionEngine();
  final descriptor = GrammarLoader.loadFromFile(
    p.join(coreTestsPath, 'japanese-transforms.json')
  );
  engine.loadGrammar(descriptor);

  group('De-inflections', () {
    for (final data in yomitanConjugateTestCases) {
      final category = data['category'] as String;
      final isValid = data['valid'] as bool;
      final tests = data['tests'] as List;

      group(category, () {
        for (final testCaseMap in tests) {
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
            final hasMatch = _findMatch(engine, testCase);
            expect(hasMatch, isValid);
          });
        }
      });
    }
  });
}