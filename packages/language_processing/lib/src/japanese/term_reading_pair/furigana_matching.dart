
import 'package:kana_kit/kana_kit.dart';
import 'package:language_processing/src/term_reading_pair.dart';

List<TermReadingPair> matchFurigana(
  String text, String reading, {bool convertToKatakana = false}) {
    if (text.trim().isEmpty) return [TermReadingPair("", reading)];
    if (reading.trim().isEmpty) return [TermReadingPair("", text)];

  const k = KanaKit();
  List<TermReadingPair> result = [];
  final kanjiRegex = RegExp(r'[\u4e00-\u9faf\u3005]');

  // 1. Handle conversions upfront so indices align perfectly
  if (convertToKatakana) {
    text = k.toKatakana(text);
    reading = k.toKatakana(reading);
  }

  TermReadingPair currentPair = TermReadingPair("", "");
  int readingIndex = 0;
  int i = 0;

  while (i < text.length) {
    String char = text[i];

    // CASE 1: Kanji -> Buffer it
    if (kanjiRegex.hasMatch(char)) {
      currentPair.term += char;
      i++;
    } 
    // CASE 2: Kana / Non-Kanji -> Match against reading
    else {
      // Normalize to Hiragana only for the search (handles Kata vs Hira mismatch)
      String charHira = k.toHiragana(char);
      String readingHira = k.toHiragana(reading);
      
      int kanaIdx = readingHira.indexOf(charHira, readingIndex);

      // Edge Case: Ambiguous Double Vowel (e.g. "I-I-Kata")
      if (kanaIdx == readingIndex && currentPair.term.isNotEmpty) {
         int nextIdx = readingHira.indexOf(charHira, readingIndex + 1);
         if (nextIdx != -1) kanaIdx = nextIdx;
      }

      if (kanaIdx != -1) {
        // A. Flush the buffered Kanji (if any)
        // Assign the reading skipped so far to the Kanji
        currentPair.reading = reading.substring(readingIndex, kanaIdx);
        if (currentPair.term.isNotEmpty) {
           result.add(currentPair);
        }
        
        // B. Prepare the Non-Kanji Pair
        // STRICT RULE: Kanji field must be empty
        currentPair = TermReadingPair("", ""); 
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
        currentPair = TermReadingPair("", "");
      } else {
        // Fallback: Non-matching char (symbols, etc)
        // Add to reading to keep Kanji field strict
        currentPair.reading += char;
        i++;
      }
    }
  }

  // Final Flush
  if (currentPair.term.isNotEmpty || readingIndex < reading.length) {
    
    // If readings are left over, but NO Kanji to attach it to,
    // it means the input is mismatched
    // --> Return the entire original text and reading as one block.
    if (currentPair.term.isEmpty && readingIndex < reading.length) {
      return [TermReadingPair(text, reading)];
    }

    currentPair.reading += reading.substring(readingIndex);
    result.add(currentPair);
  }

  return result;

}