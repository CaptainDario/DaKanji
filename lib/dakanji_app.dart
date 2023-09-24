// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:get_it/get_it.dart';
import 'package:navigation_history_observer/navigation_history_observer.dart';
import 'package:onboarding_overlay/onboarding_overlay.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

// Project imports:
import 'package:da_kanji_mobile/application/tutorial/tutorial_on_step.dart';
import 'package:da_kanji_mobile/data/show_cases/tutorials.dart';
import 'package:da_kanji_mobile/data/theme/dark_theme.dart';
import 'package:da_kanji_mobile/data/theme/light_theme.dart';
import 'package:da_kanji_mobile/domain/navigation_arguments.dart';
import 'package:da_kanji_mobile/domain/settings/settings.dart';
import 'package:da_kanji_mobile/domain/user_data/user_data.dart';
import 'package:da_kanji_mobile/globals.dart';
import 'package:da_kanji_mobile/routing.dart';
import 'package:da_kanji_mobile/widgets/widgets/dakanji_splash.dart';

/// The starting widget of the app
class DaKanjiApp extends StatefulWidget {

  const DaKanjiApp({Key? key}) : super(key: key);

  @override
  State<DaKanjiApp> createState() => _DaKanjiAppState();
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
        SentryNavigatorObserver(),
        NavigationHistoryObserver()
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
                  onChanged: onTutorialStep,
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
