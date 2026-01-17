import 'package:language_processing/japanese/furigana_matching.dart';



List<(
  Map<String, String> input,
  List<FuriganaPair> expectation,
  bool convertToKatakana
)> testCases = [
  (
    {"kanji": "言い方", "kana": "いいかた"},
    [
      FuriganaPair("言", "イ"),
      FuriganaPair("", "イ"),
      FuriganaPair("方", "カタ"),
    ],
    true
  ),
  (
    {"kanji": "思い始め", "kana": "おもいはじめ"},
    [
      FuriganaPair("思", "オモ"),
      FuriganaPair("", "イ"),
      FuriganaPair("始", "ハジ"),
      FuriganaPair("", "メ"),
    ],
    true
  ),
    (
    {"kanji": "言い方", "kana": "いいかた"},
    [
      FuriganaPair("言", "い"),
      FuriganaPair("", "い"),
      FuriganaPair("方", "かた"),
    ],
    false
  ),
  (
    {"kanji": "思い始め", "kana": "おもいはじめ"},
    [
      FuriganaPair("思", "おも"),
      FuriganaPair("", "い"),
      FuriganaPair("始", "はじ"),
      FuriganaPair("", "め"),
    ],
    false
  ),
  (
    {"kanji": "東京", "kana": "トーキョー"},
    [
      FuriganaPair("東京", "トーキョー"),
    ],
    true
  ),
  (
    {"kanji": "食べる", "kana": "たべる"},
    [
      FuriganaPair("食", "タ"),
      FuriganaPair("", "ベル"),
    ],
    true
  ),
  (
    {"kanji": "今日", "kana": "きょう"},
    [
      FuriganaPair("今日", "キョウ"),
    ],
    true
  ),
  (
    {"kanji": "友達", "kana": "ともだち"},
    [
      FuriganaPair("友達", "トモダチ"),
    ],
    true
  ),
  (
    {"kanji": "ゴミ箱", "kana": "ごみばこ"},
    [
      FuriganaPair("", "ゴミ"),
      FuriganaPair("箱", "バコ"),
    ],
    true
  ),
];
