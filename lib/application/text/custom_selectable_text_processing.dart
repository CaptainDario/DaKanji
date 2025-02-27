// Package imports:
import 'package:kana_kit/kana_kit.dart';
import 'package:mecab_for_flutter/mecab_for_flutter.dart';
import 'package:tuple/tuple.dart';

// Project imports:
import 'package:da_kanji_mobile/application/japanese_text_processing/mecab_data.dart';



/// Finds and returns the maximum length word given by the list `mecabTokens`.
/// The search starts at the first element of `mecabTokens`
/// 
/// returns the first [TokeNode] if it is a standalone token
/// Otherwise returns a list of all tokennodes 
List<TokenNode> selectMaxLengthWord(List<TokenNode> mecabTokens){

  List<TokenNode> nodes = [mecabTokens.first];

  if(mecabTokens.length == 1) return nodes;

  // join conjugations
  int i = 1;
  while (
    mecabTokens.first.features[4]!="*" && mecabTokens[i].features[4]!="*")
  {

    nodes.add(mecabTokens[i]);

    if(++i == mecabTokens.length) return nodes;

  }

  // add suffixes / inflection dependent words
  while (mecabTokens[i].features.first == suffix ||
        (mecabTokens[i].features.first == inflectionDependentWord &&
         mecabTokens[i].surface == "な")) {
    nodes.add(mecabTokens[i]);

    if(++i == mecabTokens.length) return nodes;
  }

  return nodes;

}

///
List<String> posFromTokeNodes(List<TokenNode> nodes){

  // check for na-adjectives
  bool naAdjectivePossible = false;
  for (var i = 0; i < nodes.length; i++) {
    for (var j = 0; j < nodes[i].features.length; j++) {

      // words that are definitely na-adj.
      if(nodes[i].features[j].contains(naAdjective) &&
        !nodes[i].features[j].contains(naAdjectivePossibility)){
        return [naAdjective];
      }
      // words that are maybe na-adj.
      if(naAdjectivePossible && nodes[i].surface == "な") {
        return [naAdjective];
      }
      if(nodes[i].features[j].contains(naAdjectivePossibility)){
        naAdjectivePossible = true;
      }

    }
  }

  return nodes.first.features.sublist(0, 4);

}

/// Processes the given `text` with mecab. Returns the result as a tuple
/// mecabReadings, mecabSurfaces and mecabPOS
Tuple3<List<String>, List<String>, List<List<String>>> processText(String text, Mecab mecab, KanaKit kanaKit){
  
  // do nothing on "empty" string
  if(text.isEmpty) return const Tuple3([], [], []);
  if(text.replaceAll(RegExp(r"\s*"), "") == "") {
    return Tuple3([" "], [text], []);
  }

  // split the text by newline as mecab does not retain those
  List<String> subTexts = text.split("\n");

  List<String> mecabReadings = [];
  List<String> mecabSurfaces = [];
  List<List<String>> mecabPOS = [];
  for (int j=0; j<subTexts.length; j++) {

    // analyze text with mecab
    List<TokenNode> analyzedText = mecab.parse(subTexts[j]);
    // remove EOS symbol
    analyzedText.removeLast(); 

    for (var i = 0; i < analyzedText.length; i++) {

      // if mecab fails to analyze, return empty
      if(analyzedText[i].features.isEmpty){
        mecabReadings.add(" "); mecabSurfaces.add("　"); mecabPOS.add([]);
        continue;
      }

      // check if this is a word that can be deconjugated
      List<TokenNode> maxLengthWord = selectMaxLengthWord(analyzedText.sublist(i));
      mecabSurfaces.add(maxLengthWord.map((e) => e.surface).join());
      List<String> pos = posFromTokeNodes(maxLengthWord);
      mecabPOS.add(pos);
      
      // remove furigana when: non Japanese, kana only, no reading, reading == word
      if(!kanaKit.isJapanese(analyzedText[i].surface) ||
        kanaKit.isKana(analyzedText[i].surface) ||
        analyzedText[i].features.length < 8 ||
        analyzedText[i].features[9] == analyzedText[i].surface
      )
      {
        mecabReadings.add(" ");
      }
      else{
        String fullReading = "";
        for (var j = 0; j < maxLengthWord.length; j++) {
          fullReading += analyzedText[i+j].features[9];
        }
        mecabReadings.add(fullReading); 
      }
      
      i += maxLengthWord.length-1;
  
    }
    // readd new lines
    if(subTexts.length-1 != j){
      mecabReadings.add(""); mecabSurfaces.add("\n"); mecabPOS.add([]);
    }
  }

  return Tuple3(mecabReadings, mecabSurfaces, mecabPOS);
}
