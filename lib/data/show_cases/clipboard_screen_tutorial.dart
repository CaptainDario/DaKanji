import 'package:easy_localization/easy_localization.dart';

import 'package:da_kanji_mobile/locales_keys.dart';
import 'package:da_kanji_mobile/data/show_cases/tutorial.dart';



class ClipboardScreenTutorial extends Tutorial {


  ClipboardScreenTutorial() {
    titles = [
      LocaleKeys.ClipboardScreen_title.tr(),
      "",
      "",
      "",
    ];
    bodies = [
      LocaleKeys.ClipboardScreen_tutorial_welcome.tr(),
      LocaleKeys.ClipboardScreen_tutorial_introduction.tr(),
      LocaleKeys.ClipboardScreen_tutorial_explanation.tr(),
      LocaleKeys.ClipboardScreen_tutorial_android_limitation.tr(),
    ];

    initTutorial();

  } 

}