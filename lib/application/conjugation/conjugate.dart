/// The implemented algorithm is based on the [JMDictDB project](https://gitlab.com/yamagoya/jmdictdb/-/tree/master)
/// and was adapted from [jconj](https://github.com/yamagoya/jconj)
/// 
/// The basic approach is as described in the README of jconj and the NOTE in
/// this folder

import 'package:da_kanji_mobile/application/helper/japanese_text_processing.dart';

import 'package:da_kanji_mobile/data/conjugation/conjos.dart';
import 'package:da_kanji_mobile/data/conjugation/conj.dart';
import 'package:da_kanji_mobile/application/conjugation/conjo.dart';
import 'package:da_kanji_mobile/data/conjugation/kwpos.dart';



/// Convenience function to get all conjugations that match the given arguments.
/// The returned list can contain multiple entries if `onum == null`. 
/// 
/// The arguments `Pos`, `Conj`, `bool`, `bool`, `onum` meaning matches the
/// meaning of `Conjo` attributes meanings
List<Conjo> conjosFromArgs(
  Pos pos, Conj conj, bool neg, bool fml,
  {int? onum}  )
{
  return conjos.where((element) => 
    element.pos == pos &&
    element.conj == conj &&
    element.neg == neg &&
    element.fml == fml &&
    (onum == null || element.onum == onum)
  ).toList();
}

/// Conjugates the given `baseVerb` (needs to be in dictionary form) according
/// to the given `conjugation`.
String conjugate(String baseVerb, Conjo conjugation){
  
  String result = baseVerb;

  // 3a. remove stem
  if(conjugation.euphr == null && conjugation.euphk == null){
    result = result.substring(0, baseVerb.length - conjugation.stem);
  }

  // 3b. special case - 'euphk' is not null and the word is kanji
  else if(conjugation.euphk != null && kanjiRegex.hasMatch(baseVerb)){
    result = result.substring(0, baseVerb.length - (conjugation.stem+1));
    result += conjugation.euphk!;
  }

  // 3c. special case - 'euphr' is not null and the word is kana
  else if(conjugation.euphr != null && kanaRegex.hasMatch(baseVerb)){
    result = result.substring(0, baseVerb.length - (conjugation.stem+1));
    result += conjugation.euphr!;
  }

  // 3d. Append `okuri` to the end of the conjugation
  result += conjugation.okuri;

  return result;
}

/// 
void main(){

  String verb = "来る";
  Pos pos = posDescriptionToPosEnum["Kuru verb - special class"]!;
  Conj conj = Conj.Passive;
  bool neg = false;
  bool fml = true;
  
  List<Conjo> conjos = conjosFromArgs(pos, conj, neg, fml);


  String conjugation = conjugate(verb, conjos.first);
  print(conjugation);
}