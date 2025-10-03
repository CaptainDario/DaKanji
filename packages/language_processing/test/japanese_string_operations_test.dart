

import 'package:language_processing/japanese/japanese_string_operations.dart';
import 'package:test/test.dart';

import 'japanese_string_operations_test_cases.dart';





void main() async {

  for (var romajiToKanaTestCase in romajiToHiraganaTestCases) {
    group("Romaji to kana", () {
      test('Converting: ${romajiToKanaTestCase.$1}', () {
        String result = romajiToHiragana(romajiToKanaTestCase.$1);
        expect(result, equals(romajiToKanaTestCase.$2));
      });
    });
  }

  for (var testCase in extractKanjiTestCases) {
    group("Kanji extraction", () {
      test('Extracting kanji from: ${testCase.$1}', () {
        Set<String> result = extractKanji(testCase.$1);
        // Sort for consistent comparison as order is not guaranteed.
        expect(result, equals(testCase.$2.toSet()));
      });
    });
  }

    for (var testCase in katakanaToHiraganaTestCases) {
      group("Katakana to hiragana", () {
        test('Converting: ${testCase.$1}', () {
          String result = katakanaToHiragana(testCase.$1);
          expect(result, equals(testCase.$2));
        });
      });
    }

}
