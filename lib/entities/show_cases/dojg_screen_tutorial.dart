

// Package imports:
import 'package:easy_localization/easy_localization.dart';

// Project imports:
import 'package:da_kanji_mobile/entities/show_cases/tutorial.dart';
import 'package:da_kanji_mobile/locales_keys.dart';

class DojgScreenTutorial extends Tutorial {


  DojgScreenTutorial() {
    titles = [
      LocaleKeys.DojgScreen_tutorial_begin_title.tr(),
      "",
      "",
      "",
    ];
    bodies = [
      LocaleKeys.DojgScreen_tutorial_begin_text.tr(),
      LocaleKeys.DojgScreen_tutorial_search.tr(),
      LocaleKeys.DojgScreen_tutorial_volumes.tr(),
      LocaleKeys.DojgScreen_tutorial_results.tr(),
    ];
    
    initTutorial();
  } 

}
