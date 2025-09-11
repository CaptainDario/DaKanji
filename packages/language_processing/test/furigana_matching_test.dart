import 'package:language_processing/japanese/furigana_matching.dart';
import 'package:language_processing/japanese/furigana_pair.dart';
import 'package:mecab_for_dart/mecab_dart.dart';
import 'package:test/test.dart';
import 'package:path/path.dart' as p;
import 'package:dakanji_db_shared/dakanji_db_shared.dart';

import 'furigana_matching_test_cases.dart';





void main() async {

  Mecab mecab = Mecab();
  await mecab.init(mecabDynamicLibPath, mecabDicPath, true);

  test('Testing deconjugation', () {
    for (var testCase in testCases) {
    print("Input: ${testCase.$1['kanji']} → ${testCase.$1['kana']}");
    
    List<FuriganaPair> result = matchFurigana(testCase.$1["kanji"]!, testCase.$1["kana"]!);
    print("Output: ${result.toString()}");
    expect(result, equals(testCase.$2));
    print("----");
  }
  });

}
