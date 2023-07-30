import 'package:easy_localization/easy_localization.dart';

import 'package:da_kanji_mobile/locales_keys.dart';
import 'package:da_kanji_mobile/data/show_cases/tutorial.dart';



class KanjiTableScreenTutorial extends Tutorial {


  KanjiTableScreenTutorial() {
    titles = [
      LocaleKeys.KanjiTableScreen_title.tr(),
      "",
      "",
      "",
      "",
    ];
    bodies = [
      LocaleKeys.KanjiTableScreen_tutorial_welcome.tr(),
      LocaleKeys.KanjiTableScreen_tutorial_filter.tr(),
      LocaleKeys.KanjiTableScreen_tutorial_filter_sub_group.tr(),
      LocaleKeys.KanjiTableScreen_tutorial_sort.tr(),
      LocaleKeys.KanjiTableScreen_tutorial_kanji_amount.tr(),
    ];

    initTutorial();

  } 

}
