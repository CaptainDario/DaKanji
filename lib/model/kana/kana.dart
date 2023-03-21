import 'package:kana_kit/kana_kit.dart';



/// Hiragana
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

List<List<String>> katakana = hiragana.map((e) => 
  e.map((e) =>
    KanaKit().toKatakana(e)
  ).toList()
).toList();