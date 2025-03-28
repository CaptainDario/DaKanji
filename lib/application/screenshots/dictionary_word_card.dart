// Dart imports:
import 'dart:io';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:database_builder/database_builder.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';

// Project imports:
import 'package:da_kanji_mobile/widgets/dictionary/dictionary_word_card_screenshot.dart';

/// Takes a screeshot of a [DictionaryWordCard] dispalying `entry` and stores
/// this screenshot as a png image with the name `fileName` in the tmp-directory
/// Returns the file in which the image has been stored 
Future<File> dictionaryWordCardToImage(
  JMdict entry,
  String fileName,
  bool includeConjugation,
  ThemeData theme) async {

  late File f;

  await ScreenshotController().captureFromLongWidget(
    DictionaryWordCardScreenshot(entry, includeConjugation, theme),
    delay: const Duration(milliseconds: 50),
    pixelRatio: 3
  ).then((value) async {
    Directory tmp = await getTemporaryDirectory();
    f = File("${tmp.path}/$fileName")..createSync();
    f.writeAsBytesSync(value);
  });

  return f;
}
