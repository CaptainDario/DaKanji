import 'dart:async';
import 'package:da_kanji_mobile/model/navigation_arguments.dart';
import 'package:flutter/foundation.dart';

import 'package:app_links/app_links.dart';

import 'package:da_kanji_mobile/globals.dart';



final AppLinks _appLinks = AppLinks();


/// Initialize the deep link stream, i.e. dakanji listening to the links that
/// start with "dakanji://"
Future<void> initDeepLinksStream() async {

  /// Subscribe to all events when app is started.
  // (Use allStringLinkStream to get it as [String])
  _appLinks.allUriLinkStream.listen((uri) {
    if(uri.isScheme("dakanji") && uri.toString().startsWith(g_AppLink))
      handleDeepLink(uri.toString());
  });
}

/// Handles the deep link
void handleDeepLink(String link){

  String short = link.replaceFirst(g_AppLink, "");

  debugPrint("Deeplink: $short");

  if(short.startsWith("dictionary/"))
    handDeepLinkDict(short.replaceFirst("dictionary/", ""));
  else if(short.startsWith("text/"))
    handleDeepLinkText(short.replaceFirst("text/", ""));
}

/// Handles deep links that are related to the text screen
void handleDeepLinkText(String textLink){

  NavigationArguments args = NavigationArguments(
    false,
    initialText: Uri.decodeFull(textLink)
  );
  
  g_NavigatorKey.currentState?.pushNamedAndRemoveUntil(
    "/text",
    (route) => false, arguments: args
  );
}

/// Handles deep links that are related to the dictionary
void handDeepLinkDict(String dictLink){

  NavigationArguments? args;

  /// search by id
  if(dictLink.startsWith("id/")){
    args = NavigationArguments(
      false,
      initialEntryId: int.tryParse(dictLink.replaceFirst("id/", ""))
    );
  }
  /// normal dictionary search
  else if(dictLink.startsWith("search/")){
    // assure that the search string is not encoded
    String search = dictLink.replaceFirst("search/", "");
    search = Uri.decodeFull(search);
    args = NavigationArguments(
      false,
      initialDictSearch: search
    );
  }
  
  if(args != null)
    g_NavigatorKey.currentState?.pushNamedAndRemoveUntil(
      "/dictionary",
      (route) => false, arguments: args
    );
}