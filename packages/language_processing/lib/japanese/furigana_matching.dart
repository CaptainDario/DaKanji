
import 'package:kana_kit/kana_kit.dart';

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
  if (text.trim().isEmpty) return [FuriganaPair("", reading)];
  if (reading.trim().isEmpty) return [FuriganaPair("", text)];

  const k = KanaKit();
  List<FuriganaPair> result = [];
  final kanjiRegex = RegExp(r'[\u4e00-\u9faf\u3005]');

  // 1. Handle conversions upfront so indices align perfectly
  if (convertToKatakana) {
    text = k.toKatakana(text);
    reading = k.toKatakana(reading);
  }

  FuriganaPair currentPair = FuriganaPair("", "");
  int readingIndex = 0;
  int i = 0;

  while (i < text.length) {
    String char = text[i];

    // CASE 1: Kanji -> Buffer it
    if (kanjiRegex.hasMatch(char)) {
      currentPair.kanji += char;
      i++;
    } 
    // CASE 2: Kana / Non-Kanji -> Match against reading
    else {
      // Normalize to Hiragana only for the search (handles Kata vs Hira mismatch)
      String charHira = k.toHiragana(char);
      String readingHira = k.toHiragana(reading);
      
      int kanaIdx = readingHira.indexOf(charHira, readingIndex);

      // Edge Case: Ambiguous Double Vowel (e.g. "I-I-Kata")
      if (kanaIdx == readingIndex && currentPair.kanji.isNotEmpty) {
         int nextIdx = readingHira.indexOf(charHira, readingIndex + 1);
         if (nextIdx != -1) kanaIdx = nextIdx;
      }

      if (kanaIdx != -1) {
        // A. Flush the buffered Kanji (if any)
        // Assign the reading skipped so far to the Kanji
        currentPair.reading = reading.substring(readingIndex, kanaIdx);
        if (currentPair.kanji.isNotEmpty) {
           result.add(currentPair);
        }
        
        // B. Prepare the Non-Kanji Pair
        // STRICT RULE: Kanji field must be empty
        currentPair = FuriganaPair("", ""); 
        readingIndex = kanaIdx;

        // C. Match the continuous Kana segment
        while (i < text.length &&
            readingIndex < reading.length &&
            k.toHiragana(text[i]) == k.toHiragana(reading[readingIndex])) {
          
          // Add to READING field (because it is not Kanji)
          // Use text[i] (Original) to preserve Katakana/Hiragana distinction
          currentPair.reading += text[i];
          
          i++; 
          readingIndex++;
        }
        
        // D. Add the Non-Kanji pair
        result.add(currentPair);
        currentPair = FuriganaPair("", "");
      } else {
        // Fallback: Non-matching char (symbols, etc)
        // Add to reading to keep Kanji field strict
        currentPair.reading += char;
        i++;
      }
    }
  }

  // Final Flush
  if (currentPair.kanji.isNotEmpty || readingIndex < reading.length) {
    currentPair.reading += reading.substring(readingIndex);
    result.add(currentPair);
  }

  return result;
}