import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';

/// Main class of the plugin.
class AppAvailability {
  static const MethodChannel _channel =
      const MethodChannel('com.pichillilorenzo/flutter_appavailability');

  /// Check if an app is available with the given [uri] scheme.
  ///
  /// Returns a [Map<String, String>] containing info about the App or throws a [PlatformException]
  /// if the app isn't found.
  ///
  /// The returned [Map] has a form like this:
  /// ```dart
  /// {
  ///   "app_name": "",
  ///   "package_name": "",
  ///   "versionCode": "",
  ///   "version_name": ""
  /// }
  static Future<Map<String, String>> checkAvailability(String uri) async {
    Map<String, dynamic> args = <String, dynamic>{};
    args.putIfAbsent('uri', () => uri);

    if (Platform.isAndroid) {
      Map<dynamic, dynamic> app =
          await _channel.invokeMethod("checkAvailability", args);
      return {
        "app_name": app["app_name"],
        "package_name": app["package_name"],
        "versionCode": app["versionCode"],
        "version_name": app["version_name"]
      };
    } else if (Platform.isIOS) {
      bool appAvailable =
          await _channel.invokeMethod("checkAvailability", args);
      if (!appAvailable) {
        throw PlatformException(code: "", message: "App not found $uri");
      }
      return {
        "app_name": "",
        "package_name": uri,
        "versionCode": "",
        "version_name": ""
      };
    }

    return Future.value({});
  }

  /// Only for **Android**.
  ///
  /// Get the list of all installed apps, where
  /// each app has a form like [checkAvailability()].
  static Future<List<Map<String, String>>> getInstalledApps() async {
    List<dynamic>? apps = await _channel.invokeMethod("getInstalledApps");
    if (apps != null && apps is List) {
      List<Map<String, String>> list = [];
      for (var app in apps) {
        if (app is Map) {
          list.add({
            "app_name": app["app_name"],
            "package_name": app["package_name"],
            "versionCode": app["versionCode"],
            "version_name": app["version_name"]
          });
        }
      }

      return list;
    }

    return List.empty();
  }

  /// Only for **Android**.
  ///
  /// Check if the app is enabled or not with the given [uri] scheme.
  ///
  /// If the app isn't found, then a [PlatformException] is thrown.
  static Future<bool> isAppEnabled(String uri) async {
    Map<String, dynamic> args = <String, dynamic>{};
    args.putIfAbsent('uri', () => uri);
    return await _channel.invokeMethod("isAppEnabled", args);
  }

  /// Launch an app with the given [uri] scheme if it exists.
  ///
  /// If the app app isn't found, then a [PlatformException] is thrown.
  static Future<void> launchApp(String uri) async {
    Map<String, dynamic> args = <String, dynamic>{};
    args.putIfAbsent('uri', () => uri);
    if (Platform.isAndroid) {
      await _channel.invokeMethod("launchApp", args);
    } else if (Platform.isIOS) {
      bool appAvailable = await _channel.invokeMethod("launchApp", args);
      if (!appAvailable) {
        throw PlatformException(code: "", message: "App not found $uri");
      }
    }
  }
}
