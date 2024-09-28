// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_browser/models/browser_model.dart';
import 'package:flutter_browser/models/webview_model.dart';
import 'package:get_it/get_it.dart';
import 'package:onboarding_overlay/onboarding_overlay.dart';
import 'package:provider/provider.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:window_manager/window_manager.dart';

// Project imports:
import 'package:da_kanji_mobile/application/routing/routing.dart';
import 'package:da_kanji_mobile/application/stats/stats.dart';
import 'package:da_kanji_mobile/application/tutorial/tutorial_on_step.dart';
import 'package:da_kanji_mobile/entities/navigation_arguments.dart';
import 'package:da_kanji_mobile/entities/settings/settings.dart';
import 'package:da_kanji_mobile/entities/show_cases/tutorials.dart';
import 'package:da_kanji_mobile/entities/theme/dark_theme.dart';
import 'package:da_kanji_mobile/entities/theme/light_theme.dart';
import 'package:da_kanji_mobile/entities/user_data/user_data.dart';
import 'package:da_kanji_mobile/globals.dart';
import 'package:da_kanji_mobile/widgets/widgets/dakanji_splash.dart';

/// The starting widget of the app
class DaKanjiApp extends StatefulWidget {

  const DaKanjiApp({super.key});

  @override
  State<DaKanjiApp> createState() => _DaKanjiAppState();
}

class _DaKanjiAppState extends State<DaKanjiApp> with WidgetsBindingObserver, WindowListener{

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    
    // app active again
    if(state == AppLifecycleState.resumed){
      GetIt.I<Stats>().appActive = true;
    }
    // app inactive
    else {
      GetIt.I<Stats>().appActive = false;
      GetIt.I<UserData>().save();
    }
    
    super.didChangeAppLifecycleState(state);
  }

  /// This is only applicable to desktop application
  @override
  void onWindowClose() {

    super.onWindowClose();
    windowManager.destroy();
    
  }
  
  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => WebViewModel(),
        ),
        ChangeNotifierProxyProvider<WebViewModel, BrowserModel>(
          update: (context, webViewModel, browserModel) {
            browserModel!.setCurrentWebViewModel(webViewModel);
            return browserModel;
          },
          create: (BuildContext context) => BrowserModel(),
        ),
      ],
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => WebViewModel(),
          ),
          ChangeNotifierProxyProvider<WebViewModel, BrowserModel>(
            update: (context, webViewModel, browserModel) {
              browserModel!.setCurrentWebViewModel(webViewModel);
              return browserModel;
            },
            create: (BuildContext context) => BrowserModel(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: true,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          navigatorKey: g_NavigatorKey,
          navigatorObservers: [
            SentryNavigatorObserver(),
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
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: GetIt.I<Settings>().misc.selectedThemeMode(),
          initialRoute: "/home",
          home: const DaKanjiSplash(),
        ),
      ),
    );
  }
}
