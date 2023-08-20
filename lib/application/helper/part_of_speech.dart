import 'package:flutter/material.dart';

import 'package:easy_localization/easy_localization.dart';

import 'package:da_kanji_mobile/locales_keys.dart';



/// Color for showing suffixs
const Color suffixColor = Color(0xffff0000);
/// Color for showing na-adjectives
const Color naAdjectiveColor = Color(0xff7f0000);
/// Color for showing nouns
const Color nounColor = Color(0xff191970);
/// Color for prefixes
const Color prefixColor = Color(0xff006400);
/// Color for showing verbs
const Color verbColor = Color(0xffff8c00);
/// Color for showing i-adjectives
const Color iAdjectiveColor = Color(0xffffff00);
/// Color for showing adverbs
const Color adverbColor = Color(0xff0000cd);
/// Color for showing adnominals
const Color adnominalColor = Color(0xffdeb887);
/// Color for showing conjunctions
const Color conjunctionColor = Color(0xff00ff00);
/// Color for showing particles
const Color particleColor = Color(0xff00bfff);
/// Color for showing auxilary verbs
const Color auxVerbColor = Color(0xffff00ff);
/// Color for showing exclamations
const Color exclamationColor = Color(0xffdda0dd);
/// Color for showing filler
const Color fillerColor = Color(0xffff1493);
/// Color for showing interjections
const Color interjectionColor = Color(0xff98fb98);



/// Converts a ipadic style part of speech string to a unique color
Color? posToColor(String pos){
  Color? c;

  // suffix
  if(pos.contains("-接尾")) {
    c = suffixColor;
  } else if(pos.startsWith("名詞-形容動詞語幹")) {
    c = naAdjectiveColor;
  } else if(pos.startsWith("名詞")) {
    c = nounColor;
  } else if(pos.startsWith("接頭詞")) {
    c = prefixColor;
  } else if(pos.startsWith("動詞")) {
    c = verbColor;
  } else if(pos.startsWith("形容詞")) {
    c = iAdjectiveColor;
  } else if(pos.startsWith("副詞")) {
    c = adverbColor;
  } else if(pos.startsWith("連体詞")) {
    c = adnominalColor;
  } else if(pos.startsWith("接続詞")) {
    c = conjunctionColor;
  } else if(pos.startsWith("助詞")) {
    c = particleColor;
  } else if(pos.startsWith("助動詞")) {
    c = auxVerbColor;
  } else if(pos.startsWith("感動詞")) {
    c = exclamationColor;
  } else if(pos.startsWith("フィラ")) {
    c = fillerColor;
  } else if(pos.startsWith("その他")) {
    c = interjectionColor;
  } else{
    //print("$pos is an unknown POS");
  }
  return c;
}

/// Converts a ipadic style part of speech string to a general part of speech
/// in different localizations
String? posToTranslation(String pos){
  String? localizedPos;

  // suffix
  if(pos.contains("-接尾")) {
    localizedPos = LocaleKeys.TextScreen_pos_suffix.tr();
  } else if(pos.startsWith("名詞-形容動詞語幹")) {
    localizedPos = LocaleKeys.TextScreen_pos_na_adj.tr();
  } else if(pos.startsWith("名詞")) {
    localizedPos = LocaleKeys.TextScreen_pos_noun.tr();
  } else if(pos.startsWith("接頭詞")) {
    localizedPos = LocaleKeys.TextScreen_pos_prefix.tr();
  } else if(pos.startsWith("動詞")) {
    localizedPos = LocaleKeys.TextScreen_pos_verb.tr();
  } else if(pos.startsWith("形容詞")) {
    localizedPos = LocaleKeys.TextScreen_pos_i_adjective.tr();
  } else if(pos.startsWith("副詞")) {
    localizedPos = LocaleKeys.TextScreen_pos_adverb.tr();
  } else if(pos.startsWith("連体詞")) {
    localizedPos = LocaleKeys.TextScreen_pos_adnominal.tr();
  } else if(pos.startsWith("接続詞")) {
    localizedPos = LocaleKeys.TextScreen_pos_conjunction.tr();
  } else if(pos.startsWith("助詞")) {
    localizedPos = LocaleKeys.TextScreen_pos_particle.tr();
  } else if(pos.startsWith("助動詞")) {
    localizedPos = LocaleKeys.TextScreen_pos_auxillary_verb.tr();
  } else if(pos.startsWith("感動詞")) {
    localizedPos = LocaleKeys.TextScreen_pos_exclamation.tr();
  } else if(pos.startsWith("フィラ")) {
    localizedPos = LocaleKeys.TextScreen_pos_filler.tr();
  } else if(pos.startsWith("その他")) {
    localizedPos = LocaleKeys.TextScreen_pos_interjection.tr();
  } else{
    print("$pos is an unknown POS");
  }
  return localizedPos;
}