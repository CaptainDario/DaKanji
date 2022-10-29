


/// Given the list of string `words` removes all kana from it and returns a list
/// containing all kanji
List<String> removeKana(List<String> words) {
  
  RegExp regExp = RegExp("([\u3040-\u309f]|[\u3040-\u30ff])");
  
  var allKanji = words.map((String s) => 
    s.replaceAll(regExp, "")).toList().join("").split("");   
  var uniqueKanji = allKanji.toSet().toList();
  
  return uniqueKanji;
}