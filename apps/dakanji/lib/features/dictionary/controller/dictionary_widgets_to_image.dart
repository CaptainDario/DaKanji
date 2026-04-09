// Dart imports:
import 'dart:io';
import 'dart:typed_data';

// Flutter imports:
import 'package:da_db/database/db_queries/dictionary_search/dictionary_match.dart';
// Project imports:
import 'package:da_kanji_mobile/features/dictionary/widgets/word_tab/dictionary_word_card_screenshot.dart';
import 'package:flutter/material.dart';
// Package imports:
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';


/// Takes a screeshot of a [DictionaryWordCard] dispalying `entry` and stores
/// this screenshot as a png image with the name `fileName` in the tmp-directory
/// Returns the file in which the image has been stored 
Future<File> dictionaryWordCardToImage(
  BuildContext context,
  DictionaryMatch match,
  String fileName,
  bool includeConjugation,
  ThemeData theme) async {

  late File f;
  final ScreenshotController controller = ScreenshotController();

  // Create an invisible entry in the REAL app overlay
  final OverlayEntry entry = OverlayEntry(
    builder: (context) => Positioned(
      left: -5000, // Safely hidden off-screen so the user never sees it
      top: 0,
      child: Screenshot(
        controller: controller,
        child: DictionaryWordCardScreenshot(match, includeConjugation, theme),
      ),
    ),
  );

  // Insert it into the actual widget tree and capture there
  Overlay.of(context).insert(entry);
  await Future.delayed(const Duration(milliseconds: 1000));
  final Uint8List? value = await controller.capture(pixelRatio: 3);

  // Clean up the invisible widget and share the image
  entry.remove();
  if (value != null) {
    Directory tmp = await getTemporaryDirectory();
    f = File("${tmp.path}/$fileName")..createSync();
    f.writeAsBytesSync(value);
  }

  return f;
}