// Package imports:
import 'package:easy_localization/easy_localization.dart';

// Project imports:
import 'package:da_kanji_mobile/data/show_cases/tutorial.dart';
import 'package:da_kanji_mobile/locales_keys.dart';

class ClipboardScreenTutorial extends Tutorial {


  ClipboardScreenTutorial() {
    titles = [
      LocaleKeys.ClipboardScreen_tutorial_begin_title.tr(),
      "",
      "",
      "",
    ];
    bodies = [
      LocaleKeys.ClipboardScreen_tutorial_begin_text.tr(),
      LocaleKeys.ClipboardScreen_tutorial_explanation.tr(),
      LocaleKeys.ClipboardScreen_tutorial_android_limitation.tr(),
      LocaleKeys.ClipboardScreen_tutorial_pin_button.tr()
    ];

    initTutorial();

  } 

}
