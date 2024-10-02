// Package imports:
import 'package:kana_kit/kana_kit.dart';
import 'package:mecab_dart/mecab_dart.dart';
import 'package:tuple/tuple.dart';

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
      analyzedText[i].features[7] == analyzedText[i].surface
    )
    {
      mecabReadings.add(" ");
    }
    else{
      mecabReadings.add(kanaKit.toHiragana(analyzedText[i].features[7]));
    }
    mecabPOS.add(analyzedText[i].features.sublist(0, 4).join("-"));
    mecabSurfaces.add(analyzedText[i].surface);

    // add line breaks to mecab output
    if(i < analyzedText.length-1 && text[txtCnt + analyzedText[i].surface.length] == "\n"){
      while(text[txtCnt + analyzedText[i].surface.length] == "\n"){
        mecabPOS.add("");
        mecabSurfaces.add("\n");
        mecabReadings.add("");
        txtCnt += 1;
      }
    }
    txtCnt += analyzedText[i].surface.length;
  }

  return Tuple3(mecabReadings, mecabSurfaces, mecabPOS);
}
