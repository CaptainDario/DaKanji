// Package imports:
import 'package:easy_localization/easy_localization.dart';

// Project imports:
import 'package:da_kanji_mobile/data/show_cases/tutorial.dart';
import 'package:da_kanji_mobile/locales_keys.dart';

class WordListsScreenTutorial extends Tutorial {


  WordListsScreenTutorial() {
    titles = [
      LocaleKeys.WordListsScreen_tutorial_begin_title.tr(),
      "",
      "",
      "",
      "",
    ];
    bodies = [
      LocaleKeys.WordListsScreen_tutorial_begin_text.tr(),
      LocaleKeys.WordListsScreen_tutorial_folder.tr(),
      LocaleKeys.WordListsScreen_tutorial_list.tr(),
      LocaleKeys.WordListsScreen_tutorial_create_folder.tr(),
      LocaleKeys.WordListsScreen_tutorial_create_list.tr(),
    ];

    initTutorial();

  } 

}
