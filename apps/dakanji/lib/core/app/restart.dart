// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:da_kanji_mobile/core/user/user_data_db.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:get_it/get_it.dart';

// Project imports:
import 'package:da_kanji_mobile/globals.dart';
import 'package:da_kanji_mobile/features/init/controller/init.dart';

/// Restarts the app. It resets all services
Future<void> restartApp(BuildContext context) async {

  g_documentsServicesInitialized = false;
  g_initAppInfoStream = StreamController<String>.broadcast();
  if (GetIt.I.isRegistered<UserDataDB>()) {
    GetIt.I<UserDataDB>().close();
  }
  await GetIt.I.reset(dispose: true);
  
  await preRunInit();
  g_initApp = postRunInit().then((_) => true);

  // ignore: use_build_context_synchronously
  Phoenix.rebirth(context);

}
