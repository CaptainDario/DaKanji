// Flutter imports:
import 'package:da_kanji_mobile/screens/user/user_screen.dart';
import 'package:flutter/material.dart';

// Project imports:
import 'package:da_kanji_mobile/core/routing/navigation_arguments.dart';
import 'package:da_kanji_mobile/core/routing/screens.dart';
import 'package:da_kanji_mobile/features/about/screens/about_screen.dart';
import 'package:da_kanji_mobile/features/changelog/screens/changelog_screen.dart';
import 'package:da_kanji_mobile/features/clipboard/screens/clipboard_screen.dart';
import 'package:da_kanji_mobile/features/dictionary/screens/dictionary_screen.dart';
import 'package:da_kanji_mobile/features/dojg/screens/dojg_screen.dart';
import 'package:da_kanji_mobile/features/drawing/screens/draw_screen.dart';
import 'package:da_kanji_mobile/features/init/screens/home_screen.dart';
import 'package:da_kanji_mobile/features/kana_table/screens/kana_table_screen.dart';
import 'package:da_kanji_mobile/features/kana_trainer/screens/kana_trainer_screen.dart';
import 'package:da_kanji_mobile/features/kanji_table/screens/kanji_table_screen.dart';
import 'package:da_kanji_mobile/features/kanji_trainer/screens/kanji_trainer_screen.dart';
import 'package:da_kanji_mobile/features/manual/screens/manual_screen.dart';
import 'package:da_kanji_mobile/features/ocr/screens/ocr_screen.dart';
import 'package:da_kanji_mobile/features/onboarding/screens/on_boarding_screen.dart';
import 'package:da_kanji_mobile/features/immersion/screens/immersion_screen.dart';
import 'package:da_kanji_mobile/features/settings/screens/settings_screen.dart';
import 'package:da_kanji_mobile/features/text/screens/text_screen.dart';
import 'package:da_kanji_mobile/features/webbrowser/screens/webbrowser_screen.dart';
import 'package:da_kanji_mobile/features/word_lists/screens/word_lists_screen.dart';
import 'package:da_kanji_mobile/features/youtube/screens/youtube_screen.dart';

/// Returns the screen matching `name` 
Widget getWidgetFromScreen(String? name, NavigationArguments args){

  Widget newRoute;
  
  if(name == "/${Screens.home.name}"){
    newRoute = const InitScreen();
  }
  else if(name == "/${Screens.onboarding.name}"){
    newRoute = const OnBoardingScreen();
  }
  else if(name == "/${Screens.user.name}"){
    newRoute = UserScreen(
      args.navigatedByDrawer,
      true);
  }
  else if(name == "/${Screens.drawing.name}"){
    newRoute = DrawScreen(
      args.navigatedByDrawer, args.drawSearchPrefix,
      args.drawSearchPostfix, true, true
    );
  }
  else if(name == "/${Screens.dictionary.name}"){
    newRoute = DictionaryScreen(
      args.navigatedByDrawer, true, args.dictInitialSearch,
      initialEntryId: args.dictInitialEntryId,
    );
  }
  else if(name == "/${Screens.text.name}"){
    newRoute = TextScreen(
      args.navigatedByDrawer, true, 
      initialText: args.textInitialText,
    );
  }
  else if(name == "/${Screens.immersion.name}"){
    newRoute = ImmersionScreen(
      args.navigatedByDrawer, true,
    );
  }
  else if(name == "/${Screens.webbrowser.name}"){
    newRoute = WebBrowserScreen(
      args.navigatedByDrawer, true,
    );
  }
  else if(name == "/${Screens.ocr.name}"){
    newRoute = OcrScreen(
      args.navigatedByDrawer, true,
    );
  }
  else if(name == "/${Screens.youtube.name}"){
    newRoute = YoutubeScreen(
      args.navigatedByDrawer, true,
    );
  }
  else if(name == "/${Screens.dojg.name}"){
    newRoute = DoJGScreen(
      args.navigatedByDrawer, true,
      openFirstResult: args.dojgOpenFirstMatch,
      initialSearch: args.dojgInitialSearch,
    );
  }
  else if(name == "/${Screens.clipboard.name}"){
    newRoute = ClipboardScreen(
      args.navigatedByDrawer, true
    );
  }
  else if(name == "/${Screens.kanjiTrainer.name}"){
    newRoute = KanjiTrainerScreen(
      args.navigatedByDrawer, true
    );
  }
  else if(name == "/${Screens.kanjiTable.name}"){
    newRoute = KanjiTableScreen(
      args.navigatedByDrawer, true
    );
  }
  else if(name == "/${Screens.kanaTrainer.name}"){
    newRoute = KanaTrainerScreen(
      args.navigatedByDrawer
    );
  }
  else if(name == "/${Screens.kanaTable.name}"){
    newRoute = KanaTableScreen(
      args.navigatedByDrawer, true
    );
  }
  else if(name == "/${Screens.wordLists.name}"){
    newRoute = WordListsScreen(
      args.navigatedByDrawer, true
    );
  }
  else if(name == "/${Screens.settings.name}"){
    newRoute = SettingsScreen(
      args.navigatedByDrawer
    );
  }
  else if(name == "/${Screens.about.name}"){
    newRoute = AboutScreen(
      args.navigatedByDrawer
    );
  }
  else if(name == "/${Screens.changelog.name}"){
    newRoute = const ChangelogScreen();
  }
  else if(name == "/${Screens.manual.name}"){
    newRoute = ManualScreen(
      args.navigatedByDrawer
    );
  }
  else{
    throw UnsupportedError("Unknown route: $name"); 
  }

  return newRoute;

}
