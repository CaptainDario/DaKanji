// Flutter imports:
import 'package:da_kanji_mobile/application/japanese_text_processing/mecab_data.dart';
import 'package:flutter/material.dart';

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
