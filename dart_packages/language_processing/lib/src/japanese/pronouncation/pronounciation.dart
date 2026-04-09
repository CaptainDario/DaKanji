import 'package:characters/characters.dart';


/// Set of small combining kana (yōon and small vowels) used to calculate morae.
const Set<String> smallCombiningKana = {
  'ゃ', 'ゅ', 'ょ', 'ぁ', 'ぃ', 'ぅ', 'ぇ', 'ぉ',
  'ャ', 'ュ', 'ョ', 'ァ', 'ィ', 'ゥ', 'ェ', 'ォ',
};

/// Parses pitch accent data from a Yomitan dictionary entry.
///
/// Extracts the pitch pattern from the provided [input] map. If the dictionary
/// provides an exact string pattern (e.g., "LHLL"), it returns it directly.
/// If it provides an integer downstep position, it converts it to an "H/L" string
/// based on standard Japanese pitch accent rules.
///
/// Throws an [ArgumentError] if the input is malformed or missing required keys.
String parseYomitanPitch(dynamic input) {
  if (input is! Map<String, dynamic>) {
    throw ArgumentError('Japanese parseYomitanPitch requires a Map<String, dynamic>.');
  }

  final rawPosition = input['position'];
  final String? reading = input['reading'];

  if (reading == null) {
    throw ArgumentError('Japanese parseYomitanPitch requires a non-null "reading" key.');
  }

  if (rawPosition is String) {
    return rawPosition;
  } else if (rawPosition is int) {
    return generatePitchPatternString(reading, rawPosition);
  } else {
    throw ArgumentError('Invalid pitch position type: $rawPosition');
  }
}

/// Splits a Japanese reading string into a list of constituent morae.
///
/// Combines standard kana with following small combining kana (e.g., "きゃ"
/// becomes a single mora) to ensure accurate pitch accent alignment.
List<String> convertToMoraList(String reading) {
  List<String> moraList = [];
  final runes = reading.characters.toList();

  for (int i = 0; i < runes.length; i++) {
    final String char = runes[i];

    if (i + 1 < runes.length && smallCombiningKana.contains(runes[i + 1])) {
      moraList.add(char + runes[i + 1]);
      i++; 
    } else {
      moraList.add(char);
    }
  }
  return moraList;
}

/// Generates an "H/L" pitch pattern string from a reading and an integer downstep position.
///
/// Maps standard Japanese pitch accent paradigms to a literal High/Low string representation:
/// * 0: 平板 (Heiban)
/// * 1: 頭高 (Atamadaka)
/// * >1: 中高 (Nakadaka)
/// * ==Length: 尾高 (Odaka)
String generatePitchPatternString(String reading, int pitchPosition) {
  List<String> mora = convertToMoraList(reading);
  StringBuffer pattern = StringBuffer();

  for (int at = 0; at < mora.length; at++) {
    // 平板 (Heiban)
    if(pitchPosition == 0){
      if(at == 0) {
        pattern.write('L');
      } else {
        pattern.write('H');
      }
    }
    // 頭高 (Atamadaka)
    else if(pitchPosition == 1 && 1 < mora.length){
      if(at == 0) {
        pattern.write('H');
      } else {
        pattern.write('L');
      }
    }
    // 中高 (Nakadaka)
    else if(1 < pitchPosition && pitchPosition < mora.length){
      if(at == 0){
        pattern.write('L');
      }
      else if (0 < at && at < pitchPosition-1){
        pattern.write('H');
      }
      else if (at == pitchPosition-1){
        pattern.write('H');
      }
      else {
        pattern.write('L');
      }
    }
    // 尾高 (Odaka)
    else if(pitchPosition == mora.length){
      if(at == 0){
        if(mora.length == 1) {
          pattern.write('H');
        } else {
          pattern.write('L');
        }
      }
      else if(0 < at && at < mora.length-1) {
        pattern.write('H');
      } else if(at == mora.length-1) {
        pattern.write('H');
      } else {
        pattern.write('L');
      }
    }
    else {
      throw Exception("Invalid pitch accent");
    }
  }

  return pattern.toString();
}