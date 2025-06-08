// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:feedback/feedback.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:fvp/fvp.dart' as fvp;
import 'package:lite_rt_for_flutter/lite_rt_for_flutter.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:universal_io/io.dart';
import 'package:window_manager/window_manager.dart';

// Project imports:
import 'package:da_kanji_mobile/CodegenLoader.dart';
import 'package:da_kanji_mobile/application/helper/feedback.dart';
import 'package:da_kanji_mobile/dakanji_app.dart';
import 'package:da_kanji_mobile/entities/feedback_localization.dart';
import 'package:da_kanji_mobile/env.dart';
import 'package:da_kanji_mobile/globals.dart';
import 'package:da_kanji_mobile/init.dart';
import 'package:da_kanji_mobile/widgets/widgets/dakanji_splash.dart';

Future<void> main() async {

  // wait for flutter to initialize
  WidgetsFlutterBinding.ensureInitialized();

  // await desktop setup
  if(g_desktopPlatform){
    await windowManager.ensureInitialized();
    await splashscreenDesktop();
  }

  // register packages
  initLiteRTFlutter();
  fvp.registerWith();

  // delete settings for debugging
  //if(kDebugMode) await clearPreferences();

  await SentryFlutter.init(
    (options) {
      options.dsn = (kReleaseMode && Env.SENTRY_DSN != "https://1234567890")
        ? Env.SENTRY_DSN
        : "";
      options.sendDefaultPii = false;
    },
    appRunner: () => runApp(
      Phoenix(
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
                  feedbackBuilder: simpleFeedbackBuilder,
                  theme: FeedbackThemeData(
                    sheetIsDraggable: true,
                    dragHandleColor: Colors.grey
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
  );
}

