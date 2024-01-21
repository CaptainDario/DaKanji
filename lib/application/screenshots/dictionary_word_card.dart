// Dart imports:
import 'dart:io';

// Flutter imports:
import 'package:da_kanji_mobile/widgets/dictionary/dictionary_word_card_screenshot.dart';
import 'package:database_builder/database_builder.dart';

// Package imports:
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';



/// Takes a screeshot of a [DictionaryWordCard] dispalying `entry` and stores
/// this screenshot as a png image with the name `fileName` in the tmp-directory
/// Returns the file in which the image has been stored 
Future<File> screenshotDictionaryWordCard(JMdict entry, String fileName, bool includeConjugation) async {

  late File f;

  await ScreenshotController().captureFromLongWidget(
    DictionaryWordCardScreenshot(entry, includeConjugation),
    delay: const Duration(milliseconds: 50)
  ).then((value) async {
    Directory tmp = await getTemporaryDirectory();
    f = await File("${tmp.path}/$fileName").create();
    f.writeAsBytesSync(value);
  });

  return f;
}