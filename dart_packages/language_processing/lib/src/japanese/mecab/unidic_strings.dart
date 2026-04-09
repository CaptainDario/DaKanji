

class UnidicStrings {

  /// verb
  static const String verb = "動詞";
  /// adverb
  static const String adverb = "副詞";
  /// i adjective
  static const String iAdjective = "形容詞";
  /// na adjective
  static const String naAdjective = "形状詞";
  /// this word can be a na-adjective under certain circumstances 
  static const String naAdjectivePossibility = "形状詞可能";
  /// noun
  static const String noun = "名詞";
  /// pronoun
  static const String pronoun = "代名詞";
  /// PoS for particles
  static const String particle = "助詞";
  /// White space
  static const String whiteSpace = "空白";


  /// Inflection dependent word
  static const String inflectionDependentWord = "助動詞";
  /// Conjunction particle
  static const String conjunctionParticle = "接続助詞";
  /// Words that cannot standalone
  static const String nonIndependent = "非自立可能";
  /// Suffix
  static const String suffix = "接尾辞";
  /// The verb / adjective that starts this word
  static const String startPos = "一般";



  List<String> unidicPosDeconjugate = [
    verb, iAdjective, naAdjective,
    //noun
  ];

  /// A list of mecab pos combinations that indicate a word start
  List<List<String>> unidicPosWordStart = [
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


}