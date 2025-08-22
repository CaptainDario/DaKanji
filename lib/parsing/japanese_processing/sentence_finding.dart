import 'package:mecab_for_dart/mecab_dart.dart';

/// matches full and half width punctuations
const String punctuations = "。|？|！|\\.|\\!|\\?";
/// matches japanese ending parantheses
const String japaneseParantheses = "』|」";
/// matches any whitespace
const String anyWhiteSpace = "\\s|　";
/// Regex that matches a sentence
RegExp sentenceRegex = RegExp(
  "(?:[^$anyWhiteSpace])+?(?:(?!($punctuations)$japaneseParantheses)$punctuations|\\n|\$)",
  multiLine: true
);


// Finds all sentences in the given `text` using mecab for estimation
List<String> findSentencesMecab(String text, Mecab mecab){

  List<TokenNode> tokens = mecab.parse(text);
  List<String> sentences = [];
  StringBuffer currentSentence = StringBuffer();

  for (TokenNode token in tokens) {
    if (token.surface == "EOS") {
      sentences.add(currentSentence.toString());
      currentSentence.clear();
    } else {
      currentSentence.write(token.surface);
    }
  }

  return sentences;
}

// Finds all sentences in the given `text` using a RegExp for estimation
List<String> findSentencesRegexp(String text){

  return sentenceRegex.allMatches(text)
    .map((match) => match.group(0) ?? "").toList();

}
