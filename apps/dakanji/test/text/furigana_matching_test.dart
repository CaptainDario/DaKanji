import 'package:da_kanji_mobile/application/japanese_text_processing/furigana_matching.dart';
import 'package:flutter/rendering.dart';



List<Map<String, String>> testCases = [
    {"kanji": "思い始め", "kana": "おもいはじめ"},
    {"kanji": "東京", "kana": "トーキョー"},
    {"kanji": "食べる", "kana": "たべる"},
    {"kanji": "今日", "kana": "きょう"},
    {"kanji": "友達", "kana": "ともだち"},
  ];

void main() {

  for (var test in testCases) {
    debugPrint("Input: ${test['kanji']} → ${test['kana']}");
    debugPrint(matchFurigana(test["kanji"]!, test["kana"]!).toString());
    debugPrint("----");
  }

}