import 'package:flutter/material.dart';
import 'package:da_kanji_mobile/entities/grammar/pos.dart';
import 'package:da_kanji_mobile/locales_keys.dart';
import 'package:easy_localization/easy_localization.dart';

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
    //debugPrint("$pos is an unknown POS");
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
    debugPrint("$pos is an unknown POS");
  }
  return localizedPos;
}
