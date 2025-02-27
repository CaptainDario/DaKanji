// Flutter imports:
import 'package:flutter/material.dart';



/// verb
String verb = "動詞";
/// adverb
String adverb = "副詞";
/// i adjective
String iAdjective = "形容詞";
/// na adjective
String naAdjective = "形状詞";
/// this word can be a na-adjective under certain circumstances 
String naAdjectivePossibility = "形状詞可能";
/// noun
String noun = "名詞";
/// pronoun
String pronoun = "代名詞";
/// PoS for particles
String particle = "助詞";
/// White space
String whiteSpace = "空白";


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
const Color naAdjectiveColor = Color.fromARGB(255, 255, 113, 205);
/// Color for showing nouns
const Color nounColor = Color(0xffff0000);
/// Color for showing verbs
const Color verbColor = Color(0xffff8c00);
/// Color for showing i-adjectives
const Color iAdjectiveColor = Color(0xffffff00);
/// Color for showing adverbs
const Color adverbColor = Color.fromARGB(255, 24, 245, 13);
/// Color for showing particles
const Color particleColor = Color.fromARGB(255, 0, 216, 216);


List<String> mecabPosDeconjugate = [
  verb, iAdjective, naAdjective,
  //noun
];

/// A list of mecab pos combinations that indicate a word start
List<List<String>> mecabPosWordStart = [
  // verb
  [verb],
  [particle, conjunctionParticle],
  // i-adj
  [iAdjective, startPos],
  [iAdjective, nonIndependent],
  // na-adj
  [naAdjective, startPos],
  [naAdjective, nonIndependent],
  // nouns
  [noun]
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
Color? posToColor(List<String> pos){
  Color? c;

  if(pos.isEmpty) return null;

  if(pos[0].contains(naAdjective)) {
    c = naAdjectiveColor;
  } else if([noun, pronoun].any((e) => pos[0].startsWith(e))) {
    c = nounColor;
  } else if(pos[0].startsWith(verb)) {
    c = verbColor;
  } else if(pos[0].startsWith(adverb)) {
    c = adverbColor;
  } else if(pos[0].startsWith(iAdjective)) {
    c = iAdjectiveColor;
  } else if(pos[0].startsWith(particle)) {
    c = particleColor;
  } else{
    //debugPrint("$pos is an unknown POS");
  }
  return c;
}
