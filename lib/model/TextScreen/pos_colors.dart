import 'package:flutter/material.dart';



/// Color for showing suffixs
final Color suffixColor = Color(0xffff0000);
/// Color for showing na-adjectives
final Color naAdjectiveColor = Color(0xff7f0000);
/// Color for showing nouns
final Color nounColor = Color(0xff191970);
/// Color for prefixes
final Color prefixColor = Color(0xff006400);
/// Color for showing verbs
final Color verbColor = Color(0xffff8c00);
/// Color for showing i-adjectives
final Color iAdjectiveColor = Color(0xffffff00);
/// Color for showing adverbs
final Color adverbColor = Color(0xff0000cd);
/// Color for showing adnominals
final Color adnominalColor = Color(0xffdeb887);
/// Color for showing conjunctions
final Color conjunctionColor = Color(0xff00ff00);
/// Color for showing particles
final Color particleColor = Color(0xff00bfff);
/// Color for showing auxilary verbs
final Color auxVerbColor = Color(0xffff00ff);
/// Color for showing exclamations
final Color exclamationColor = Color(0xffdda0dd);
/// Color for showing filler
final Color fillerColor = Color(0xffff1493);
/// Color for showing interjections
final Color interjectionColor = Color(0xff98fb98);




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
    print("$pos is an unknown POS");
  }
  return c;
}