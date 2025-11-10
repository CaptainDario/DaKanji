import 'package:dakanji_db_shared/dakanji_db_shared.dart';
import 'package:language_processing/japanese/furigana_matching.dart';
import 'package:mecab_for_dart/mecab_dart.dart';
import 'package:test/test.dart';

import 'furigana_matching_test_cases.dart';





void main() async {

  Mecab mecab = Mecab();
  await mecab.init(mecabDynamicLibPath, mecabDicPath, true);

  group("Furigana matching:", () {
    for (var testCase in testCases) {
      test('Matching furigana for: ${testCase.$1}', () async {
        print("Input: ${testCase.$1['kanji']} → ${testCase.$1['kana']}");
        
        List<FuriganaPair> result = matchFurigana(testCase.$1["kanji"]!, testCase.$1["kana"]!, convertToKatakana: true);
        print("Output: ${result.toString()}");
        expect(result, equals(testCase.$2));
        print("----");
      });
    }
  });

}
