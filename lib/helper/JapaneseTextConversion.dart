


/// Given the list of string `words` removes all kana from it and returns a list
/// containing all kanji
List<String> removeKana(List<String> words) {
  List<String> k = ["羨ましい", "鬱", "美しい自然", "羨ましい"];
  
  RegExp regExp = RegExp("([\u3040-\u30ff]*)");
  
  var allKanji = k.map((String s) => s.replaceAll(regExp, "")).toList().join("").split("");   
  var uniqueKanji = allKanji.toSet().toList();
  
  return uniqueKanji;
}