import 'package:easy_localization/easy_localization.dart';

import 'package:da_kanji_mobile/locales_keys.dart';
import 'package:da_kanji_mobile/data/show_cases/tutorial.dart';
import 'package:flutter/material.dart';



class DictionaryScreenTutorial extends Tutorial {

  // all tutorial steps that belong to the DictionaryScreen
  late FocusNode searchInputStep;
  late FocusNode searchInputWildcardsStep;
  late FocusNode searchInputClearStep;
  late FocusNode searchInputDrawStep;
  late FocusNode searchFilterStep;
  late FocusNode searchRadicalStep;
  late FocusNode wordTabStep;
  late FocusNode kanjiTabStep;
  late FocusNode examplesTabStep;

  DictionaryScreenTutorial() {
    titles = [
      LocaleKeys.DictionaryScreen_tutorial_begin_title.tr(),
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      ""
    ];
    bodies = [
      LocaleKeys.DictionaryScreen_tutorial_begin_text.tr(),
      LocaleKeys.DictionaryScreen_tutorial_search_input_text.tr(),
      LocaleKeys.DictionaryScreen_tutorial_search_input_wildcards_text.tr(),
      LocaleKeys.DictionaryScreen_tutorial_search_input_clear_text.tr(),
      LocaleKeys.DictionaryScreen_tutorial_search_input_draw_text.tr(),
      LocaleKeys.DictionaryScreen_tutorial_search_filter_text.tr(),
      LocaleKeys.DictionaryScreen_tutorial_search_radical_text.tr(),
      LocaleKeys.DictionaryScreen_tutorial_word_tab.tr(),
      LocaleKeys.DictionaryScreen_tutorial_kanji_tab.tr(),
      LocaleKeys.DictionaryScreen_tutorial_examples_tab.tr(),
    ];

    initTutorial();

    searchInputStep          = focusNodes![1];
    searchInputWildcardsStep = focusNodes![2];
    searchInputClearStep     = focusNodes![3];
    searchInputDrawStep      = focusNodes![4];
    searchFilterStep         = focusNodes![5];
    searchRadicalStep        = focusNodes![6];
    wordTabStep              = focusNodes![7];
    kanjiTabStep             = focusNodes![8];
    examplesTabStep          = focusNodes![9];
  } 

}
