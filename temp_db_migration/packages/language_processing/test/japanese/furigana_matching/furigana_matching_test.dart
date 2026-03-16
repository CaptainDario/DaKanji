import 'package:language_processing/language_processing.dart';
import 'package:language_processing/src/japanese/term_reading_pair/furigana_matching.dart';
import 'package:test/test.dart';

import 'furigana_matching_test_cases.dart';





void main() async {

  group("Furigana matching:", () {
    for (var testCase in testCases) {
      test('Matching furigana for: ${testCase.$1}', () async {
        print("Input: ${testCase.$1['kanji']} → ${testCase.$1['kana']}");
        
        List<TermReadingPair> result = matchFurigana(
          testCase.$1["kanji"]!,
          testCase.$1["kana"]!,
          convertToKatakana: testCase.$3,
        );
        print("Output: ${result.toString()}");
        expect(result, equals(testCase.$2));
        print("----");
      });
    }
  });

}
