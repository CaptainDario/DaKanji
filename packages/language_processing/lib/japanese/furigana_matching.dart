
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

  List<FuriganaPair> result = [];

  // Simple Regex for Kanji (approximate range)
  final kanjiRegex = RegExp(r'[\u4e00-\u9faf]'); 

  if (convertToKatakana) {
    KanaKit k = const KanaKit();
    text = k.toKatakana(text);
    reading = k.toKatakana(reading);
  }

  FuriganaPair currentPair = FuriganaPair("", "");
  int readingIndex = 0;
  int i = 0; // Use manual index control

  while (i < text.length) {
    String char = text[i];

    // Case 1: Current character is Kanji -> Buffer it
    if (kanjiRegex.hasMatch(char)) {
      currentPair.kanji += char;
      i++; 
    } 
    // Case 2: Current character is Kana (Okurigana or non-kanji words)
    else {
      // Find where this kana appears in the reading
      int kanaIdx = reading.indexOf(char, readingIndex);
      
      // If we found the kana immediately (kanaIdx == readingIndex) 
      // BUT we have buffered Kanji waiting for a reading, it means 
      // we matched the *first part* of a double vowel (like I-I-Kata).
      // We must search for the *next* occurrence to allow the Kanji to have a reading.
      if (kanaIdx == readingIndex && currentPair.kanji.isNotEmpty) {
         int nextIdx = reading.indexOf(char, readingIndex + 1);
         if (nextIdx != -1) {
           kanaIdx = nextIdx;
         }
      }

      if (kanaIdx != -1) {
        // 1. Assign the reading calculated up to this point to the buffered Kanji
        currentPair.reading = reading.substring(readingIndex, kanaIdx);
        result.add(currentPair);
        
        // 2. Prepare the Okurigana pair
        currentPair = FuriganaPair("", ""); // Reset
        readingIndex = kanaIdx;

        // 3. Match the continuous Kana segment (The Okurigana)
        // Note: We do NOT increment 'i' here for the outer loop yet
        while (i < text.length &&
            readingIndex < reading.length &&
            text[i] == reading[readingIndex]) {
          currentPair.reading += reading[readingIndex];
          i++; 
          readingIndex++;
        }
        
        // 4. Add the Okurigana pair
        result.add(currentPair);
        currentPair = FuriganaPair("", "");
      } else {
        // Fallback: If we can't match the kana, just treat it as part of the Kanji block 
        // (This happens in weird edge cases or typos)
        currentPair.kanji += char;
        i++;
      }
    }
  }

  // Add any leftover reading to the final buffered Kanji
  if (currentPair.kanji.isNotEmpty || readingIndex < reading.length) {
    currentPair.reading += reading.substring(readingIndex);
    result.add(currentPair);
  }

  return result;
}