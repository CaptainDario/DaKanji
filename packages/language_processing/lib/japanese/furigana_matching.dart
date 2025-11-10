
import 'package:kana_kit/kana_kit.dart';

import 'japanese_string_operations.dart';

/// Simple dataclass that combines a kanji and its reading 
class FuriganaPair{

  /// The kanji character(s)
  String kanji;
  /// The reading of `kanji` in kana
  String reading;


  FuriganaPair(this.kanji, this.reading);



  bool isEmpty() => kanji.isEmpty && reading.isEmpty;

  @override
  String toString() => '($kanji, $reading)';

  @override
  bool operator ==(Object other) =>
    identical(this, other) ||
    other is FuriganaPair &&
    runtimeType == other.runtimeType &&
    kanji == other.kanji &&
    reading == other.reading;

  @override
  int get hashCode => kanji.hashCode ^ reading.hashCode;
}

List<FuriganaPair> matchFurigana(String text, String reading, {bool convertToKatakana = false}) {

  // handle edge cases
  if(text.replaceAll(" ", "").isEmpty)    return [FuriganaPair("", reading)];
  if(reading.replaceAll(" ", "").isEmpty) return [FuriganaPair("", text)];

  List<FuriganaPair> result = [];

  if(convertToKatakana) {
    KanaKit k = const KanaKit();
    text    = k.toKatakana(text);
    reading = k.toKatakana(reading);
  }

  FuriganaPair currentPair = FuriganaPair("", "");
  int readingIndex = 0;
  for (var i = 0; i < text.length; i++) {

    // current character is not a kanji
    if(!kanjiRegex.hasMatch(text[i])) {
      // current character is also in reading 
      int kanaIdx = reading.indexOf(text[i], readingIndex);
      if(kanaIdx != -1){
        // add the kanji with its reading to the result
        currentPair.reading = reading.substring(readingIndex, kanaIdx);
        readingIndex = kanaIdx;
        result.add(currentPair); currentPair = FuriganaPair("", "");

        // get all kana only characters
        while (i < text.length && readingIndex < reading.length && 
          text[i] == reading[readingIndex]) {
          currentPair.reading += reading[readingIndex];
          i++; readingIndex++;
        }
        result.add(currentPair);
        currentPair = FuriganaPair(i < text.length ? text[i] : "", "");
      }
    }
    else {
      currentPair.kanji += text[i];
    }

  }
  // add all leftover readings to kanji
  if(!currentPair.isEmpty()) {
    currentPair.reading += reading.substring(readingIndex);
    result.add(currentPair);
  }

  return result;
}

