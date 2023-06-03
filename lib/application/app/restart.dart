import 'dart:async';
import 'package:flutter/material.dart';

import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:get_it/get_it.dart';

import 'package:da_kanji_mobile/init.dart';
import 'package:da_kanji_mobile/globals.dart';



/// Restarts the app. It resets all services
Future<void> restartApp(BuildContext context) async {

  g_documentsServicesInitialized = false;
  g_downloadFromGHStream = StreamController<String>.broadcast();
  await GetIt.I.reset(dispose: true);
  g_initApp = init();
  Phoenix.rebirth(context);

}