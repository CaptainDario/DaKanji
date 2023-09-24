import "package:easy_localization/easy_localization.dart";

import 'package:da_kanji_mobile/locales_keys.dart';
import 'package:da_kanji_mobile/data/conjugation/conj.dart';
import 'package:tuple/tuple.dart';



List<Tuple3<String, String, Conj>> verbConjugations = [
  Tuple3(
    LocaleKeys.DictionaryScreen_word_conj_verb_non_past.tr(),
    LocaleKeys.DictionaryScreen_word_conj_verb_non_past_m.tr(),
    Conj.nonPast,
  ),
  Tuple3(
    LocaleKeys.DictionaryScreen_word_conj_verb_past.tr(),
    LocaleKeys.DictionaryScreen_word_conj_verb_past_m.tr(),
    Conj.past
  ),
  Tuple3(
    LocaleKeys.DictionaryScreen_word_conj_verb_te_form.tr(),
    " ",
    Conj.conjunctive
  ),
  Tuple3(
    LocaleKeys.DictionaryScreen_word_conj_verb_volitional.tr(),
    LocaleKeys.DictionaryScreen_word_conj_verb_volitional_m.tr(),
    Conj.volitional
  ),
  Tuple3(
    LocaleKeys.DictionaryScreen_word_conj_verb_imperative.tr(),
    LocaleKeys.DictionaryScreen_word_conj_verb_imperative_m.tr(),
    Conj.imperative
  ),
  Tuple3(
    LocaleKeys.DictionaryScreen_word_conj_verb_provisional.tr(),
    LocaleKeys.DictionaryScreen_word_conj_verb_provisional_m.tr(),
    Conj.provisional
  ),
  Tuple3(
    LocaleKeys.DictionaryScreen_word_conj_verb_conditional.tr(),
    LocaleKeys.DictionaryScreen_word_conj_verb_conditional_m.tr(),
    Conj.conditional
  ),
  Tuple3(
    LocaleKeys.DictionaryScreen_word_conj_verb_potential.tr(),
    LocaleKeys.DictionaryScreen_word_conj_verb_potential_m.tr(),
    Conj.potential
  ),
  Tuple3(
    LocaleKeys.DictionaryScreen_word_conj_verb_passive.tr(),
    LocaleKeys.DictionaryScreen_word_conj_verb_passive_m.tr(),
    Conj.passive
  ),
  Tuple3(
    LocaleKeys.DictionaryScreen_word_conj_verb_causative.tr(),
    LocaleKeys.DictionaryScreen_word_conj_verb_causative_m.tr(),
    Conj.causative
  ),
  Tuple3(
    LocaleKeys.DictionaryScreen_word_conj_verb_causative_passive.tr(),
    LocaleKeys.DictionaryScreen_word_conj_verb_causative_passive_m.tr(),
    Conj.causativePassive
  ),
];

List<Tuple3<String, String, Conj>> adjectiveConjugations = [
  Tuple3(
    LocaleKeys.DictionaryScreen_word_conj_adj_non_past.tr(),
    LocaleKeys.DictionaryScreen_word_conj_adj_non_past_m.tr(),
    Conj.nonPast,
  ),
  Tuple3(
    LocaleKeys.DictionaryScreen_word_conj_adj_past.tr(),
    LocaleKeys.DictionaryScreen_word_conj_adj_past_m.tr(),
    Conj.past,
  ),
  Tuple3(
    LocaleKeys.DictionaryScreen_word_conj_adj_te_form.tr(),
    " ",
    Conj.conjunctive,
  ),
  Tuple3(
    LocaleKeys.DictionaryScreen_word_conj_adj_provisional.tr(),
    LocaleKeys.DictionaryScreen_word_conj_adj_provisional_m.tr(),
    Conj.provisional,
  ),
  Tuple3(
    LocaleKeys.DictionaryScreen_word_conj_adj_conditional.tr(),
    LocaleKeys.DictionaryScreen_word_conj_adj_conditional_m.tr(),
    Conj.conditional,
  ),
  Tuple3(
    LocaleKeys.DictionaryScreen_word_conj_adj_causative.tr(),
    LocaleKeys.DictionaryScreen_word_conj_adj_causative_m.tr(),
    Conj.causative
  ),
];
