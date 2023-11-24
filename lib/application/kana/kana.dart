// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:kana_kit/kana_kit.dart';

// Project imports:
import 'package:da_kanji_mobile/globals.dart';

/// Increases the font size of the stroke numbers to `size` and sets stroke
/// number's color to `color`.
String modifyKanjiVGSvg(String svg,
  {
    int size=14, Color textColor=g_Dakanji_red, Color strokeColor=Colors.white
  }
){

  String textHexColor = textColor.value.toRadixString(16)
    .padLeft(6, '0').substring(2, 8);
  String strokeHexColor = strokeColor.value.toRadixString(16)
    .padLeft(6, '0').substring(2, 8);

  String s = svg.replaceAll(
    "<text", "<text font-size=\"$size\" fill=\"#$textHexColor\" stroke=\"#$textHexColor\""
  );
  s = s.replaceAll("stroke:#000000", "stroke:#$strokeHexColor");

  return s;
}

/// Stlyes a given svg string to fit the given theme `darkTheme`
/// Turns the mnemonics color to black/white and the kana color to red
String themeMnemonicSvg(String svgString, bool darkTheme){

  // find the two colors of the mnemonic
  RegExp colorRegExp = RegExp(r'<path.*?style="fill:#(\S+)"', dotAll: true);
  List<Match> colorMatches = colorRegExp.allMatches(svgString).toList();
  List<String> colorStrings = [colorMatches[0].group(1)!, colorMatches[1].group(1)!];

  // find the color closer to black
  List<int> colorSums = [0, 0];
  for (var i = 0; i < 3; i++) {
    colorSums[0] += int.parse(colorStrings[0].substring(i*2, i*2+2), radix: 16);
    colorSums[1] += int.parse(colorStrings[1].substring(i*2, i*2+2), radix: 16);
  }

  // replace the color (closer to black -> black/white | closer to white -> red)
  int closerToblack = colorSums[0] < colorSums[1] ? 0 : 1;
  for (var cIdx in [closerToblack, closerToblack == 0 ? 1 : 0]) {
    svgString = svgString.replaceRange(
      colorMatches[cIdx].start,
      colorMatches[cIdx].end,
      svgString.substring(
        colorMatches[cIdx].start, colorMatches[cIdx].end
      ).replaceAll(
        colorStrings[cIdx],
        cIdx == closerToblack
          ? (darkTheme ? "ffffff" : "000000")
          : g_Dakanji_red.value.toRadixString(16).substring(2)
      )
    );
  }

  return svgString;
}

/// converts the given kana to romaji maching the audio file names of the app
String convertToRomaji(String kana){
  
  String romaji = ""; KanaKit k = const KanaKit();

  switch (k.toHiragana(kana)) {

    case "どぅ":
      romaji = "dwu";
      break;
    case "とぅ":
      romaji = "twu";
      break;
    case "てぃ":  
      romaji = "ti";
      break;
    case "でぃ":  
      romaji = "di";
      break;
    
    case "ふぁ":
      romaji = "fa";
      break;
    case "ふぃ":
      romaji = "fi";
      break;
    case "ふぇ":  
      romaji = "fe";
      break;
    case "ふぉ":  
      romaji = "fo";
      break;

    case "つぁ":
      romaji = "tza";
      break;
    case "つぃ":
      romaji = "tzi";
      break;
    case "つぇ":  
      romaji = "tze";
      break;
    case "つぉ":  
      romaji = "tzo";
      break;

    default:
      romaji = const KanaKit().toRomaji(kana);
  }

  return romaji;
}

