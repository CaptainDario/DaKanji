import 'package:flutter/material.dart';

import 'package:easy_localization/easy_localization.dart';

import 'package:da_kanji_mobile/locales_keys.dart';



/// Color for showing suffixs
final Color suffixColor = const Color(0xffff0000);
/// Color for showing na-adjectives
final Color naAdjectiveColor = const Color(0xff7f0000);
/// Color for showing nouns
final Color nounColor = const Color(0xff191970);
/// Color for prefixes
final Color prefixColor = const Color(0xff006400);
/// Color for showing verbs
final Color verbColor = const Color(0xffff8c00);
/// Color for showing i-adjectives
final Color iAdjectiveColor = const Color(0xffffff00);
/// Color for showing adverbs
final Color adverbColor = const Color(0xff0000cd);
/// Color for showing adnominals
final Color adnominalColor = const Color(0xffdeb887);
/// Color for showing conjunctions
final Color conjunctionColor = const Color(0xff00ff00);
/// Color for showing particles
final Color particleColor = const Color(0xff00bfff);
/// Color for showing auxilary verbs
final Color auxVerbColor = const Color(0xffff00ff);
/// Color for showing exclamations
final Color exclamationColor = const Color(0xffdda0dd);
/// Color for showing filler
final Color fillerColor = const Color(0xffff1493);
/// Color for showing interjections
final Color interjectionColor = const Color(0xff98fb98);



/// Converts a ipadic style part of speech string to a unique color
Color? posToColor(String pos){
  Color? c;

  // suffix
  if(pos.contains("-接尾"))
    c = suffixColor; 
  // na adj
  else if(pos.startsWith("名詞-形容動詞語幹")) 
    c = naAdjectiveColor;
  // noun
  else if(pos.startsWith("名詞"))      
    c = nounColor;
  // prefix
  else if(pos.startsWith("接頭詞")) 
    c = prefixColor;
  // verb
  else if(pos.startsWith("動詞")) 
    c = verbColor;
  // i adj
  else if(pos.startsWith("形容詞")) 
    c = iAdjectiveColor;
  // adverbs
  else if(pos.startsWith("副詞")) 
    c = adverbColor;
  // adnominals
  else if(pos.startsWith("連体詞")) 
    c = adnominalColor;
  // Conjunctions
  else if(pos.startsWith("接続詞")) 
    c = conjunctionColor;
  // Particles
  else if(pos.startsWith("助詞")) 
    c = particleColor;
  // aux verb
  else if(pos.startsWith("助動詞")) 
    c = auxVerbColor;
  // Exclamations
  else if(pos.startsWith("感動詞")) 
    c = exclamationColor;
  // Filler
  else if(pos.startsWith("フィラ")) 
    c = fillerColor;
  // Other Parts of Speech (interjection)
  else if(pos.startsWith("その他"))
    c = interjectionColor;
  else{
    //print("$pos is an unknown POS");
  }
  return c;
}

/// Converts a ipadic style part of speech string to a general part of speech
/// in different localizations
String? posToTranslation(String pos){
  String? localizedPos;

  // suffix
  if(pos.contains("-接尾"))
    localizedPos = LocaleKeys.TextScreen_pos_suffix.tr(); 
  // na adj
  else if(pos.startsWith("名詞-形容動詞語幹")) 
    localizedPos = LocaleKeys.TextScreen_pos_na_adj.tr();
  // noun
  else if(pos.startsWith("名詞"))      
    localizedPos = LocaleKeys.TextScreen_pos_noun.tr();
  // prefix
  else if(pos.startsWith("接頭詞")) 
    localizedPos = LocaleKeys.TextScreen_pos_prefix.tr();
  // verb
  else if(pos.startsWith("動詞")) 
    localizedPos = LocaleKeys.TextScreen_pos_verb.tr();
  // i adj
  else if(pos.startsWith("形容詞")) 
    localizedPos = LocaleKeys.TextScreen_pos_i_adjective.tr();
  // adverbs
  else if(pos.startsWith("副詞")) 
    localizedPos = LocaleKeys.TextScreen_pos_adverb.tr();
  // adnominals
  else if(pos.startsWith("連体詞")) 
    localizedPos = LocaleKeys.TextScreen_pos_adnominal.tr();
  // Conjunctions
  else if(pos.startsWith("接続詞")) 
    localizedPos = LocaleKeys.TextScreen_pos_conjunction.tr();
  // Particles
  else if(pos.startsWith("助詞")) 
    localizedPos = LocaleKeys.TextScreen_pos_particle.tr();
  // aux verb
  else if(pos.startsWith("助動詞")) 
    localizedPos = LocaleKeys.TextScreen_pos_auxillary_verb.tr();
  // Exclamations
  else if(pos.startsWith("感動詞")) 
    localizedPos = LocaleKeys.TextScreen_pos_exclamation.tr();
  // Filler
  else if(pos.startsWith("フィラ")) 
    localizedPos = LocaleKeys.TextScreen_pos_filler.tr();
  // Other Parts of Speech (interjection)
  else if(pos.startsWith("その他"))
    localizedPos = LocaleKeys.TextScreen_pos_interjection.tr();
  else{
    print("$pos is an unknown POS");
  }
  return localizedPos;
}