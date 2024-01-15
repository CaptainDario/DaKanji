import 'dart:convert';
import 'dart:math';
import 'package:da_kanji_mobile/env.dart';
import 'package:da_kanji_mobile/globals.dart';
import 'package:da_kanji_mobile/repositories/releases/installation_method.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:universal_io/io.dart';



String analyticsService = "posthog_rest";


/// Logs a given event by its name and properties
Future<bool> logEvent(String eventName, Map properties) async {

  bool success;

  success = await _logEventPosthogREST(eventName, properties);

  return success;

}

/// Logs an even by its name with the default properties
Future<bool> logDefaultEvent(String eventName) async {

  bool success;

  Map properties = await defaultProperties(eventName);

  success = await logEvent(eventName, properties);

  return success;

}

/// Returns a properties map configured with all the default properties
Future<Map> defaultProperties(String eventName) async {

  return {
    "Installation method" : await findInstallationMethod(),
    "Platform" : Platform.operatingSystem,
    "Version" : g_Version.fullVersionString,
    "Debug" : kDebugMode,
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
Future<bool> _logEventPosthogREST(String eventName, Map properties) async {
  
  bool success = false;

  final completeProps = properties..addAll({
    "distinct_id": "Anonym_${randomId()}",
  });

  final body = jsonEncode({
      "api_key": Env.POSTHOG_API_KEY,
      "event": eventName,
      "properties" : completeProps,
      "timestamp": DateTime.now().toIso8601String(),
    });

  try{
    Map response = jsonDecode((await http.post(
      Uri.parse('https://eu.posthog.com/capture/'),
      headers: {"Content-Type": "application/json",},
      body: body
    )).body);

    if(response["status"] == 1){
      success = true;
    }
  }
  // cache the request when it was not successful to send it later
  catch (e) {
    print(e);
  }

  return success;
}