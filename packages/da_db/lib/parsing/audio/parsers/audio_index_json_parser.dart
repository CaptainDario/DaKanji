import 'dart:convert';

import 'package:language_processing/language_processing.dart';
import 'package:unorm_dart/unorm_dart.dart' as unorm;

/// Extracts metadata from format 2 audio dictionaries (index.json).
class AudioIndexJsonParser {
  static Map<String, ({List<String> terms, String reading, String? pitchPattern})> parseMetadata(
    String jsonString,
    LanguageProcessor lp,
  ) {
    final Map<String, ({List<String> terms, String reading, String? pitchPattern})> fileData = {};
    final Map jsonMap = jsonDecode(jsonString);

    final headwords = (jsonMap['headwords'] as Map).map((k, v) => MapEntry(k, List<String>.from(v)));
    final files = (jsonMap["files"] as Map).map((k, v) => MapEntry(k, Map<String, String>.from(v)));

    headwords.forEach((headword, fileList) {
      for (final file in fileList) {
        if (!files.containsKey(file)) continue;

        final String reading = files[file]!["kana_reading"] ?? "";
        final String? pitchStr = files[file]!["pitch_number"];
        String? pitchString;

        if (pitchStr != null && reading.isNotEmpty) {
          final int? pitchInt = int.tryParse(pitchStr);
          if (pitchInt != null) {
            try {
              pitchString = lp.parseYomitanPitch({
                'position': pitchInt,
                'reading': unorm.nfc(reading)
              });
            } catch (_) {}
          }
        }

        fileData[file] = (terms: [headword], reading: reading, pitchPattern: pitchString);
      }
    });
    return fileData;
  }
}