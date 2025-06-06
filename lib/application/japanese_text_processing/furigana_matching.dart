// Package imports:
import 'package:kana_kit/kana_kit.dart';

// Project imports:
import 'package:da_kanji_mobile/application/japanese_text_processing/japanese_string_operations.dart';

/// Simple dataclass that combines a kanji and its reading 
class FuriganaPair {
  String kanji;
  String reading;

  FuriganaPair(this.kanji, this.reading);

  bool isEmpty() => kanji.isEmpty && reading.isEmpty;

  @override
  String toString() => '($kanji, $reading)';
}

List<FuriganaPair> matchFurigana(String text, String reading) {

  // handle edge cases
  if(text.replaceAll(" ", "").isEmpty)    return [FuriganaPair("", reading)];
  if(reading.replaceAll(" ", "").isEmpty) return [FuriganaPair("", text)];

  List<FuriganaPair> result = [];

  KanaKit k = const KanaKit();
  String textKata    = k.toKatakana(text);
  String readingKata = k.toKatakana(reading);

  FuriganaPair currentPair = FuriganaPair("", "");
  int readingIndex = 0;
  for (var i = 0; i < textKata.length; i++) {

    // current character is not a kanji
    if(!kanjiRegex.hasMatch(textKata[i])) {
      // current character is also in reading 
      int kanaIdx = readingKata.indexOf(textKata[i], readingIndex);
      if(kanaIdx != -1){
        // add the kanji with its reading to the result
        currentPair.reading = readingKata.substring(readingIndex, kanaIdx);
        readingIndex = kanaIdx;
        result.add(currentPair); currentPair = FuriganaPair("", "");

        // get all kana only characters
        while (i < text.length && readingIndex < readingKata.length && 
          textKata[i] == readingKata[readingIndex]) {
          currentPair.reading += readingKata[readingIndex];
          i++; readingIndex++;
        }
        result.add(currentPair);
        currentPair = FuriganaPair(i < text.length ? text[i] : "", "");
      }
    }
    else {
      currentPair.kanji += textKata[i];
    }

  }
  // add all leftover readings to kanji
  if(!currentPair.isEmpty()) {
    currentPair.reading += readingKata.substring(readingIndex);
    result.add(currentPair);
  }

  return result;
}

