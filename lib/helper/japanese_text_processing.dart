import 'package:get_it/get_it.dart';
import 'package:kana_kit/kana_kit.dart';
import 'package:mecab_dart/mecab_dart.dart';



/// String that can be used for Regex that matches any Kana character
String kanaRegexString = "([\u3040-\u309f]|[\u3040-\u30ff])";
/// Regex that matches any Kana character
RegExp kanaRegex = RegExp(kanaRegexString);
/// String that can be used for Regex that matches any Kanji character
String kanjiRegexString = "([\u4e00-\u9faf]|[\u3400-\u4dbf])";
/// Regex that matches any Kanji character
RegExp kanjiRegex = RegExp(kanjiRegexString);

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

/// Deconjugates the given `text` if it is a conjugated verb / adj 
/// or a noun with copula
String deconjugate(String text){

  String ret = "";

  if(GetIt.I<KanaKit>().isJapanese(text)){
    List<TokenNode> nodes = GetIt.I<Mecab>().parse(text);
    
    for (int i = 0; i < nodes.length; i++) {
      // if the input is a verb / adjective / noun
      if((nodes[i].features[0] == "動詞" || nodes[i].features[0] == "形容詞" ||
        nodes[i].features[0] == "形状詞" || nodes[i].features[0] == "名詞")
        // and the next pos is a conjugation
        && nodes.length > i+1 && nodes[i+1].features[0].contains("助動詞")
        )
      {
        // convert to dictionary form...
        // ... kanji if the user entered kanji
        if(!GetIt.I<KanaKit>().isKana(text))
          ret += nodes[i].features[10];
        // kana otherwise
        else
          ret += nodes[i].features[6];
        
        i++;
        while(nodes.length > i && nodes[i].features[0].contains("助動詞")){
          i++;
        }
      }
      else{
        ret += nodes[i].surface;
      }
    }
  }

  return ret;
}