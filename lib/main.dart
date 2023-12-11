// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:feedback/feedback.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:media_kit/media_kit.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:universal_io/io.dart';

// Project imports:
import 'package:da_kanji_mobile/CodegenLoader.dart';
import 'package:da_kanji_mobile/dakanji_app.dart';
import 'package:da_kanji_mobile/entities/feedback_localization.dart';
import 'package:da_kanji_mobile/env/env.dart';
import 'package:da_kanji_mobile/globals.dart';
import 'package:da_kanji_mobile/widgets/widgets/dakanji_splash.dart';

Future<void> main() async {

  // initialize the app
  WidgetsFlutterBinding.ensureInitialized();
  MediaKit.ensureInitialized();

  // delete settings
  //await clearPreferences();

  await SentryFlutter.init(
    (options) {
      options.dsn = kReleaseMode
        ? Env.SENTRY_DSN
        : "";
    },
    appRunner: () => runApp(
      ProviderScope(
        child: Phoenix(
          child: FutureBuilder(
            future: g_initApp,
            builder: (context, snapshot) {
              if(snapshot.hasData == false) {
                return const DaKanjiSplash();
              } else {
                return EasyLocalization(
                  supportedLocales: g_DaKanjiLocalizations.map((e) => Locale(e)).toList(),
                  path: 'assets/translations',
                  fallbackLocale: const Locale('en'),
                  useFallbackTranslations: true,
                  useOnlyLangCode: true,
                  assetLoader: const CodegenLoader(),
                  saveLocale: true,
                  startLocale: Platform.isLinux ? const Locale("en") : null,
                  child: BetterFeedback(
                    theme: FeedbackThemeData(
                      sheetIsDraggable: true
                    ),
                    localizationsDelegates: [
                      CustomFeedbackLocalizationsDelegate(),
                    ],
                    localeOverride: const Locale("en"),
                    mode: FeedbackMode.navigate,
                    child: const DaKanjiApp(),
                  ),
                );
              }
            }
          ),
        ),
      )
    )
  );
}

