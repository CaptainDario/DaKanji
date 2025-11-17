// Package imports:
import 'package:kana_kit/kana_kit.dart';

/// 1D list of all kana (`hiragana` + `katakana`)
List<String> kana = hiragana.expand((e) => e).toList() +
  katakana.expand((e) => e).toList();

/// 2D list (table) of all Hiragana characters ex.: あ, い, う, ...
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

/// 2D list (table) of all Hiragana dakuten characters, ex.: が, ざ, ...
List<List<String>> hiraDakuten = [
  ["が", "ぎ", "ぐ", "げ", "ご"],
  ["ざ", "じ", "ず", "ぜ", "ぞ"],
  ["だ", "ぢ", "づ", "で", "ど"],
  ["ば", "び", "ぶ", "べ", "ぼ"],
];

/// 2D list (table) of all Hiragana handakuten characters, ex.: ぱ, ぴ, ...
List<List<String>> hiraHandakuten = [
  ["ぱ", "ぴ", "ぷ", "ぺ", "ぽ"],
];

/// 2D list (table) of all Hiragana yoon characters, ex.: ぎゃ, じゃ, ...
List<List<String>> hiraYoonDakuten = [
  ["ぎゃ", "", "ぎゅ", "", "ぎょ"],
  ["じゃ", "", "じゅ", "", "じょ"],
  ["ぢゃ", "", "ぢゅ", "", "ぢょ"],
  ["びゃ", "", "びゅ", "", "びょ"],
];

/// 2D list (table) of all Hiragana yoon handakuten characters, ex.: ぴゃ, ぴゅ, ...
List<List<String>> hiraYoonHandakuten = [
  ["ぴゃ", "", "ぴゅ", "", "ぴょ"],
];

/// 2D list (table) of all Hiragana dakuten characters, this combines: `hiraDakuten`,
/// `hiraYoonDakuten`, `hiraHandakuten`, `hiraYoonHandakuten`
List<List<String>> hiraDaku = hiraDakuten + hiraYoonDakuten + hiraHandakuten + hiraYoonHandakuten;

/// 2D list (table) of all Hiragana yoon characters, ex.: きゃ, きゅ
List<List<String>> hiraYoon = [
  ["きゃ", "きゅ", "きょ"],
  ["しゃ", "しゅ", "しょ"],
  ["ちゃ", "ちゅ", "ちょ"],
  ["にゃ", "にゅ", "にょ"],
  ["ひゃ", "ひゅ", "ひょ"],
  ["みゃ", "みゅ", "みょ"],
  ["りゃ", "りゅ", "りょ"],
];

/// A list of special (uncommon) hiragana characters ex.: ふぁ, つぁ, ...
List<List<String>> hiraSpecial =[
  ["ふぁ", "ふぃ", "ふぇ", "ふぉ"],
  ["つぁ", "つぃ", "つぇ", "つぉ"],
  ["うぃ", "うぇ", "うぉ", ""],
  ["しぇ", "じぇ", "ちぇ", ""],
  ["てぃ", "でぃ", "",    ""],
  ["とぅ", "どぅ", "",    ""],
];

/// A list of a "small" hiragana characters ex.: ぁ, ぃ, ぅ
List<String> hiraSmall =
  ["ぁ", "ぃ", "ぅ", "ぇ", "ぉ", "っ", "ゃ", "ゅ", "ょ", "ゎ", "ゕ", "ゖ"];



/// 2D list (table) of all Katakana characters ex.: ア, イ, ウ, ...
List<List<String>> katakana = hiragana.map((e) => 
  e.map((e) =>
    const KanaKit().toKatakana(e)
  ).toList()
).toList();

/// 2D list (table) of all Katakana dakuten characters, ex.: ガ, ザ, ...
List<List<String>> kataDakuten = hiraDakuten.map((e) => 
  e.map((e) =>
    const KanaKit().toKatakana(e)
  ).toList()
).toList();

/// 2D list (table) of all Katakana yoon handakuten characters, ex.: パ, ピ, ...
List<List<String>> kataHandakuten = hiraHandakuten.map((e) => 
  e.map((e) =>
    const KanaKit().toKatakana(e)
  ).toList()
).toList();

/// 2D list (table) of all Katakana yoon characters, ex.: ギャ, ジャ, ...
List<List<String>> kataYoonDakuten = hiraYoonDakuten.map((e) => 
  e.map((e) =>
    const KanaKit().toKatakana(e)
  ).toList()
).toList();

/// 2D list (table) of all Hiragana yoon handakuten characters, ex.: ピャ, ピュ, ...
List<List<String>> kataYoonHandakuten = hiraYoonHandakuten.map((e) => 
  e.map((e) =>
    const KanaKit().toKatakana(e)
  ).toList()
).toList();

/// 2D list (table) of all Katakana dakuten characters, this combines: `kataDaku`,
/// `kataYoonDakuten`, `kataHandakuten`, `kataYoonHandakuten`
List<List<String>> kataDaku = kataDakuten + kataYoonDakuten + kataHandakuten + kataYoonHandakuten;

/// 2D list (table) of all Katakana yoon characters, ex.: キャ, キュ
List<List<String>> kataYoon = hiraYoon.map((e) => 
  e.map((e) =>
    const KanaKit().toKatakana(e)
  ).toList()
).toList();

/// A list of special (uncommon) Katakana characters ex.: ファ, ツァ, ...
List<List<String>> kataSpecial = hiraSpecial.map((e) => 
  e.map((e) =>
    const KanaKit().toKatakana(e)
  ).toList()
).toList();

/// A list of a "small" Katakana characters ex.: ァ, ィ, ゥ
List<String> kataSmall = hiraSmall.map((e) => 
  const KanaKit().toKatakana(e)
).toList();
