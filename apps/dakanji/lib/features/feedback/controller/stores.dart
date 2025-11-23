// Dart imports:
import 'dart:io';

// Package imports:
import 'package:url_launcher/url_launcher_string.dart';

// Project imports:
import 'package:da_kanji_mobile/globals.dart';

/// opens the store listing of dakanji matching the current platform
void openStoreListing(){
  if(Platform.isAndroid) {
    launchUrlString(g_PlaystorePage);
  }
  else if(Platform.isIOS || Platform.isMacOS) {
    launchUrlString(g_AppStorePage);
  }
  else if(Platform.isWindows) {
    launchUrlString(g_MicrosoftStorePage);
  }
  else if(Platform.isLinux) {
    launchUrlString(g_SnapStorePage);
  }
  else {
    throw Exception("Platform not supported");
  }
}