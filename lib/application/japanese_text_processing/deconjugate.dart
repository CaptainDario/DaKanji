// Package imports:
import 'package:get_it/get_it.dart';
import 'package:kana_kit/kana_kit.dart';
import 'package:mecab_for_dart/mecab_dart.dart';
import 'package:mecab_for_dart/token_node.dart';



/// verb
String verb = "動詞";
/// i adjective
String iAdjective = "形容詞";
/// na adjective
String naAdjective = "形状詞";
/// noun
String noun = "名詞";

List<String> mecabPosDeconjugate = [
  verb, iAdjective, naAdjective,
  //noun
];

/// Inflection dependent word
String inflectionDependentWord = "助動詞";
/// Conjunction particle
String conjunctionParticle = "接続助詞";
/// Auxillary verb
String auxVerb = "非自立";
/// Suffix verb
String suffixVerb = "接尾";
/// The verb / adjective that starts this word
String startPos = "自立";
/// Indicates that this is a na adjective
String nounAdjectiveBase = "形容動詞語幹";

/// A list of mecab pos combinations that indicate a word start
List<List<String>> mecabPosWordStart = [
  [verb],
  [iAdjective, startPos],
  [naAdjective, startPos],
  [noun, nounAdjectiveBase]
];

/// Compares `a` to `b`, if the strings are the same.
/// If `b` is shorter than `a`, the comparison only checks
/// the first elements
bool compareMecabOut(List<String> a, List<String?> b,){

  bool isSame = true;

  if(a[0] != b[0]){
    isSame = false;
  }
  else if(b.length > 1 && a[1] != b[1]){
    isSame = false;
  }
  else if(b.length > 2 && a[2] != b[2]){
    isSame = false;
  }
  else if(b.length > 3 && a[3] != b[3]){
    isSame = false;
  }

  return isSame;

}

/// Compares one mecab output to a list of mecab outputs.
/// If any of them are equal returns true
bool compareMecabOuts(List<String> a, List<List<String>> mecabOuts){

  for (var mecabOut in mecabOuts) {
    
    if(compareMecabOut(a, mecabOut)) return true;

  }

  return false;
}

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
