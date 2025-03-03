// Package imports:
import 'package:da_kanji_mobile/application/text/custom_selectable_text_processing.dart';
import 'package:get_it/get_it.dart';
import 'package:kana_kit/kana_kit.dart';
import 'package:mecab_for_dart/mecab_dart.dart';

// Project imports:
import 'package:da_kanji_mobile/application/japanese_text_processing/mecab_data.dart';



/// Finds all parts of the given `word` and deconjugates them
List<String> getDeconjugatedTerms(String word){

  List<List<String>> deconjugations = [];

  // is a Japanese word given ?
  if(word == "" || !GetIt.I<KanaKit>().isJapanese(word)) return [];

  // parse using mecab
  List<TokenNode> nodes = GetIt.I<Mecab>().parse(word)..removeLast();
  List<TokenNode> maxLengthWord = selectMaxLengthWord(nodes);

  for (int i = maxLengthWord.length-1; i >= 0; i--){
    // deconjugate the full word by only modifying the ending
    if(!compareMecabOut(maxLengthWord[i].features, [inflectionDependentWord])){

      if(deconjugations.isEmpty) {
        if(nodes[i].features[7] != nodes[i].features[10]) {
          deconjugations.add([nodes[i].features[10]]);
        }
        deconjugations.add([nodes[i].features[7]]);
      }
      else {
        deconjugations = deconjugations
          .map((List<String> f) => f..insert(0, nodes[i].surface))
          .toList();
      }
    }
  }

  // remove duplicates
  return deconjugations.map((e) => e.join())
    .toSet().toList();
}
