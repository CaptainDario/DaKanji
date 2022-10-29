import 'package:flutter/material.dart';



/// Color for showing pronouns
final Color pronounColor = Colors.red;
/// Color for showing adverbs
final Color adverbColor = Colors.blue;
/// Color for showing auxilary verbs
final Color auxVerbColor = Colors.yellow;
/// Color for showing particles
final Color particleColor = Colors.green;
/// Color for showing verbs
final Color verbColor = Colors.orange;
/// Color for showing nouns
final Color nounColor = Colors.purple;
/// Color for showing i-adjectives
final Color iAdjectiveColor = Colors.brown;
/// Color for showing na-adjectives
final Color naAdjectiveColor = Colors.pinkAccent.shade200;
/// Color for showing interjections
final Color interjectionColor = Colors.teal;
/// Color for showing suffixs
final Color suffixColor = Colors.lime;
/// Color for showing conjunctions
final Color conjunctionColor = Colors.cyan;


final Map<String, Color> posToColor = {
  '代名詞' : pronounColor,

  '副詞' : adverbColor,

  '助動詞' : auxVerbColor,

  '助詞-係助詞' : particleColor,
  '助詞-副助詞' : particleColor,
  '助詞-接続助詞' : particleColor,
  '助詞-格助詞' : particleColor,
  '助詞-準体助詞' : particleColor,
  '助詞-終助詞' : particleColor,

  '動詞-一般' : verbColor,
  '動詞-非自立可能' : verbColor,

  '名詞-助動詞語幹' : nounColor,
  '名詞-固有名詞-一般' : nounColor,
  '名詞-固有名詞-人名-一般' : nounColor,
  '名詞-固有名詞-人名-名' : nounColor,
  '名詞-固有名詞-人名-姓' : nounColor,
  '名詞-固有名詞-地名-一般' : nounColor,
  '名詞-固有名詞-地名-国' : nounColor,
  '名詞-数詞' : nounColor,
  '名詞-普通名詞-サ変可能' : nounColor,
  '名詞-普通名詞-サ変形状詞可能' : nounColor,
  '名詞-普通名詞-一般' : nounColor,
  '名詞-普通名詞-副詞可能' : nounColor,
  '名詞-普通名詞-助数詞可能' : nounColor,
  '名詞-普通名詞-形状詞可能' : nounColor,

  '形容詞-一般' : iAdjectiveColor,
  '形容詞-非自立可能' : iAdjectiveColor,

  '形状詞-タリ' : naAdjectiveColor,
  '形状詞-一般' : naAdjectiveColor,
  '形状詞-助動詞語幹' : naAdjectiveColor,

  '感動詞-フィラー' : interjectionColor,
  '感動詞-一般' : interjectionColor,

  '接尾辞-動詞的' : suffixColor,
  '接尾辞-名詞的-サ変可能' : suffixColor,
  '接尾辞-名詞的-一般' : suffixColor,
  '接尾辞-名詞的-副詞可能' : suffixColor,
  '接尾辞-名詞的-助数詞' : suffixColor,
  '接尾辞-形容詞的' : suffixColor,
  '接尾辞-形状詞的' : suffixColor,

  '接続詞' : conjunctionColor,
  '接頭辞' : conjunctionColor,
};