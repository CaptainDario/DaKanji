// Package imports:
import 'package:get_it/get_it.dart';
import 'package:kana_kit/kana_kit.dart';
import 'package:mecab_dart/mecab_dart.dart';



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

String mainVerb = "自立";

/// A list of mecab pos that indicate that this is a valid conjugation 
List<List<String>> mecabPosToRemove = [
  
  [inflectionDependentWord],
  [verb, auxVerb]
];

List<List<String>> mecabPosCanDeconjugate = [
  [verb, auxVerb],
  [verb, mainVerb]
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

///
bool compareMecabOuts(List<String> a, List<List<String>> mecabOuts){

  for (var mecabOut in mecabOuts) {
    
    if(compareMecabOut(a, mecabOut)) return true;

  }

  return false;
}

/// Deconjugates the given `word` if it is a conjugated verb / adj 
/// or a noun with copula
String deconjugate(String word){

  String ret = "";

  if(word != "" && GetIt.I<KanaKit>().isJapanese(word)){

    List<TokenNode> nodes = GetIt.I<Mecab>().parse(word)..removeLast();
    
    bool deconjugated = false;
    for (int i = nodes.length-1; i >= 0; i--) {
      // if this token node is can be deconjugated
      if(compareMecabOuts(nodes[i].features, mecabPosCanDeconjugate)){

        // if this word has not been deconjugated
        if(!deconjugated){
          // if the word is in て-形, drop the auxillary verb
          if((i-1 >= 0 && ["て", "で"].contains(nodes[i-1].features[6]))){
          }
          // otherwise deconjugate the verb
          else{
            ret = nodes[i].features[6] + ret;
            deconjugated = true;
          }
        }
        else {
          ret = nodes[i].surface + ret;
        }
      }
      
    }
  }

  return ret;
}
