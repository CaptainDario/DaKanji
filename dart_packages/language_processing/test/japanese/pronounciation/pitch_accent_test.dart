import 'package:language_processing/src/japanese/pronouncation/pronounciation.dart';
import 'package:test/test.dart';

import 'pitch_accent_test_cases.dart';

void main() {
  group('Japanese Pronunciation Parser |', () {
    
    group('convertToMoraList |', () {
      for (final testCase in moraTestCases) {
        test('Splits "${testCase.reading}" into morae ${testCase.expected}', () {
          final result = convertToMoraList(testCase.reading);
          expect(result, equals(testCase.expected));
        });
      }
    });

    group('generatePitchPatternString |', () {
      for (final testCase in patternTestCases) {
        test('Generates ${testCase.expected} for "${testCase.reading}" (pos: ${testCase.position})', () {
          final result = generatePitchPatternString(
            testCase.reading, 
            testCase.position,
          );
          expect(result, equals(testCase.expected));
        });
      }
    });

    group('Edge Cases & Exceptions |', () {
      test('Throws Exception on invalid pitch position (position > morae length)', () {
        // 'ねこ' is 2 morae. A downstep of 3 is linguistically impossible.
        expect(
          () => generatePitchPatternString('ねこ', 3), 
          throwsA(isA<Exception>()),
        );
      });
      
      test('Throws Exception on negative pitch position', () {
        expect(
          () => generatePitchPatternString('ねこ', -1), 
          throwsA(isA<Exception>()),
        );
      });
    });
    
  });
}