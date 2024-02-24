import 'package:easy_localization/easy_localization.dart';

import 'package:da_kanji_mobile/locales_keys.dart';



/// The ways of sorting word lists
enum WordListSorting {

  dateDesc,
  dateAsc,
  freqDesc,
  freqAsc,

}

/// The translations for the ways of sorting
Map<WordListSorting, Function> wordListSortingTranslations = {
  
  WordListSorting.dateAsc   : () => LocaleKeys.WordListScreen_word_list_sort_date_asc.tr(),
  WordListSorting.dateDesc  : () => LocaleKeys.WordListScreen_word_list_sort_date_desc.tr(),
  WordListSorting.freqAsc   : () => LocaleKeys.WordListScreen_word_list_sort_freq_asc.tr() ,
  WordListSorting.freqDesc  : () => LocaleKeys.WordListScreen_word_list_sort_freq_desc.tr(),

};