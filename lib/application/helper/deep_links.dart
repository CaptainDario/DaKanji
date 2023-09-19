// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:app_links/app_links.dart';

// Project imports:
import 'package:da_kanji_mobile/data/screens.dart';
import 'package:da_kanji_mobile/domain/navigation_arguments.dart';
import 'package:da_kanji_mobile/globals.dart';

final AppLinks _appLinks = AppLinks();


/// Initialize the deep link stream, i.e. dakanji listening to the links that
/// start with "dakanji://"
Future<void> initDeepLinksStream() async {

  /// Subscribe to all events when app is started.
  // (Use allStringLinkStream to get it as [String])
  _appLinks.allUriLinkStream.listen((uri) {
    if(uri.toString().startsWith(g_AppLink))
      handleDeepLink(uri.toString());
  });
}

/// Handles the deep link
void handleDeepLink(String link){

  debugPrint("Deeplink: $link");

  List<String> route = extractRouteFromLink(link);
  Map<String, String> args = extractArgsFromLink(link);

  if(route[0] == Screens.dictionary.name){
    handleDeepLinkDict(args);
  }
  else if(route[0] == Screens.text.name){
    handleDeepLinkText(args);
  }
}

/// Extracts all route parts from a link and returns them
List<String> extractRouteFromLink(String link){

  List<String> route;

  // remove the base and get the route
  String routeString = link.replaceFirst(g_AppLink, "");
  routeString = routeString.split("?")[0];

  // split route into separate parts
  route = routeString.split("/");

  return route;
}

/// Extracts all args from a link and returns them
Map<String, String> extractArgsFromLink(String link){

  Map<String, String> args = {};

  // remove the base
  String short = link.replaceFirst(g_AppLink, "");

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
    
    //navArgs.dict_InitialEntryId = int.tryParse(linkArgs["id"]!);
  }
  /// app search
  

  g_NavigatorKey.currentState?.pushNamedAndRemoveUntil(
    "/${Screens.dictionary.name}",
    (route) => false,
    arguments: navArgs
  );
}

/// Handles deep links that are related to the dictionary
void handleDeepLinkDict(Map<String, String> linkArgs){

  NavigationArguments? navArgs = NavigationArguments(
    false
  );

  /// search by id
  if(linkArgs.containsKey("id")){
    navArgs.dict_InitialEntryId = int.tryParse(linkArgs["id"]!);
  }
  /// normal dictionary search
  else if(linkArgs.containsKey("search")){
    navArgs.dict_InitialSearch = Uri.decodeFull(linkArgs["search"]!);
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
    navArgs.text_InitialText = Uri.decodeFull(linkArgs["text"]!);
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
  if(linkArgs.containsKey("web")){
    // ... 
    
    //navArgs.dict_InitialEntryId = int.tryParse(linkArgs["id"]!);
  }
  /// app search
  

  g_NavigatorKey.currentState?.pushNamedAndRemoveUntil(
    "/${Screens.dictionary.name}",
    (route) => false,
    arguments: navArgs
  );
}