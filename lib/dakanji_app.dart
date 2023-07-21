import 'package:flutter/material.dart';

import 'package:get_it/get_it.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:onboarding_overlay/onboarding_overlay.dart';

import 'package:da_kanji_mobile/screens/kanji_table/kanji_table_screen.dart';
import 'package:da_kanji_mobile/screens/kana_table/KanaTableScreen.dart';
import 'package:da_kanji_mobile/screens/word_lists/word_lists_screen.dart';
import 'package:da_kanji_mobile/screens/kanji/kanji_trainer_screen.dart';
import 'package:da_kanji_mobile/data/show_cases/tutorials.dart';
import 'package:da_kanji_mobile/data/theme/dark_theme.dart';
import 'package:da_kanji_mobile/data/theme/light_theme.dart';
import 'package:da_kanji_mobile/domain/navigation_arguments.dart';
import 'package:da_kanji_mobile/screens/manual/manual_screen.dart';
import 'package:da_kanji_mobile/domain/settings/settings.dart';
import 'package:da_kanji_mobile/domain/user_data/user_data.dart';
import 'package:da_kanji_mobile/screens/home/home_screen.dart';
import 'package:da_kanji_mobile/screens/settings/settings_screen.dart';
import 'package:da_kanji_mobile/screens/changelog/changelog_screen.dart';
import 'package:da_kanji_mobile/screens/test/test_screen.dart';
import 'package:da_kanji_mobile/screens/drawing/draw_screen.dart';
import 'package:da_kanji_mobile/screens/dictionary/dictionary_screen.dart';
import 'package:da_kanji_mobile/screens/text/text_screen.dart';
import 'package:da_kanji_mobile/screens/about/about_screen.dart';
import 'package:da_kanji_mobile/screens/onboarding/on_boarding_screen.dart';
import 'package:da_kanji_mobile/globals.dart';
import 'package:da_kanji_mobile/screens/kuzushiji/kuzushiji_screen.dart';
import 'package:da_kanji_mobile/widgets/widgets/dakanji_splash.dart';
import 'package:da_kanji_mobile/screens/clipboard/clipboard_screen.dart';



/// The starting widget of the app
class DaKanjiApp extends StatefulWidget {

  const DaKanjiApp({Key? key}) : super(key: key);

  @override
  _DaKanjiAppState createState() => _DaKanjiAppState();
}

class _DaKanjiAppState extends State<DaKanjiApp> {

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
      navigatorKey: g_NavigatorKey,
      
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
                  onChanged: (int index) async {
                    print("Tutorial step: $index");
                    if(index == GetIt.I<Tutorials>().drawScreenTutorial.indexes!.last){
                      print("DrawScreen tutorial done, saving...");
                      GetIt.I<UserData>().showTutorialDrawing = false;
                      await GetIt.I<UserData>().save();
                    }
                    else if(index == GetIt.I<Tutorials>().dictionaryScreenTutorial.indexes!.last){
                      print("DictionaryScreen tutorial done, saving...");
                      GetIt.I<UserData>().showTutorialDictionary = false;
                      await GetIt.I<UserData>().save();
                    }
                    else if(index == GetIt.I<Tutorials>().textScreenTutorial.indexes!.last){
                      print("TextScreen tutorial done, saving...");
                      GetIt.I<UserData>().showTutorialText = false;
                      await GetIt.I<UserData>().save();
                    }
                    else if(index == GetIt.I<Tutorials>().clipboardScreenTutorial.indexes!.last){
                      print("Clipboard screen tutorial done, saving...");
                      GetIt.I<UserData>().showTutorialClipboard = false;
                      await GetIt.I<UserData>().save();
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
              args.navigatedByDrawer, args.drawSearchPrefix,
              args.drawSearchPostfix, true, true
            ));
          case "/dictionary":
            return switchScreen(DictionaryScreen(
              args.navigatedByDrawer, true, args.initialDictSearch,
              initialEntryId: args.initialEntryId,
            ));
          case "/text":
            return switchScreen(TextScreen(
              args.navigatedByDrawer, true, 
              initialText: args.initialText,
            ));
          case "/clipboard":
            return switchScreen(ClipboardScreen(args.navigatedByDrawer, true));
          case "/kanji_trainer":
            return switchScreen(KanjiTrainerScreen(args.navigatedByDrawer, true));
          case "/kanji_table":
            return switchScreen(KanjiTableScreen(args.navigatedByDrawer, true));
          case "/kana_table":
            return switchScreen(KanaTableScreen(args.navigatedByDrawer));
          case "/kuzushiji":
            return switchScreen(KuzushijiScreen(args.navigatedByDrawer, true));
          case "/word_lists":
            return switchScreen(WordListsScreen(args.navigatedByDrawer, true));
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
