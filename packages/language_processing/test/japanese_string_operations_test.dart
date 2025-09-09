

import 'package:language_processing/japanese/japanese_string_operations.dart';
import 'package:test/test.dart';

import 'japanese_string_operations_test_cases.dart';





void main() async {

  test('Testing romaji to hiragana', () {
    for (var romajiToKanaTestCase in romajiToHiraganaTestCases) {
      String result = romajiToHiragana(romajiToKanaTestCase.$1);
      expect(result, equals(romajiToKanaTestCase.$2));
    }
  });

  test('Testing removeAllButKanji', () {
    for (var testCase in extractKanjiTestCases) {
      Set<String> result = extractKanji(testCase.$1);
      // Sort for consistent comparison as order is not guaranteed.
      expect(result, equals(testCase.$2.toSet()));
    }
  });

  test('Testing toHalfWidth', () {
    for (var testCase in toHalfWidthTestCases) {
      String result = toHalfWidth(testCase.$1);
      expect(result, equals(testCase.$2));
    }
  });

  test('Testing katakanaToHiragana', () {
    for (var testCase in katakanaToHiraganaTestCases) {
      String result = katakanaToHiragana(testCase.$1);
      expect(result, equals(testCase.$2));
    }
  });

}
