
import 'package:da_db_shared/da_db_shared.dart';
import 'package:language_processing/src/japanese/mecab_deconjugation/deconjugate.dart';
import 'package:mecab_for_dart/mecab_dart.dart';
import 'package:test/test.dart';

import 'mecab_deconjugation_test_cases.dart';

void main() async {

  Mecab mecab = await Mecab.create(dictDir: mecabDicPath);

  for (int i = 0; i < verbs.length; i++) {

    group("Mecab deconjugation", () {
      test('Deconjugating: ${verbs[i].toString()}', () async {
        print(verbs[i].toString());
        List<String> deconjugated = getDeconjugatedTerms(verbs[i].$1, mecab);
        expect(deconjugated, verbs[i].$2);
        print("output: $deconjugated");

        expect(deconjugated, verbs[i].$2);
      });
    });
  }

}
