import 'package:flutter/material.dart';

import 'package:kana_kit/kana_kit.dart';

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
  
  String romaji = ""; KanaKit k = KanaKit();

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
      romaji = KanaKit().toRomaji(kana);
  }

  return romaji;
}


/// 1D list of all kana (hira + kata)
List<String> kana = hiragana.expand((e) => e).toList() +
  katakana.expand((e) => e).toList();

/// 2D Hiragana table
List<List<String>> hiragana = [
  ["あ", "い", "う", "え", "お"],
  ["か", "き", "く", "け", "こ"],
  ["さ", "し", "す", "せ", "そ"],
  ["た", "ち", "つ", "て", "と"],
  ["な", "に", "ぬ", "ね", "の"],
  ["は", "ひ", "ふ", "へ", "ほ"],
  ["ま", "み", "む", "め", "も"],
  ["や",  "",  "ゆ",  "", "よ"],
  ["ら", "り", "る", "れ", "ろ"],
  ["わ",   "", "を",  "", "ん"],
];


List<List<String>> hiraDakuten = [
  ["が", "ぎ", "ぐ", "げ", "ご"],
  ["ざ", "じ", "ず", "ぜ", "ぞ"],
  ["だ", "ぢ", "づ", "で", "ど"],
  ["ば", "び", "ぶ", "べ", "ぼ"],
];

List<List<String>> hiraHandakuten = [
  ["ぱ", "ぴ", "ぷ", "ぺ", "ぽ"],
];

List<List<String>> hiraYoonDakuten = [
  ["ぎゃ", "", "ぎゅ", "", "ぎょ"],
  ["じゃ", "", "じゅ", "", "じょ"],
  ["ぢゃ", "", "ぢゅ", "", "ぢょ"],
  ["びゃ", "", "びゅ", "", "びょ"],
];

List<List<String>> hiraYoonHandakuten = [
  ["ぴゃ", "", "ぴゅ", "", "ぴょ"],
];

List<List<String>> hiraDaku = hiraDakuten + hiraYoonDakuten + hiraHandakuten + hiraYoonHandakuten;

List<List<String>> hiraYoon = [
  ["きゃ", "きゅ", "きょ"],
  ["しゃ", "しゅ", "しょ"],
  ["ちゃ", "ちゅ", "ちょ"],
  ["にゃ", "にゅ", "にょ"],
  ["ひゃ", "ひゅ", "ひょ"],
  ["みゃ", "みゅ", "みょ"],
  ["りゃ", "りゅ", "りょ"],
];

List<List<String>> hiraSpecial =[
  ["ふぁ", "ふぃ", "ふぇ", "ふぉ"],
  ["つぁ", "つぃ", "つぇ", "つぉ"],
  ["うぃ", "うぇ", "うぉ", ""],
  ["しぇ", "じぇ", "ちぇ", ""],
  ["てぃ", "でぃ", "",    ""],
  ["とぅ", "どぅ", "",    ""],
];


/// 2D Katakana table
List<List<String>> katakana = hiragana.map((e) => 
  e.map((e) =>
    KanaKit().toKatakana(e)
  ).toList()
).toList();

List<List<String>> kataDakuten = hiraDakuten.map((e) => 
  e.map((e) =>
    KanaKit().toKatakana(e)
  ).toList()
).toList();

List<List<String>> kataYoonDakuten = hiraYoonDakuten.map((e) => 
  e.map((e) =>
    KanaKit().toKatakana(e)
  ).toList()
).toList();

List<List<String>> kataHandakuten = hiraHandakuten.map((e) => 
  e.map((e) =>
    KanaKit().toKatakana(e)
  ).toList()
).toList();

List<List<String>> kataYoonHandakuten = hiraYoonHandakuten.map((e) => 
  e.map((e) =>
    KanaKit().toKatakana(e)
  ).toList()
).toList();

List<List<String>> kataDaku = kataDakuten + kataYoonDakuten + kataHandakuten + kataYoonHandakuten;

List<List<String>> kataYoon = hiraYoon.map((e) => 
  e.map((e) =>
    KanaKit().toKatakana(e)
  ).toList()
).toList();

List<List<String>> kataSpecial = hiraSpecial.map((e) => 
  e.map((e) =>
    KanaKit().toKatakana(e)
  ).toList()
).toList();


//****
Map<String, String> kanaMnemonics = {
  "あ" : "**A**ttention! Says the drill sergent",
  "ア" : "**E**ye of Horus",
  "い" : "**Ea**ster egg",
  "イ" : "**Ea**ves on a house",
  "う" : "**U**kulele",
  "ウ" : "**U**kulele",
  "え" : "**E**dge of the cliff is here",
  "エ" : "**E**mpire State Building",
  "お" : "Oak tree drops a leaf",
  "オ" : "**O**lympic torch",

  "は" : "**Hi**king boot",
  "ハ" : "**Ho**t lava",
  "ひ" : "**Hee**l",
  "ヒ" : "**Hee**l",
  "ふ" : "Mount **Fu**ji",
  "フ" : "**Foo**l's hat",
  "へ" : "**He**adband",
  "ヘ" : "**He**adband",
  "ほ" : "**Ho**tel room",
  "ホ" : "**Ho**ly cross",

  "か" : "**Co**d",
  "カ" : "**Co**d",
  "き" : "**Key**",
  "キ" : "**Key**",
  "く" : "**Cu**ckoo bird",
  "ク" : "**Coo**nskin cap",
  "け" : "**Ke**tchup bottle",
  "ケ" : "The letter '**K**'",
  "こ" : "**Co**mb",
  "コ" : "**Co**mb",

  "ま" : "**Mo**p and bucket",
  "マ" : "**Mo**ckingbird",
  "み" : "**Mea**n number is 21",
  "ミ" : "**Me**dian in th road",
  "む" : "**Moo**se chewing leaves",
  "ム" : "**Moo**n looks down from above",
  "め" : "**Me**dallion",
  "メ" : "**Me**tal knife",
  "も" : "**Mo**tor boat",
  "モ" : "**Mo**tor boat",

  "さ" : "**So**cks",
  "サ" : "**So**ck",
  "し" : "**Shee**p",
  "シ" : "**Shi**eld",
  "す" : "**Sou**p ladle in a pot",
  "ス" : "**Su**it and tie",
  "せ" : "**Se**curity guard",
  "セ" : "**Se**curity guard",
  "そ" : "**Sew** a stitch",
  "ソ" : "**Sew** a button",

  "や" : "**Ya**wl",
  "ヤ" : "**Ya**wl",
  "ゆ" : "**U**tensils for eating",
  "ユ" : "**U**-turn",
  "よ" : "**Yo**ga",
  "ヨ" : "**Yo**ga shorts",

  "た" : "**ta**",
  "タ" : "**Tomcat**",
  "ち" : "**Chee**p, **Chee**p, says the chick",
  "チ" : "**Chee**se wedge",
  "つ" : "**Tsu**nami wave",
  "ツ" : "**Tsu**nami wave. That's a big one!",
  "て" : "**Te**lescope",
  "テ" : "**Te**nt",
  "と" : "**To**aster",
  "ト" : "**To**piary",

  "ら" : "**Ro**d and reel",
  "ラ" : "**Ro**bber",
  "り" : "**Re**ach high",
  "リ" : "**Re**ach high",
  "る" : "**Roo**ster",
  "ル" : "**Rhu**barb",
  "れ" : "**Wre**nch",
  "レ" : "**Re**feree whistle",
  "ろ" : "I **wro**te the number '3'",
  "ロ" : "**Ro**ad sign",

  "な" : "**No**stril",
  "ナ" : "**Kn**ife",
  "に" : "**Knee**",
  "ニ" : "**Knee**",
  "ぬ" : "**Noo**dles and chopsticks",
  "ヌ" : "**New**born baby in a stroller",
  "ね" : "**Ne**xt train arrives at 12:00",
  "ネ" : "**Ne**ck brace",
  "の" : "**No** smoking",
  "ノ" : "**No** smoking",

  "わ" : "**Wa**llaby",
  "ワ" : "**Wa**termelon slice",
  "を" : "**Oh**! Water is too cold",
  "ヲ" : "**O**atmeal in a bowl",
  "ん" : "The letter '**n**'",
  "ン" : "E**n**velope",
};