// Dart imports:
import 'dart:typed_data';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:device_info_plus/device_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:universal_io/io.dart';

// Project imports:
import 'package:da_kanji_mobile/globals.dart';

/// Saves the given Uint8List to the temporary directory of the device and 
/// returns the path to the file
Future<String> writeImageToTmpStorage(Uint8List image) async {
  final Directory output = await getTemporaryDirectory();
  final String screenshotFilePath = '${output.path}/feedback.png';
  final File screenshotFile = File(screenshotFilePath);
  await screenshotFile.writeAsBytes(image);
  return screenshotFilePath;
}

/// Saves the given String to the temporary directory of the device and 
/// returns the path to the file
Future<String> writeTextToTmpStorage(String text, String fileName) async {
  final Directory output = await getTemporaryDirectory();
  final String textFilePath = '${output.path}/$fileName.txt';
  final File screenshotFile = File(textFilePath);
  await screenshotFile.writeAsString(text);
  return textFilePath;
}

/// Returns a String containing details about the system the app is running on
Future<String> getDeviceInfoText(BuildContext context) async {
  Map<String, dynamic> t = (await DeviceInfoPlugin().deviceInfo).data;

  // ignore: use_build_context_synchronously
  String deviceInfo = """System / App info:\nI am using DaKanji v.$g_Version on ${Theme.of(context).platform.name}.

    ${t.toString().replaceAll(",", "\n").replaceAll("}", "").replaceAll("{", "")}
    """;

  return deviceInfo;
}
