import 'dart:async';
import 'package:flutter/material.dart';

import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:feedback/feedback.dart';
import 'package:media_kit/media_kit.dart';

import 'package:da_kanji_mobile/widgets/widgets/dakanji_splash.dart';
import 'package:da_kanji_mobile/dakanji_app.dart';
import 'package:da_kanji_mobile/globals.dart';
import 'package:da_kanji_mobile/CodegenLoader.dart';
import 'package:da_kanji_mobile/feedback_localization.dart';



Future<void> main() async {

  // initialize the app
  WidgetsFlutterBinding.ensureInitialized();
  MediaKit.ensureInitialized();

  // delete settings
  //await clearPreferences();

  await SentryFlutter.init(
    (options) {
      options.dsn = 'https://5d7af59794f44bb2a457adc5d86ab890@o4504719855648768.ingest.sentry.io/4504719856762880';
    },
    appRunner: () => runApp(
      Phoenix(
        child: FutureBuilder(
          future: g_initApp,
          builder: (context, snapshot) {
            if(snapshot.hasData == false)
              return DaKanjiSplash();
            else
              return EasyLocalization(
                supportedLocales: g_DaKanjiLocalizations.map((e) => Locale(e)).toList(),
                path: 'assets/translations',
                fallbackLocale: const Locale('en'),
                useFallbackTranslations: true,
                useOnlyLangCode: true,
                assetLoader: const CodegenLoader(),
                saveLocale: true,
                startLocale: const Locale("en"),
                child: BetterFeedback(
                  theme: FeedbackThemeData(
                    sheetIsDraggable: true
                  ),
                  localizationsDelegates: [
                    CustomFeedbackLocalizationsDelegate()..supportedLocales = {
                      const Locale('en'): CustomFeedbackLocalizations()
                    },
                  ],
                  localeOverride: const Locale("en"),
                  mode: FeedbackMode.navigate,
                  child: const DaKanjiApp(),
                ),
              );
          }
        ),
      )
    )
  );
}

