import 'package:flutter/material.dart';

import 'package:da_kanji_mobile/widgets/kanji_table/kanji_table.dart';
import 'package:da_kanji_mobile/domain/navigation_arguments.dart';
import 'package:da_kanji_mobile/screens/about/about_screen.dart';
import 'package:da_kanji_mobile/screens/changelog/changelog_screen.dart';
import 'package:da_kanji_mobile/screens/clipboard/clipboard_screen.dart';
import 'package:da_kanji_mobile/screens/dictionary/dictionary_screen.dart';
import 'package:da_kanji_mobile/screens/drawing/draw_screen.dart';
import 'package:da_kanji_mobile/screens/kana_table/kana_table_screen.dart';
import 'package:da_kanji_mobile/screens/kana_trainer/kana_trainer_screen.dart';
import 'package:da_kanji_mobile/screens/kanji_trainer/kanji_trainer_screen.dart';
import 'package:da_kanji_mobile/screens/kuzushiji/kuzushiji_screen.dart';
import 'package:da_kanji_mobile/screens/manual/manual_screen.dart';
import 'package:da_kanji_mobile/screens/settings/settings_screen.dart';
import 'package:da_kanji_mobile/screens/test/test_screen.dart';
import 'package:da_kanji_mobile/screens/text/text_screen.dart';
import 'package:da_kanji_mobile/screens/word_lists/word_lists_screen.dart';
import 'package:da_kanji_mobile/data/screens.dart';
import 'package:da_kanji_mobile/screens/home/home_screen.dart';
import 'package:da_kanji_mobile/screens/onboarding/on_boarding_screen.dart';



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
    newRoute = DrawScreen(openedByDrawer, searchPrefix, searchPostfix, includeHeroes, includeTutorial);
  }
  else if(name == Screens.dictionary.name){
    newRoute = DictionaryScreen(openedByDrawer, includeTutorial, initialSearch);
  }
  else if(name == Screens.text.name){
    newRoute = TextScreen(openedByDrawer, includeTutorial);
  }
  else if(name == Screens.clipboard.name){
    newRoute = ClipboardScreen(openedByDrawer, includeTutorial);
  }
  else if(name == Screens.kanji_trainer.name){
    newRoute = KanjiTrainerScreen(openedByDrawer, includeTutorial);
  }
  else if(name == Screens.kanji_table.name){
    newRoute = KanjiTable(includeTutorial);
  }
  else if(name == Screens.kana_trainer.name){
    newRoute = KanaTrainerScreen();
  }
  else if(name == Screens.kana_table.name){
    newRoute = KanaTableScreen(navigatedByDrawer, includeTutorial);
  }
  else if(name == Screens.kuzushiji.name){
    newRoute = KuzushijiScreen(openedByDrawer, includeTutorial);
  }
  else if(name == Screens.word_lists.name){
    newRoute = WordListsScreen(openedByDrawer, includeTutorial);
  }
  else if(name == Screens.settings.name){
    newRoute = SettingsScreen(openedByDrawer);
  }
  else if(name == Screens.about.name){
    newRoute = AboutScreen(openedByDrawer);
  }
  else if(name == Screens.changelog.name){
    newRoute = ChangelogScreen();
  }
  else if(name == Screens.manual.name){
    newRoute = ManualScreen(openedByDrawer);
  }
  else if(name == Screens.test.name){
    newRoute = TestScreen();
  }
  else{
    throw UnsupportedError("Unknown route: $name"); 
  }

  return newRoute;

}