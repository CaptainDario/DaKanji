// Dart imports:
import 'dart:typed_data';

// Package imports:
import 'package:path_provider/path_provider.dart';
import 'package:universal_io/io.dart';


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
