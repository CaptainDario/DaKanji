import 'dart:typed_data';
import 'package:flutter/material.dart';

import 'package:feedback_sentry/feedback_sentry.dart';
import 'package:universal_io/io.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:path_provider/path_provider.dart';

import 'package:da_kanji_mobile/globals.dart';



/// Opens an overlay to share feedback 
void sendFeedback(BuildContext context) {

  BetterFeedback.of(context).showAndUploadToSentry(

  );

  /*BetterFeedback.of(context).show((UserFeedback feedback) async {
      
    final screenshotFilePath = await writeImageToTmpStorage(feedback.screenshot);
    final textFilePath = await writeTextToTmpStorage(await getDeviceInfoText(context), "deviceInfo");
    final logsFilePath = await writeTextToTmpStorage(g_appLogs, "logs");

    String feedbackText = "Send to: daapplab\n" + feedback.text;
    String feedbackSubject = "DaKanji $g_Version - feedback";

    await Share.shareXFiles(
      [XFile(screenshotFilePath), XFile(textFilePath), XFile(logsFilePath)],
      text: Platform.isWindows ? feedbackSubject : feedbackText,
      subject: Platform.isWindows ? feedbackText : feedbackSubject,
      sharePositionOrigin: () {
        RenderBox? box = context.findRenderObject() as RenderBox?;
        return Rect.fromLTRB(0, 0, box!.size.height/2, box.size.width/2);
      } (),
    );
  });*/
}

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
  final String textFilePath = '${output.path}/${fileName}.txt';
  final File screenshotFile = File(textFilePath);
  await screenshotFile.writeAsString(text);
  return textFilePath;
}

/// Returns a String containing details about the system the app is running on
Future<String> getDeviceInfoText(BuildContext context) async {
  Map<String, dynamic> t = (await DeviceInfoPlugin().deviceInfo).data;

  String deviceInfo = """System / App info:
    I am using DaKanji v.$g_Version on ${Theme.of(context).platform.name}.

    ${t.toString().replaceAll(",", "\n").replaceAll("}", "").replaceAll("{", "")}
    """;

  return deviceInfo;
}