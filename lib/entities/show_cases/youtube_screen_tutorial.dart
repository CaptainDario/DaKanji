

// Package imports:
import 'package:easy_localization/easy_localization.dart';

// Project imports:
import 'package:da_kanji_mobile/entities/show_cases/tutorial.dart';
import 'package:da_kanji_mobile/locales_keys.dart';

class YoutubeScreenTutorial extends Tutorial {


  YoutubeScreenTutorial() {
    titles = [
      LocaleKeys.YoutubeScreen_tutorial_begin_title.tr(),
    ];
    bodies = [
      LocaleKeys.YoutubeScreen_tutorial_begin_text.tr(),
    ];
    
    initTutorial();
  } 

}
