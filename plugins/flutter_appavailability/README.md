# Flutter AppAvailability Plugin

[![Pub](https://img.shields.io/pub/v/flutter_appavailability.svg)](https://pub.dartlang.org/packages/flutter_appavailability)

A Flutter plugin that allows you to check if an app is installed/enabled, launch an app and get the list of installed apps.

This plugin was inspired by the plugin [AppAvailability for Cordova](https://github.com/ohh2ahh/AppAvailability).

## Getting Started
For help getting started with Flutter, view our online
[documentation](https://flutter.io/).

For help on editing plugin code, view the [documentation](https://flutter.io/developing-packages/#edit-plugin-package).

## Installation
First, add `flutter_appavailability` as a [dependency in your pubspec.yaml file](https://flutter.io/using-packages/).

## Methods available
- `checkAvailability(String uri)`
- `getInstalledApps()` (only for **Android**)
- `isAppEnabled(String uri)` (only for **Android**)
- `launchApp(String uri)`

See the [docs](https://pub.dartlang.org/documentation/flutter_appavailability/latest/).

## Example
Here is a small example flutter app displaying a list of installed apps that you can launch.
```dart
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';

import 'package:flutter_appavailability/flutter_appavailability.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {

  List<Map<String, String>> installedApps;
  List<Map<String, String>> iOSApps = [
    {
      "app_name": "Calendar",
      "package_name": "calshow://"
    },
    {
      "app_name": "Facebook",
      "package_name": "fb://"
    },
    {
      "app_name": "Whatsapp",
      "package_name": "whatsapp://"
    }
  ];


  @override
  void initState() {
    super.initState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> getApps() async {
    List<Map<String, String>> _installedApps;

    if (Platform.isAndroid) {

      _installedApps = await AppAvailability.getInstalledApps();

      print(await AppAvailability.checkAvailability("com.android.chrome"));
      // Returns: Map<String, String>{app_name: Chrome, package_name: com.android.chrome, versionCode: null, version_name: 55.0.2883.91}

      print(await AppAvailability.isAppEnabled("com.android.chrome"));
      // Returns: true

    }
    else if (Platform.isIOS) {
      // iOS doesn't allow to get installed apps.
      _installedApps = iOSApps;

      print(await AppAvailability.checkAvailability("calshow://"));
      // Returns: Map<String, String>{app_name: , package_name: calshow://, versionCode: , version_name: }

    }

    setState(() {
      installedApps = _installedApps;
    });

  }

  @override
  Widget build(BuildContext context) {
    if (installedApps == null)
      getApps();

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin flutter_appavailability app'),
        ),
        body: ListView.builder(
          itemCount: installedApps == null ? 0 : installedApps.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(installedApps[index]["app_name"]),
              trailing: IconButton(
                icon: const Icon(Icons.open_in_new),
                onPressed: () {
                  Scaffold.of(context).hideCurrentSnackBar();
                  AppAvailability.launchApp(installedApps[index]["package_name"]).then((_) {
                    print("App ${installedApps[index]["app_name"]} launched!");
                  }).catchError((err) {
                    Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text("App ${installedApps[index]["app_name"]} not found!")
                    ));
                    print(err);
                  });
                }
              ),
            );
          },
        ),
      ),
    );
  }
}

```

Android:
![screenshot_1536780581](https://user-images.githubusercontent.com/5956938/45448682-48c49e80-b6d3-11e8-8e56-5972b017e233.png)

iOS:
![simulator screen shot - iphone x - 2018-09-12 at 21 27 05](https://user-images.githubusercontent.com/5956938/45448686-4a8e6200-b6d3-11e8-841c-be5b609b8c9b.png)
