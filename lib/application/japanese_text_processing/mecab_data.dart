/// verb
String verb = "動詞";
/// adverb
String adverb = "副詞";
/// i adjective
String iAdjective = "形容詞";
/// na adjective
String naAdjective = "形状詞";
/// this word can be a na-adjective under certain circumstances 
String naAdjectivePossibility = "形状詞可能";
/// noun
String noun = "名詞";
/// pronoun
String pronoun = "代名詞";
/// PoS for particles
String particle = "助詞";
/// White space
String whiteSpace = "空白";


/// Inflection dependent word
String inflectionDependentWord = "助動詞";
/// Conjunction particle
String conjunctionParticle = "接続助詞";
/// Words that cannot standalone
String nonIndependent = "非自立可能";
/// Suffix
String suffix = "接尾辞";
/// The verb / adjective that starts this word
String startPos = "一般";



List<String> mecabPosDeconjugate = [
  verb, iAdjective, naAdjective,
  //noun
];

/// A list of mecab pos combinations that indicate a word start
List<List<String>> mecabPosWordStart = [
  // verb
  [verb],
  [particle, conjunctionParticle],
  // i-adj
  [iAdjective, startPos],
  [iAdjective, nonIndependent],
  // na-adj
  [naAdjective, startPos],
  [naAdjective, nonIndependent],
  // nouns
  [noun]
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
