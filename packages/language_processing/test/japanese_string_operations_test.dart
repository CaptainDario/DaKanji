

import 'package:language_processing/japanese/japanese_string_operations.dart';
import 'package:test/test.dart';

import 'japanese_string_operations_test_cases.dart';





void main() async {

  group("Romaji to kana", () {
    for (var romajiToKanaTestCase in romajiToHiraganaTestCases) {
      test('Converting: ${romajiToKanaTestCase.$1}', () {
        String result = romajiToHiragana(romajiToKanaTestCase.$1);
        expect(result, equals(romajiToKanaTestCase.$2));
      });
    }
  });

  group("Kanji extraction", () {
    for (var testCase in extractKanjiTestCases) {
      test('Extracting kanji from: ${testCase.$1}', () {
        Set<String> result = extractKanji(testCase.$1);
        // Sort for consistent comparison as order is not guaranteed.
        expect(result, equals(testCase.$2.toSet()));
      });
    }
  });

  group("Katakana to hiragana", () {
    for (var testCase in katakanaToHiraganaTestCases) {
      test('Converting: ${testCase.$1}', () {
        String result = katakanaToHiragana(testCase.$1);
        expect(result, equals(testCase.$2));
      });
    }
  });

}
