// Dart imports:
import 'dart:typed_data';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:device_info_plus/device_info_plus.dart';

// Project imports:
import 'package:da_kanji_mobile/globals.dart';


/// Returns a String containing details about the device the app is running on
Future<String> getDeviceInfoText(BuildContext context) async {
  Map<String, dynamic> t = (await DeviceInfoPlugin().deviceInfo).data;

  // ignore: use_build_context_synchronously
  String deviceInfo = """System / App info:\nI am using DaKanji v.$g_Version on ${Theme.of(context).platform.name}.

    ${t.toString().replaceAll(",", "\n").replaceAll("}", "").replaceAll("{", "")}
    """;

  return deviceInfo;
}
