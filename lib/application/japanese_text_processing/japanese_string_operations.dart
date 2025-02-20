/// String that can be used for Regex that matches any Kana character
const String kanaRegexGroupString = "ぁ-んァ-ン";
/// Regex that matches any Kana character
final RegExp kanaRegex = RegExp("([$kanaRegexGroupString])");
/// String that can be used for Regex that matches any Kanji character
const String kanjiRegexGroupString = "\u4e00-\u9faf\u3400-\u4dbf々";
/// Regex that matches any Kanji character
final RegExp kanjiRegex = RegExp("([$kanjiRegexGroupString])");
/// Regex that matches everything except Japnaese characters ie.: Kanji / Kana
final RegExp japaneseCharacterRegex =
  RegExp("[$kanaRegexGroupString$kanjiRegexGroupString]", multiLine: true);
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
/// Regex that matches a paragraph
RegExp paragraphRegex = RegExp(
  r"(.+?):?(\n\n|$)",
  multiLine: false,
  dotAll: true
);
/// Regex that matchs all question marks
RegExp questionMarkRegex = RegExp(r"\?|\﹖|\︖|\？");
/// Regex that matchs all asteriks
RegExp asteriksMarkRegex = RegExp(r"\*|\＊");
/// Regex that matchs all raw wildcards
RegExp rawWildcardRegex = RegExp('${questionMarkRegex.pattern}|${asteriksMarkRegex.pattern}');
/// Regex that matchs all wildcards used in the wildcard
RegExp wildcardRegex = RegExp(r"\?|\*");


/// Given the list of string `words` removes all kana from it and returns a list
/// containing all kanji
List<String> removeKana(List<String> words) {
  
  var allKanji = words.map((String s) => 
    s.replaceAll(kanaRegex, "")).toList().join("").split("");   
  var uniqueKanji = allKanji.toSet().toList();
  
  return uniqueKanji;
}

/// Given the list of string `words` removes all characters that are not kanji
///  from it and returns a list containing all kanji
List<String> removeAllButKanji(List<String> words) {
  
  List<String> uniqueKanji = [];
  
  for (String word in words) {
    for (int i = 0; i < word.length; i++) {
      if(!uniqueKanji.contains(word[i]) && kanjiRegex.hasMatch(word[i])){
        uniqueKanji.add(word[i]);
      }
    }
  }
  
  return uniqueKanji;
}