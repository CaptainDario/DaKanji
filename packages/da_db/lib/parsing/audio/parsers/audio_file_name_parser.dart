import 'package:language_processing/language_processing.dart';
import 'package:unorm_dart/unorm_dart.dart' as unorm;

/// Extracts metadata directly from an audio file's name.
class AudioFileNameParser {
  static final RegExp _pattern = RegExp(r'^(.+?)(?:\s*[\[【](.+?)[\]】])?(?:\s*[\(（]([a-zA-Z0-9]+)[\)）])?$');

  static ({List<String> terms, String? reading, String? pitchPattern}) parseFileName(
    String cleanName,
    LanguageProcessor lp,
  ) {
    final Match? match = _pattern.firstMatch(cleanName);
    
    if (match == null) {
      return (terms: [cleanName], reading: null, pitchPattern: null);
    }

    final String term = unorm.nfc(match.group(1)!.trim());
    final String? reading = match.group(2)?.trim() != null
      ? unorm.nfc(match.group(2)!.trim())
      : null;
    final String? rawPitch = match.group(3)?.trim();
    String? pitchString;

    if (rawPitch != null) {
      final int? pitchInt = int.tryParse(rawPitch);
      if (pitchInt != null) {
        try {
          pitchString = lp.parseYomitanPitch({
            'position': pitchInt,
            'reading': reading ?? term
          });
        } catch (_) {}
      } else if (pitchInt == null) {
        pitchString = rawPitch.toUpperCase();
      }
    }

    return (terms: [term], reading: reading, pitchPattern: pitchString);
  }
}