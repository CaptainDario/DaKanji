import 'dart:convert';

import 'package:language_processing/language_processing.dart';
import 'package:unorm_dart/unorm_dart.dart' as unorm;

/// Extracts metadata from Yomitan format 3 audio dictionaries (entries.json).
class AudioEntriesJsonParser {
  static Map<String, ({List<String> terms, String reading, String? pitchPattern})> parseMetadata(
    String jsonString,
    LanguageProcessor lp,
  ) {
    final Map<String, ({List<String> terms, String reading, String? pitchPattern})> fileData = {};
    final List jsonList = jsonDecode(jsonString);

    for (final entry in jsonList) {
      final List<String> kanjis = List<String>.from(entry["kanji"] ?? []);

      for (final accent in entry["accents"] ?? []) {
        final String? soundFile = accent["soundFile"];
        if (soundFile == null) continue;

        final String reading = accent["accent"][0]["pronunciation"];
        final dynamic rawPitch = accent["accent"][0]["pitchAccent"];
        String? pitchString;

        if (rawPitch is String) {
          pitchString = rawPitch;
        } else if (rawPitch is int) {
          try {
            pitchString = lp.parseYomitanPitch({
              'position': rawPitch,
              'reading': unorm.nfc(reading)
            });
          } catch (_) {}
        }

        fileData[soundFile] = (terms: kanjis, reading: reading, pitchPattern: pitchString);
      }
    }
    return fileData;
  }
}