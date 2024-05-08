


// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:get_it/get_it.dart';

// Project imports:
import 'package:da_kanji_mobile/entities/navigation_arguments.dart';
import 'package:da_kanji_mobile/entities/screens.dart';
import 'package:da_kanji_mobile/entities/settings/settings.dart';
import 'package:da_kanji_mobile/globals.dart';

/// Initialize the deep link stream, i.e. dakanji listening to the links that
/// start with "dakanji://" or "https://dakanji.app/app/"
Future<void> initDeepLinksStream() async {

  // Subscribe to all events when app is started.
  g_AppLinks.allUriLinkStream.listen((uri) {
    if(uri.toString().startsWith(g_AppLinkDaKanji) || 
      uri.toString().startsWith(g_AppLinkHttps)){
      handleDeepLink(uri.toString());
    }
  });
}

/// Handles the deep link
void handleDeepLink(String link){

  debugPrint("Deeplink: $link");

  List<String> route = extractRouteFromLink(link);
  Map<String, String> args = extractArgsFromLink(link);

  if(route[0] == Screens.drawing.name){
    handleDeepLinkDrawing(args);
  }
  else if(route[0] == Screens.dictionary.name){
    handleDeepLinkDict(args);
  }
  else if(route[0] == Screens.text.name){
    handleDeepLinkText(args);
  }
  else if(route[0] == Screens.dojg.name){
    handleDeepLinkDojg(args);
  }
  else if(route[0] == "kanji-table"){
    handleDeepLinkKanjiTable(args);
  }
  else if(route[0] == "kana-table"){
    handleDeepLinkKanaTable(args);
  }
  else if(route[0] == Screens.clipboard.name){
    handleDeepLinkClipboard(args);
  }
  else if(route[0] == Screens.settings.name){
    handleDeepLinkSettings(args);
  }
  
}

/// Extracts all route parts from a link and returns them
List<String> extractRouteFromLink(String link){

  List<String> route;

  // remove the base and get the route
  String routeString = link
    .replaceFirst(g_AppLinkHttps, "")
    .replaceFirst(g_AppLinkDaKanji, "");
  routeString = routeString.split("?")[0];

  // split route into separate parts
  route = routeString.split("/");

  return route;
}

/// Extracts all args from a link and returns them
Map<String, String> extractArgsFromLink(String link){

  Map<String, String> args = {};

  // remove the base
  String short = link
    .replaceFirst(g_AppLinkHttps, "")
    .replaceFirst(g_AppLinkDaKanji, "");

  // split into separate args
  List<String> split = short.split("?");
  if(split.length > 1){
    List<String> argsString  = split[1].split("&");

    // split and convert args
    for (String arg in argsString){
      List<String> keyValue = arg.split("=");
      args[keyValue[0]] = keyValue[1];
    }
  }

  return args;
}

/// Handles deep links that are related to the dictionary
void handleDeepLinkDrawing(Map<String, String> linkArgs){

  NavigationArguments? navArgs = NavigationArguments(
    false
  );

  /// set search target to web ...
  if(linkArgs.containsKey("web")){
    // ... 
    
    String dictType = linkArgs["web"]!;
    
    if(dictType == "jisho"){
      GetIt.I<Settings>().drawing.selectedDictionary = 
        GetIt.I<Settings>().drawing.webDictionaries[0];
    }
    else if(dictType == "wadoku"){
      GetIt.I<Settings>().drawing.selectedDictionary = 
        GetIt.I<Settings>().drawing.webDictionaries[1];
    }
    else if(dictType == "weblio"){
      GetIt.I<Settings>().drawing.selectedDictionary = 
        GetIt.I<Settings>().drawing.webDictionaries[2];
    }
    else if(dictType == "custom"){
      if(linkArgs.containsKey("url")){
        GetIt.I<Settings>().drawing.selectedDictionary = 
          GetIt.I<Settings>().drawing.webDictionaries[3];
        GetIt.I<Settings>().drawing.customURL = linkArgs["url"]!;
      }
    }
  }
  /// app search
  else if(linkArgs.containsKey("app")){

    String dictType = linkArgs["app"]!;

    // Android
    if(dictType == "system"){
      GetIt.I<Settings>().drawing.selectedDictionary = 
        GetIt.I<Settings>().drawing.androidDictionaries[0];
    }
    else if(dictType == "aedict"){
      GetIt.I<Settings>().drawing.selectedDictionary = 
        GetIt.I<Settings>().drawing.androidDictionaries[1];
    }
    else if(dictType == "akebi"){
      GetIt.I<Settings>().drawing.selectedDictionary = 
        GetIt.I<Settings>().drawing.androidDictionaries[2];
    }
    else if(dictType == "takoboto"){
      GetIt.I<Settings>().drawing.selectedDictionary = 
        GetIt.I<Settings>().drawing.androidDictionaries[3];
    }
    // iOS
    if(dictType == "shirabe"){
      GetIt.I<Settings>().drawing.selectedDictionary = 
        GetIt.I<Settings>().drawing.iosDictionaries[0];
    }
    else if(dictType == "imiwa"){
      GetIt.I<Settings>().drawing.selectedDictionary = 
        GetIt.I<Settings>().drawing.iosDictionaries[1];
    }
    else if(dictType == "japanese"){
      GetIt.I<Settings>().drawing.selectedDictionary = 
        GetIt.I<Settings>().drawing.iosDictionaries[2];
    }
    else if(dictType == "midori"){
      GetIt.I<Settings>().drawing.selectedDictionary = 
        GetIt.I<Settings>().drawing.iosDictionaries[3];
    }
  }

  String? currentPath;
  g_NavigatorKey.currentState?.popUntil((route) {
    currentPath = route.settings.name;
    return true;
  }); 
  if(currentPath != "/drawing") {
    g_NavigatorKey.currentState?.pushNamedAndRemoveUntil(
      "/${Screens.drawing.name}",
      (route) => false,
      arguments: navArgs
    );
  }
}

/// Handles deep links that are related to the dictionary
void handleDeepLinkDict(Map<String, String> linkArgs){

  NavigationArguments? navArgs = NavigationArguments(
    false
  );

  /// search by id
  if(linkArgs.containsKey("id")){
    navArgs.dictInitialEntryId = int.tryParse(linkArgs["id"]!);
  }
  /// normal dictionary search
  else if(linkArgs.containsKey("search")){
    navArgs.dictInitialSearch = Uri.decodeFull(linkArgs["search"]!);
  }

  g_NavigatorKey.currentState?.pushNamedAndRemoveUntil(
    "/${Screens.dictionary.name}",
    (route) => false,
    arguments: navArgs
  );
}

/// Handles deep links that are related to the text screen
void handleDeepLinkText(Map<String, String> linkArgs){

  NavigationArguments navArgs = NavigationArguments(
    false,
  );

  if(linkArgs.containsKey("text")){
    navArgs.textInitialText = Uri.decodeFull(linkArgs["text"]!);
  }
  
  g_NavigatorKey.currentState?.pushNamedAndRemoveUntil(
    "/${Screens.text.name}",
    (route) => false,
    arguments: navArgs
  );
}

/// Handles deep links that are related to the dojg screen
void handleDeepLinkDojg(Map<String, String> linkArgs){

  NavigationArguments? navArgs = NavigationArguments(
    false
  );

  /// set search target to web ...
  if(linkArgs.containsKey("search")){
    navArgs.dojgInitialSearch = linkArgs["search"]!;

    if(linkArgs.containsKey("open")){
      navArgs.dojgOpenFirstMatch = bool.tryParse(linkArgs["open"]!) ?? false;
    }
  }
  

  g_NavigatorKey.currentState?.pushNamedAndRemoveUntil(
    "/${Screens.dojg.name}",
    (route) => false,
    arguments: navArgs
  );
}

/// Handles deep links that are related to the kanji table screen
void handleDeepLinkKanjiTable(Map<String, String> linkArgs){

  NavigationArguments? navArgs = NavigationArguments(
    false
  );  

  g_NavigatorKey.currentState?.pushNamedAndRemoveUntil(
    "/${Screens.kanjiTable.name}",
    (route) => false,
    arguments: navArgs
  );
}

/// Handles deep links that are related to the kana table screen
void handleDeepLinkKanaTable(Map<String, String> linkArgs){

  NavigationArguments? navArgs = NavigationArguments(
    false
  );  

  g_NavigatorKey.currentState?.pushNamedAndRemoveUntil(
    "/${Screens.kanaTable.name}",
    (route) => false,
    arguments: navArgs
  );
}

/// Handles deep links that are related to the clipboard screen
void handleDeepLinkClipboard(Map<String, String> linkArgs){

  NavigationArguments? navArgs = NavigationArguments(
    false
  );

  g_NavigatorKey.currentState?.pushNamedAndRemoveUntil(
    "/${Screens.clipboard.name}",
    (route) => false,
    arguments: navArgs
  );
}

/// Handles deep links that are related to the settings screen
void handleDeepLinkSettings(Map<String, String> linkArgs){

  NavigationArguments? navArgs = NavigationArguments(
    false
  );  

  g_NavigatorKey.currentState?.pushNamedAndRemoveUntil(
    "/${Screens.settings.name}",
    (route) => false,
    arguments: navArgs
  );
}
