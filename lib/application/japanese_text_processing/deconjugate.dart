// Package imports:
import 'package:get_it/get_it.dart';
import 'package:kana_kit/kana_kit.dart';
import 'package:mecab_for_flutter/mecab_for_flutter.dart';

// Project imports:
import 'package:da_kanji_mobile/application/japanese_text_processing/mecab_data.dart';

/// Finds all parts of the given `word` and deconjugates them
List<String> getDeconjugatedTerms(String word){

  List<String> ret = [];

  // is a a japanese word given ?
  if(word == "" || !GetIt.I<KanaKit>().isJapanese(word)) return ret;

  // parse using mecab
  List<TokenNode> nodes = GetIt.I<Mecab>().parse(word)..removeLast();

  List<String> fullDeconjugation = [];
  for (int i = nodes.length-1; i >= 0; i--){
    // if this token is the beginning of a word
    if(compareMecabOuts(nodes[i].features, mecabPosWordStart)){
      ret.add(nodes[i].features[10]);
    }
    // deconjugate the full word by only modifying the ending
    if(!compareMecabOut(nodes[i].features, [inflectionDependentWord])){

      if(fullDeconjugation.isEmpty) {
        fullDeconjugation.insert(0, nodes[i].features[10]);
      }
      else {
        fullDeconjugation.insert(0, nodes[i].surface);
      }

    }
  }
  ret.insert(0, fullDeconjugation.join());

  // remove duplicates
  ret = ret.toSet().toList();

  return ret;
}
