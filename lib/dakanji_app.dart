// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:get_it/get_it.dart';
import 'package:onboarding_overlay/onboarding_overlay.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

// Project imports:
import 'package:da_kanji_mobile/data/show_cases/tutorials.dart';
import 'package:da_kanji_mobile/data/theme/dark_theme.dart';
import 'package:da_kanji_mobile/data/theme/light_theme.dart';
import 'package:da_kanji_mobile/domain/navigation_arguments.dart';
import 'package:da_kanji_mobile/domain/settings/settings.dart';
import 'package:da_kanji_mobile/domain/user_data/user_data.dart';
import 'package:da_kanji_mobile/globals.dart';
import 'package:da_kanji_mobile/routing.dart';
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
import 'package:da_kanji_mobile/widgets/widgets/dakanji_splash.dart';

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
      navigatorObservers: [
        SentryNavigatorObserver()
      ],
      
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
                    else if(index == GetIt.I<Tutorials>().kanjiTableScreenTutorial.indexes!.last){
                      print("Kanji table screen tutorial done, saving...");
                      GetIt.I<UserData>().showTutorialKanjiTable = false;
                      await GetIt.I<UserData>().save();
                    }
                    else if(index == GetIt.I<Tutorials>().kanaTableScreenTutorial.indexes!.last){
                      print("Kana table screen tutorial done, saving...");
                      GetIt.I<UserData>().showTutorialKanaTable = false;
                      await GetIt.I<UserData>().save();
                    }
                    else if(index == GetIt.I<Tutorials>().wordListsScreenTutorial.indexes!.last){
                      print("Word lists screen tutorial done, saving...");
                      GetIt.I<UserData>().showTutorialWordLists = false;
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
        NavigationArguments args = NavigationArguments(false);

        if((settings.arguments is NavigationArguments)){
          args = settings.arguments as NavigationArguments;
        }

        return switchScreen(getWidgetFromScreen(settings.name, args));
        
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
