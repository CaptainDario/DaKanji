import 'package:flutter/material.dart';

// Project imports:
import 'package:da_kanji_mobile/entities/grammar/pos.dart';

/// verb
String verb = "動詞";
/// i adjective
String iAdjective = "形容詞";
/// na adjective
String naAdjective = "形状詞";
/// noun
String noun = "名詞";
/// pronoun
String pronoun = "代名詞";
/// PoS for particles
String particle = "助詞";
/// White space
String whiteSpace = "空白";

List<String> mecabPosDeconjugate = [
  verb, iAdjective, naAdjective,
  //noun
];

/// Inflection dependent word
String inflectionDependentWord = "助動詞";
/// Conjunction particle
String conjunctionParticle = "接続助詞";
/// Words that cannot standalone
String nonIndependent = "非自立可能";
/// Suffix
String suffix = "接尾辞";
/// The verb / adjective that starts this word
String startPos = "一般";


/// Color for showing na-adjectives
const Color naAdjectiveColor = Color(0xff7f0000);
/// Color for showing nouns
const Color nounColor = Color(0xffff0000);
/// Color for showing verbs
const Color verbColor = Color(0xffff8c00);
/// Color for showing i-adjectives
const Color iAdjectiveColor = Color(0xffffff00);
/// Color for showing adverbs
const Color adverbColor = Color(0xff0000cd);
/// Color for showing particles
const Color particleColor = Color(0xff00bfff);


/// A list of mecab pos combinations that indicate a word start
List<List<String>> mecabPosWordStart = [
  // verb
  [verb],
  // i-adj
  [iAdjective, startPos],
  [iAdjective, nonIndependent],
  // na-adj
  [naAdjective, startPos],
  [naAdjective, nonIndependent],
  // nouns
  [noun]
];

List<List<String>> wordContinuationPOS = [
  // general
  [inflectionDependentWord],
  [particle, conjunctionParticle],
  [suffix],
  // verb
  [verb, nonIndependent],
  // i-adj
  [iAdjective, nonIndependent],
  // na-adj
  [naAdjective, nonIndependent],
];

/// Compares `a` to `b`, if the strings are the same.
/// If `b` is shorter than `a`, the comparison only checks
/// the first elements
bool compareMecabOut(List<String> a, List<String?> b,){

  bool isSame = true;

  if(a[0] != b[0]){
    isSame = false;
  }
  else if(b.length > 1 && a[1] != b[1]){
    isSame = false;
  }
  else if(b.length > 2 && a[2] != b[2]){
    isSame = false;
  }
  else if(b.length > 3 && a[3] != b[3]){
    isSame = false;
  }

  return isSame;

}

/// Compares one mecab output to a list of mecab outputs.
/// If any of them are equal returns true
bool compareMecabOuts(List<String> a, List<List<String>> mecabOuts){

  for (var mecabOut in mecabOuts) {
    
    if(compareMecabOut(a, mecabOut)) return true;

  }

  return false;
}

/// Converts a ipadic style part of speech string to a unique color
Color? posToColor(String pos){
  Color? c;

  if(pos.startsWith(naAdjective)) {
    c = naAdjectiveColor;
  } else if([noun, pronoun].any((e) => pos.startsWith(e))) {
    c = nounColor;
  } else if(pos.startsWith(verb)) {
    c = verbColor;
  } else if(pos.startsWith(iAdjective)) {
    c = iAdjectiveColor;
  } else if(pos.startsWith(particle)) {
    c = particleColor;
  } else{
    //debugPrint("$pos is an unknown POS");
  }
  return c;
}
