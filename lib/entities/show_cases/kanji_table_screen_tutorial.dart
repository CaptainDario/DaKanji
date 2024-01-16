// Package imports:
import 'package:easy_localization/easy_localization.dart';

// Project imports:
import 'package:da_kanji_mobile/entities/show_cases/tutorial.dart';
import 'package:da_kanji_mobile/locales_keys.dart';

class KanjiTableScreenTutorial extends Tutorial {


  KanjiTableScreenTutorial() {
    titles = [
      LocaleKeys.KanjiTableScreen_tutorial_begin_title.tr(),
      "",
      "",
      "",
      "",
      "",
    ];
    bodies = [
      LocaleKeys.KanjiTableScreen_tutorial_begin_text.tr(),
      LocaleKeys.KanjiTableScreen_tutorial_kanjis.tr(),
      LocaleKeys.KanjiTableScreen_tutorial_filter.tr(),
      LocaleKeys.KanjiTableScreen_tutorial_filter_sub_group.tr(),
      LocaleKeys.KanjiTableScreen_tutorial_sort.tr(),
      LocaleKeys.KanjiTableScreen_tutorial_kanji_amount.tr(),
    ];

    initTutorial();

  } 

}
