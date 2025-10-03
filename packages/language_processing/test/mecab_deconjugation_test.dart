
import 'package:kana_kit/kana_kit.dart';
import 'package:language_processing/japanese/conjugation/mecab_deconjugate.dart';
import 'package:mecab_for_dart/mecab_dart.dart';
import 'package:test/test.dart';
import 'package:dakanji_db_shared/dakanji_db_shared.dart';
import 'mecab_deconjugation_test_cases.dart';

void main() async {

  Mecab mecab = Mecab();
  await mecab.init(mecabDynamicLibPath, mecabDicPath, true);

  for (int i = 0; i < verbs.length; i++) {

    group("Mecab deconjugation", () {
      test('Deconjugating: ${verbs[i].toString()}', () async {
        print(verbs[i].toString());
        List<String> deconjugated = getDeconjugatedTerms(
          verbs[i].$1, mecab, const KanaKit());
        expect(deconjugated, verbs[i].$2);
        print("output: $deconjugated");

        expect(deconjugated, verbs[i].$2);
      });
    });
  }

}
