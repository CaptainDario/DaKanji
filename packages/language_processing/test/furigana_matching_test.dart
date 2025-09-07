import 'package:language_processing/japanese/furigana_matching.dart';



List<Map<String, String>> testCases = [
    {"kanji": "思い始め", "kana": "おもいはじめ"},
    {"kanji": "東京", "kana": "トーキョー"},
    {"kanji": "食べる", "kana": "たべる"},
    {"kanji": "今日", "kana": "きょう"},
    {"kanji": "友達", "kana": "ともだち"},
  ];

void main() {

  for (var test in testCases) {
    print("Input: ${test['kanji']} → ${test['kana']}");
    print(matchFurigana(test["kanji"]!, test["kana"]!).toString());
    print("----");
  }

}