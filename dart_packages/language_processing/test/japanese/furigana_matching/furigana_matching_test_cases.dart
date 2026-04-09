import 'package:language_processing/language_processing.dart';



List<(
  Map<String, String> input,
  List<TermReadingPair> expectation,
  bool convertToKatakana
)> testCases = [
  (
    {"kanji": "言い方", "kana": "いいかた"},
    [
      TermReadingPair("言", "イ"),
      TermReadingPair("", "イ"),
      TermReadingPair("方", "カタ"),
    ],
    true
  ),
  (
    {"kanji": "思い始め", "kana": "おもいはじめ"},
    [
      TermReadingPair("思", "オモ"),
      TermReadingPair("", "イ"),
      TermReadingPair("始", "ハジ"),
      TermReadingPair("", "メ"),
    ],
    true
  ),
    (
    {"kanji": "言い方", "kana": "いいかた"},
    [
      TermReadingPair("言", "い"),
      TermReadingPair("", "い"),
      TermReadingPair("方", "かた"),
    ],
    false
  ),
  (
    {"kanji": "思い始め", "kana": "おもいはじめ"},
    [
      TermReadingPair("思", "おも"),
      TermReadingPair("", "い"),
      TermReadingPair("始", "はじ"),
      TermReadingPair("", "め"),
    ],
    false
  ),
  (
    {"kanji": "東京", "kana": "トーキョー"},
    [
      TermReadingPair("東京", "トーキョー"),
    ],
    true
  ),
  (
    {"kanji": "食べる", "kana": "たべる"},
    [
      TermReadingPair("食", "タ"),
      TermReadingPair("", "ベル"),
    ],
    true
  ),
  (
    {"kanji": "今日", "kana": "きょう"},
    [
      TermReadingPair("今日", "キョウ"),
    ],
    true
  ),
  (
    {"kanji": "友達", "kana": "ともだち"},
    [
      TermReadingPair("友達", "トモダチ"),
    ],
    true
  ),
  (
    {"kanji": "ゴミ箱", "kana": "ごみばこ"},
    [
      TermReadingPair("", "ゴミ"),
      TermReadingPair("箱", "バコ"),
    ],
    true
  ),
  (
    {"kanji": "食べる辣油", "kana": "たべるラーゆ"},
    [
      TermReadingPair("食", "タ"),
      TermReadingPair("", "ベル"),
      TermReadingPair("辣油", "ラーユ"),
    ],
    true
  ),
  (
    {"kanji": "食べる辣油", "kana": "たべるラーゆ"},
    [
      TermReadingPair("食", "た"),
      TermReadingPair("", "べる"),
      TermReadingPair("辣油", "ラーゆ"),
    ],
    false 
  ),
  // if the algorithm can't perfectly match, it should not break the output
  (
    {"kanji": "食べる", "kana": "たべるべる"},
    [
      TermReadingPair("食べる", "たべるべる"),
    ],
    false
  ),
];
