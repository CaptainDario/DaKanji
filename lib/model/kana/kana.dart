import 'package:kana_kit/kana_kit.dart';



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
  ["きゃ", "きゅ", "きょ", ""],
  ["しゃ", "しゅ", "しょ", ""],
  ["ちゃ", "ちゅ", "ちょ", ""],
  ["にゃ", "にゅ", "にょ", ""],
  ["ひゃ", "ひゅ", "ひょ", ""],
  ["みゃ", "みゅ", "みょ", ""],
  ["りゃ", "りゅ", "りょ", ""],

  ["うぃ", "うぇ", "うぉ", ""],
  ["ふぁ", "ふぃ", "ふぇ", "ふぉ"],
  ["つぁ", "つぃ", "つぇ", "つぉ"],
  ["てぃ", "とぅ", "しぇ", "ちぇ"],
];

Map<String, String> kanaMnemonics = {
  "あ" : "Attention! Says the drill sergent.",
  "い" : "Easter egg.",
  "う" : "Ukulele",
  "え" : "Edge of the cliff is here.",
  "お" : "Oak tree drops a leaf"
};



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

