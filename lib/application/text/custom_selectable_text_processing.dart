// Package imports:
import 'package:da_kanji_mobile/application/japanese_text_processing/deconjugate.dart';
import 'package:kana_kit/kana_kit.dart';
import 'package:mecab_for_dart/mecab_dart.dart';
import 'package:tuple/tuple.dart';
import 'package:mecab_for_dart/token_node.dart';



/// Finds and returns the maximum length word given by the list `mecabTokens`.
/// The search starts at the first element of `mecabTokens`
List<String> selectMaxLengthWord(List<TokenNode> mecabTokens){

  List<String> ret = [mecabTokens.first.surface];

  // if this is the beginning of a verb
  // TODO handle adjectives
  // TODO improve selection
  if(mecabTokens.first.features[1] == startPos){
    for (var i = 1; i < mecabTokens.length; i++) {
    
      // search for all its parts
      List<String> nextFeatures = mecabTokens[i].features;
      if (nextFeatures[0] == verb ||
        nextFeatures[5] == "基本形" ||
        nextFeatures[1] == conjunctionParticle){
        
        ret.add(mecabTokens[i].surface);

      }
      else { break; }
    } 
  }

  return ret;

}

/// Processes the given `text` with mecab. Returns the result as a tuple
/// mecabReadings, mecabSurfaces and mecabPOS
Tuple3 processText(String text, Mecab mecab, KanaKit kanaKit){
  
  // analyze text with mecab
  List<TokenNode> analyzedText = mecab.parse(text);
  // remove EOS symbol
  analyzedText.removeLast(); 

  List<String> mecabReadings = [];
  List<String> mecabSurfaces = [];
  List<String> mecabPOS = [];
  int txtCnt = 0;
  for (var i = 0; i < analyzedText.length; i++) {
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
      mecabReadings.add(analyzedText[i].features[9]);
    }

    mecabPOS.add(analyzedText[i].features.sublist(0, 4).join("-"));
    
    // check if this is a word that can be deconjugated
    List<String> nextWord = selectMaxLengthWord(analyzedText.sublist(i)); 
    mecabSurfaces.add(nextWord.join());
    i += nextWord.length-1;

    // add line breaks to mecab output
    if(i < analyzedText.length-1 && text[txtCnt + analyzedText[i].surface.length] == "\n"){
      while(text[txtCnt + analyzedText[i].surface.length] == "\n"){
        mecabPOS.add("");
        mecabSurfaces.add("\n");
        mecabReadings.add("");
        txtCnt += 1;
      }
    }
    txtCnt += nextWord.join().length;
  }

  return Tuple3(mecabReadings, mecabSurfaces, mecabPOS);
}
