import 'package:language_processing/japanese/furigana_matching.dart';



List<(Map<String, String>, List<FuriganaPair>)> testCases = [
  (
    {"kanji": "思い始め", "kana": "おもいはじめ"},
    [
      FuriganaPair("思", "オモ"),
      FuriganaPair("", "イ"),
      FuriganaPair("始", "ハジ"),
      FuriganaPair("", "メ"),
    ]
  ),
  (
    {"kanji": "東京", "kana": "トーキョー"},
    [
      FuriganaPair("東京", "トーキョー"),
    ]
  ),
  (
    {"kanji": "食べる", "kana": "たべる"},
    [
      FuriganaPair("食", "タ"),
      FuriganaPair("", "ベル"),
    ]
  ),
  (
    {"kanji": "今日", "kana": "きょう"},
    [
      FuriganaPair("今日", "キョウ"),
    ]
  ),
  (
    {"kanji": "友達", "kana": "ともだち"},
    [
      FuriganaPair("友達", "トモダチ"),
    ]
  ),
];
