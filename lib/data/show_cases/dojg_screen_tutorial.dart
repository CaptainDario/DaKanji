

import 'package:easy_localization/easy_localization.dart';

import 'package:da_kanji_mobile/data/show_cases/tutorial.dart';
import 'package:da_kanji_mobile/locales_keys.dart';



class DojgScreenTutorial extends Tutorial {


  DojgScreenTutorial() {
    titles = [
      LocaleKeys.DojgScreen_tutorial_begin_title.tr(),
      "",
    ];
    bodies = [
      LocaleKeys.DojgScreen_tutorial_begin_text.tr(),
    ];
    
    initTutorial();
  } 

}