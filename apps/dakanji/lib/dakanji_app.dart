// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:get_it/get_it.dart';
import 'package:onboarding_overlay/onboarding_overlay.dart';
import 'package:provider/provider.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:window_manager/window_manager.dart';

// Project imports:
import 'package:da_kanji_mobile/core/routing/routing.dart';
import 'package:da_kanji_mobile/features/stats/model/stats.dart';
import 'package:da_kanji_mobile/features/tutorial/controller/tutorial_on_step.dart';
import 'package:da_kanji_mobile/core/routing/navigation_arguments.dart';
import 'package:da_kanji_mobile/features/settings/model/settings.dart';
import 'package:da_kanji_mobile/features/tutorial/model/tutorials.dart';
import 'package:da_kanji_mobile/core/theme/dark_theme.dart';
import 'package:da_kanji_mobile/core/theme/light_theme.dart';
import 'package:da_kanji_mobile/core/user/user_data.dart';
import 'package:da_kanji_mobile/globals.dart';
import 'package:da_kanji_mobile/core/widgets/dakanji_splash.dart';

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
    windowManager.addListener(this);
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    super.dispose();
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
  void onWindowResize() async {

    super.onWindowResize();
    
    if(GetIt.I<Settings>().misc.alwaysSaveWindowSize){
      Size currentSize = await windowManager.getSize();
      GetIt.I<Settings>().misc.windowHeight = currentSize.height.toInt();
      GetIt.I<Settings>().misc.windowWidth = currentSize.width.toInt();
      GetIt.I<Settings>().save();
    }

  }

  @override
  void onWindowMove() async {

    super.onWindowMove();

    if(GetIt.I<Settings>().misc.alwaysSaveWindowPosition){
      Offset currentPos = await windowManager.getPosition();
      GetIt.I<Settings>().misc.windowPosX = currentPos.dx.toInt();
      GetIt.I<Settings>().misc.windowPosY = currentPos.dy.toInt();
      GetIt.I<Settings>().save();
    }

  }
  
  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider<Settings>.value(
      value: GetIt.I<Settings>(),
      builder: (context, providerChild) {
    
        final MediaQueryData data = MediaQuery.of(context);
    
        return MaterialApp(
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
          builder: (context, child) {
            return MediaQuery(
              data: data.copyWith(
                // global font size scaling
                textScaler: TextScaler.linear(context.watch<Settings>().misc.fontSizeScale)
              ),
              child: child ?? const SizedBox(),
            );
          },
        );
      }
    );
  }
}
