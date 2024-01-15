import 'dart:convert';
import 'dart:math';
import 'package:da_kanji_mobile/globals.dart';
import 'package:da_kanji_mobile/repositories/releases/installation_method.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:universal_io/io.dart';



/// The api to use for posthog
String posthogServiceURL = 'https://eu.posthog.com/capture/';
/// The default header to use for posthog
Map<String, String> posthogHeader = {"Content-Type": "application/json"};
/// The identifier in the sharedpreferences to store the posthog events
String prefsPosthogCacheName = "cachedPosthogEvents";


/// Logs an even by its name with the default properties
Future<bool> logDefaultEvent(String eventName) async {

  bool success;

  final body = {
    "api_key": "phc_dIGlCR8Gwl9KsqHMJQ6Cu533vjYZEklTIdncgLQZkGp",//Env.POSTHOG_API_KEY,
    "event": eventName,
    "properties" : await defaultProperties(),
    "timestamp": (DateTime.now().toUtc()).toIso8601String(),
  };

  success = await logEvent(posthogServiceURL, posthogHeader, body);

  return success;

}

/// Logs a given event by its name and properties
Future<bool> logEvent(String url, Map<String, String> header, Map body) async {

  bool success;

  success = await _logEventPosthogREST(url, header, jsonEncode(body));

  return success;

}

/// Returns a properties map configured with all the default properties
Future<Map> defaultProperties() async {

  return {
    "Installation method" : await findInstallationMethod(),
    "Platform" : Platform.operatingSystem,
    "Version" : g_Version.fullVersionString,
    "Debug" : kDebugMode,
    "distinct_id": "Anonym_${randomId()}"
  };

}

/// Returns a randomly genrated id
String randomId(){

  final n = DateTime.now();

  String r = "${n.year}${n.month}${n.day}${n.second}${n.millisecond}${n.microsecond}";
  r += "${Random().nextInt(0x7fffffff)}";

  return r;

}

/// Uses the Posthog REST API backend for logging an event
Future<bool> _logEventPosthogREST(String url, Map<String, String> header, String body) async {
  
  bool success = false;

  try{
    http.Response response = (await http.post(
      Uri.parse(posthogServiceURL),
      headers: header,
      body: body
    ));
    Map jsonBody = jsonDecode(response.body);

    if(jsonBody["status"] == 1){
      success = true;
    }
  }
  // cache the request when it was not successful to send it later
  catch (e) {
    //await cacheEvent(body);
  }

  return success;
}

/// Caches the given event to disk. `retryCachedEvents` can be used to retry
/// send the cached events
Future<void> cacheEvent(String event) async {

  // load cached events
  final prefs = await SharedPreferences.getInstance();
  List<String> cachedEvents = prefs.getStringList(prefsPosthogCacheName) ?? [];

  // append new event and write to disk
  cachedEvents.add(event);
  await prefs.setStringList(prefsPosthogCacheName, cachedEvents);

}

/// Retries to send all cached events
Future<void> retryCachedEvents() async {

  // load cached events
  final prefs = await SharedPreferences.getInstance();
  List<String> cachedEvents = prefs.getStringList(prefsPosthogCacheName) ?? [];
  List<String> remainingEvents = cachedEvents;
  
  if(cachedEvents == []) return;

  // try to resend all events
  for (int i = 0; i < cachedEvents.length; i++) {
    bool success = await logEvent(
      posthogServiceURL, posthogHeader, jsonDecode(cachedEvents[i]));

    if(!success){
      return;
    }
    else{
      remainingEvents.removeAt(i);
      prefs.setStringList(prefsPosthogCacheName, remainingEvents);
    }
  }

}