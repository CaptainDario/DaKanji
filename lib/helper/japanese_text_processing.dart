// Regex that matches any Kana character
String kanaRegex = "([\u3040-\u309f]|[\u3040-\u30ff])";
// Regex that matches any Kanji character
String kanjiRegex = "([\u4e00-\u9faf]|[\u3400-\u4dbf])";

/// Given the list of string `words` removes all kana from it and returns a list
/// containing all kanji
List<String> removeKana(List<String> words) {
  
  RegExp regExp = RegExp(kanaRegex);
  
  var allKanji = words.map((String s) => 
    s.replaceAll(regExp, "")).toList().join("").split("");   
  var uniqueKanji = allKanji.toSet().toList();
  
  return uniqueKanji;
}

/// Given the list of string `words` removes all characters that are not kanji
///  from it and returns a list containing all kanji
List<String> removeAllButKanji(List<String> words) {
  
  List<String> uniqueKanji = [];

  RegExp regExp = RegExp(kanjiRegex);
  
  for (String word in words) {
    for (int i = 0; i < word.length; i++) {
      if(!uniqueKanji.contains(word[i]) && regExp.hasMatch(word[i])){
        uniqueKanji.add(word[i]);
      }
    }
  }
  
  return uniqueKanji;
}