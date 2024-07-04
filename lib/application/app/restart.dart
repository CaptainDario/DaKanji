// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:da_kanji_mobile/entities/search_history/search_history_sql.dart';
import 'package:da_kanji_mobile/entities/word_lists/word_lists_sql.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:get_it/get_it.dart';

// Project imports:
import 'package:da_kanji_mobile/globals.dart';
import 'package:da_kanji_mobile/init.dart';

/// Restarts the app. It resets all services
Future<void> restartApp(BuildContext context) async {

  g_documentsServicesInitialized = false;
  g_initAppInfoStream = StreamController<String>.broadcast();
  GetIt.I<SearchHistorySQLDatabase>().close();
  GetIt.I<WordListsSQLDatabase>().close();
  await GetIt.I.reset(dispose: true);
  g_initApp = init();
  // ignore: use_build_context_synchronously
  Phoenix.rebirth(context);

}
