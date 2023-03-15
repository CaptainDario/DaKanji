import 'dart:async';
import 'package:da_kanji_mobile/model/navigation_arguments.dart';
import 'package:flutter/foundation.dart';

import 'package:app_links/app_links.dart';

import 'package:da_kanji_mobile/globals.dart';



final AppLinks _appLinks = AppLinks();

NavigationArguments? g_deepLinkNavigationArguments;

Future<void> initDeepLinksStream() async {

  /// Subscribe to all events when app is started.
  // (Use allStringLinkStream to get it as [String])
  _appLinks.allUriLinkStream.listen((uri) {
    if(uri.isScheme("dakanji") && uri.toString().startsWith(g_AppLink))
      handleDeepLink(uri.toString());
  });
}

void handleDeepLink(String link){

  String short = link.replaceFirst(g_AppLink, "");

  debugPrint("Deeplink: $short");

  if(short.startsWith("dictionary"))
    handDeepLinkDict(short);
}

void handDeepLinkDict(String dictLink){

}