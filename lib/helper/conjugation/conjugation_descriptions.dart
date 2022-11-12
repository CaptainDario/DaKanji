import 'package:easy_localization/easy_localization.dart';

import 'package:da_kanji_mobile/helper/conjugation/conj.dart';
import 'package:da_kanji_mobile/locales_keys.dart';



List<String> verbConjugationTitles = [
  "Present, (Future)",
  "Past",
  "て-form, Continuative",
  //"",
  "Progressive",
  "Volitional",
  "Imperative",
  "Request",
  "Provisional",
  "Conditional",
  "Potential",
  "Passive, Respectful",
  "Causative",
  "Causative passive"
];

List<String> verbConjugationMeanings = [
  "Will [not] do",
  "Did [not] do",
  "",
  //"[not] doing",
  "I will [not] do, I do [not] intend to do",
  "Do [not] do!",
  "Please do [not do]",
  "If X does [not do], if X is [not]",
  "If X were [not] to do, when X does [not] do",
  "[Not] be able to do, can [not] do",
  "Is [not] done (by ...), will [not] be done (by ...)",
  "Does [not] / will [not] make, let (someone) do",
  "Is [not] made / will [not] be made to do (by someone)"
];

List<Conj> verbConjugationTypes = [
  Conj.Non_past,
  Conj.Past,
  Conj.Conjunctive,
  //Conj.Continuative,
  Conj.Volitional,
  Conj.Imperative,
  Conj.Conjunctive,
  Conj.Provisional,
  Conj.Conditional,
  Conj.Potential,
  Conj.Passive,
  Conj.Causative,
  Conj.Causative_Passive
];

List<String> adjectiveConjugationTitles = [
  "Present, (Future)",
  "Past",
  "て-form, Continuative",
  "Provisional",
  "Conditional",
  "Causative",
];

List<String> adjectiveConjugationMeanings = [
  "Is [not]",
  "was [not]",
  "",
  "If it is [not]",
  "When/if it is [not]",
  "Make somebody [not]"
];

List<Conj> adjectiveConjugationTypes = [
  Conj.Non_past,
  Conj.Past,
  Conj.Conjunctive,
  Conj.Provisional,
  Conj.Conditional,
  Conj.Causative
];