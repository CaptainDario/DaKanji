import 'package:da_kanji_mobile/view/word_lists/word_lists_screen.dart';
import 'package:flutter/material.dart';

import 'package:get_it/get_it.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:onboarding_overlay/onboarding_overlay.dart';

import 'package:da_kanji_mobile/view/kanji/kanji_screen.dart';
import 'package:da_kanji_mobile/show_cases/tutorials.dart';
import 'package:da_kanji_mobile/model/light_theme.dart';
import 'package:da_kanji_mobile/model/dark_theme.dart';
import 'package:da_kanji_mobile/model/navigation_arguments.dart';
import 'package:da_kanji_mobile/helper/deep_links.dart';
import 'package:da_kanji_mobile/view/manual/manual_screen.dart';
import 'package:da_kanji_mobile/provider/settings/settings.dart';
import 'package:da_kanji_mobile/model/user_data.dart';
import 'package:da_kanji_mobile/view/home/home_screen.dart';
import 'package:da_kanji_mobile/view/settings/settings_screen.dart';
import 'package:da_kanji_mobile/view/changelog_screen.dart';
import 'package:da_kanji_mobile/view/test_screen.dart';
import 'package:da_kanji_mobile/view/drawing/draw_screen.dart';
import 'package:da_kanji_mobile/view/dictionary/dictionary_screen.dart';
import 'package:da_kanji_mobile/view/text/text_screen.dart';
import 'package:da_kanji_mobile/view/about_screen.dart';
import 'package:da_kanji_mobile/view/onboarding/on_boarding_screen.dart';
import 'package:da_kanji_mobile/globals.dart';
import 'package:da_kanji_mobile/view/kuzushiji/kuzushiji_screen.dart';
import 'package:da_kanji_mobile/dakanji_splash.dart';



/// The starting widget of the app
class DaKanjiApp extends StatefulWidget {

  const DaKanjiApp({Key? key}) : super(key: key);

  @override
  _DaKanjiAppState createState() => _DaKanjiAppState();
}

class _DaKanjiAppState extends State<DaKanjiApp> {

  @override
  dispose() {
    linkSub?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: true,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      
      onGenerateRoute: (settings) {
        PageRouteBuilder switchScreen (Widget screen) =>
          PageRouteBuilder(
            pageBuilder: (_, __, ___) {
                // reload the tutorials
                GetIt.I<Tutorials>().reload();

                return Onboarding(
                  globalOnboarding: true,
                  autoSizeTexts: true,
                  steps: GetIt.I<Tutorials>().getSteps(),
                  onChanged: (int index){
                    print("Tutorial step: $index");
                    if(index == GetIt.I<Tutorials>().drawScreenTutorial.indexes!.last){
                      print("DrawScreen tutorial done, saving...");
                      GetIt.I<UserData>().showShowcaseDrawing = false;
                      GetIt.I<UserData>().save();
                    }
                    else if(index == GetIt.I<Tutorials>().dictionaryScreenTutorial.indexes!.last){
                      print("DictionaryScreen tutorial done, saving...");
                      GetIt.I<UserData>().showShowcaseDictionary = false;
                      GetIt.I<UserData>().save();
                    }
                    else if(index == GetIt.I<Tutorials>().textScreenTutorial.indexes!.last){
                      print("TextScreen tutorial done, saving...");
                      GetIt.I<UserData>().showShowcaseText = false;
                      GetIt.I<UserData>().save();
                    }
                  },
                  child: screen,
                );
            },
            settings: settings,
            transitionsBuilder: (_, a, __, c) =>
              FadeTransition(opacity: a, child: c)
          );

        // check type and extract arguments
        NavigationArguments args;
        if((settings.arguments is NavigationArguments)){
          args = settings.arguments as NavigationArguments;
        }
        else{
          args = NavigationArguments(false);
        }

        switch(settings.name){
          case "/home":
            return switchScreen(const HomeScreen());
          case "/onboarding":
            return switchScreen(const OnBoardingScreen());
          case "/drawing":
            return switchScreen(DrawScreen(
              args.navigatedByDrawer, args.drawSearchPrefix, args.drawSearchPostfix, true, true
            ));
          case "/dictionary":
            return switchScreen(DictionaryScreen(args.navigatedByDrawer, true, args.dictSearch));
          case "/text":
            return switchScreen(TextScreen(args.navigatedByDrawer, true));
          case "/kanji":
            return switchScreen(KanjiScreen(args.navigatedByDrawer, true));
          case "/kuzushiji":
            return switchScreen(KuzushijiScreen(args.navigatedByDrawer, true));
          case "/word_lists":
            return switchScreen(WordListsScreen(args.navigatedByDrawer, true, args.wordListScreenNode));
          case "/settings":
            return switchScreen(SettingsScreen(args.navigatedByDrawer));
          case "/about":
            return switchScreen(AboutScreen(args.navigatedByDrawer));
          case "/changelog":
            return switchScreen(const ChangelogScreen());
          case "/manual":
            return switchScreen(ManualScreen(args.navigatedByDrawer));
          case "/testScreen":
            return switchScreen(TestScreen());
        }
        throw UnsupportedError("Unknown route: ${settings.name}");
      },

      title: g_AppTitle,

      // themes
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: GetIt.I<Settings>().misc.selectedThemeMode(),

      //screens
       home: const DaKanjiSplash(),
      //home: TestScreen()
      initialRoute: "/home",

    );
  }
}
