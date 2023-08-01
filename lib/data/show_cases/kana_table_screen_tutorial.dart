import 'package:easy_localization/easy_localization.dart';

import 'package:da_kanji_mobile/locales_keys.dart';
import 'package:da_kanji_mobile/data/show_cases/tutorial.dart';



class KanaTableScreenTutorial extends Tutorial {


  KanaTableScreenTutorial() {
    titles = [
      LocaleKeys.KanaTableScreen_tutorial_begin_title.tr(),
      "",
      "",
      "",
      "",
      "",
      "",
      "",
    ];
    bodies = [
      LocaleKeys.KanaTableScreen_tutorial_begin_text.tr(),
      LocaleKeys.KanaTableScreen_tutorial_kana_table.tr(),
      LocaleKeys.KanaTableScreen_tutorial_speed_dial.tr(),
      LocaleKeys.KanaTableScreen_tutorial_speed_dial_dakuten.tr(),
      LocaleKeys.KanaTableScreen_tutorial_speed_dial_yoon.tr(),
      LocaleKeys.KanaTableScreen_tutorial_speed_dial_kana.tr(),
      LocaleKeys.KanaTableScreen_tutorial_speed_dial_romaji.tr(),
      LocaleKeys.KanaTableScreen_tutorial_speed_dial_yoon_special.tr()
    ];

    initTutorial();

  } 

}
