// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:da_kanji_mobile/data/screens.dart';
import 'package:da_kanji_mobile/domain/navigation_arguments.dart';
import 'package:da_kanji_mobile/screens/about/about_screen.dart';
import 'package:da_kanji_mobile/screens/changelog/changelog_screen.dart';
import 'package:da_kanji_mobile/screens/clipboard/clipboard_screen.dart';
import 'package:da_kanji_mobile/screens/dictionary/dictionary_screen.dart';
import 'package:da_kanji_mobile/screens/drawing/draw_screen.dart';
import 'package:da_kanji_mobile/screens/home/home_screen.dart';
import 'package:da_kanji_mobile/screens/kana_table/kana_table_screen.dart';
import 'package:da_kanji_mobile/screens/kana_trainer/kana_trainer_screen.dart';
import 'package:da_kanji_mobile/screens/kanji_table/kanji_table_screen.dart';
import 'package:da_kanji_mobile/screens/kanji_trainer/kanji_trainer_screen.dart';
import 'package:da_kanji_mobile/screens/kuzushiji/kuzushiji_screen.dart';
import 'package:da_kanji_mobile/screens/manual/manual_screen.dart';
import 'package:da_kanji_mobile/screens/onboarding/on_boarding_screen.dart';
import 'package:da_kanji_mobile/screens/settings/settings_screen.dart';
import 'package:da_kanji_mobile/screens/test/test_screen.dart';
import 'package:da_kanji_mobile/screens/text/text_screen.dart';
import 'package:da_kanji_mobile/screens/word_lists/word_lists_screen.dart';

/// Returns the screen matching `name` 
Widget getWidgetFromScreen(String? name, NavigationArguments args){

  Widget newRoute;

  if(name == Screens.home.name){
    newRoute = const HomeScreen();
  }
  else if(name == Screens.onboarding.name){
    newRoute = OnBoardingScreen();
  }
  else if(name == Screens.drawing.name){
    newRoute = DrawScreen(
      args.navigatedByDrawer, args.draw_SearchPrefix,
      args.draw_SearchPostfix, true, true
    );
  }
  else if(name == Screens.dictionary.name){
    newRoute = DictionaryScreen(
      args.navigatedByDrawer, true, args.dict_InitialSearch,
      initialEntryId: args.dict_InitialEntryId,
    );
  }
  else if(name == Screens.text.name){
    newRoute = TextScreen(
      args.navigatedByDrawer, true, 
      initialText: args.text_InitialText,
    );
  }
  else if(name == Screens.clipboard.name){
    newRoute = ClipboardScreen(
      args.navigatedByDrawer, true
    );
  }
  else if(name == Screens.kanji_trainer.name){
    newRoute = KanjiTrainerScreen(
      args.navigatedByDrawer, true
    );
  }
  else if(name == Screens.kanji_table.name){
    newRoute = KanjiTableScreen(
      args.navigatedByDrawer, true
    );
  }
  else if(name == Screens.kana_trainer.name){
    newRoute = KanaTrainerScreen(
      args.navigatedByDrawer
    );
  }
  else if(name == Screens.kana_table.name){
    newRoute = KanaTableScreen(
      args.navigatedByDrawer, true
    );
  }
  else if(name == Screens.kuzushiji.name){
    newRoute = KuzushijiScreen(
      args.navigatedByDrawer, true
    );
  }
  else if(name == Screens.word_lists.name){
    newRoute = WordListsScreen(
      args.navigatedByDrawer, true
    );
  }
  else if(name == Screens.settings.name){
    newRoute = SettingsScreen(
      args.navigatedByDrawer
    );
  }
  else if(name == Screens.about.name){
    newRoute = AboutScreen(
      args.navigatedByDrawer
    );
  }
  else if(name == Screens.changelog.name){
    newRoute = ChangelogScreen();
  }
  else if(name == Screens.manual.name){
    newRoute = ManualScreen(
      args.navigatedByDrawer
    );
  }
  else if(name == Screens.test.name){
    newRoute = TestScreen();
  }
  else{
    throw UnsupportedError("Unknown route: $name"); 
  }

  return newRoute;

}
