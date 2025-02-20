// Package imports:
import 'package:da_kanji_mobile/application/japanese_text_processing/mecab_data.dart';
import 'package:kana_kit/kana_kit.dart';
import 'package:mecab_for_flutter/mecab_for_flutter.dart';
import 'package:tuple/tuple.dart';



/// Finds and returns the maximum length word given by the list `mecabTokens`.
/// The search starts at the first element of `mecabTokens`
/// 
/// returns the first [TokeNode] if it is a standalone token
List<String> selectMaxLengthWord(List<TokenNode> mecabTokens){

  List<String> ret = [mecabTokens.first.surface];

  // if this is the beginning of a verb / adjective
  if(compareMecabOuts(mecabTokens.first.features, mecabPosWordStart)){
    for (var i = 1; i < mecabTokens.length; i++) {
    
      // search for all its parts
      List<String> nextFeatures = mecabTokens[i].features.sublist(0, 4);
      if (compareMecabOuts(nextFeatures, wordContinuationPOS)){
        
        ret.add(mecabTokens[i].surface);

      }
      else { break; }
    } 
  }

  return ret;

}

/// Processes the given `text` with mecab. Returns the result as a tuple
/// mecabReadings, mecabSurfaces and mecabPOS
Tuple3<List<String>, List<String>, List<String>> processText(String text, Mecab mecab, KanaKit kanaKit){
  
  // split the text by newline as mecab does not retain those
  List<String> subTexts = text.split("\n");

  List<String> mecabReadings = [];
  List<String> mecabSurfaces = [];
  List<String> mecabPOS = [];
  for (int j=0; j<subTexts.length; j++) {
    // analyze text with mecab
    List<TokenNode> analyzedText = mecab.parse(subTexts[j]);
    // remove EOS symbol
    analyzedText.removeLast(); 

    for (var i = 0; i < analyzedText.length; i++) {
      // check if this is a word that can be deconjugated
      List<String> maxLengthWord = selectMaxLengthWord(analyzedText.sublist(i)); 
      mecabSurfaces.add(maxLengthWord.join());
      
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

      mecabPOS.add(analyzedText[i].features.sublist(0, 4).join("-"));
      
      i += maxLengthWord.length-1;
  
    }
    // readd new lines
    mecabReadings.add(""); mecabSurfaces.add("\n"); mecabPOS.add("");
  }

  return Tuple3(mecabReadings, mecabSurfaces, mecabPOS);
}
