import 'dart:collection';

import 'package:fullwidth_halfwidth_converter/fullwidth_halfwidth_converter.dart';
import 'package:kana_kit/kana_kit.dart';
import 'package:language_processing/japanese/conjugation/yomitan_deconjugate.dart';
import 'package:language_processing/japanese/japanese_string_operations.dart';



/// Preprocesses the input term for searching.
/// Standardize full-width / half-width
///   * For kana everything is converted to full-width
///   * For romaji everything is converted to half-width
/// and optionally converts romaji to hiragana (if `convertRomajiToHiragana` is
/// true).
/// 
/// Returns a tuple containing:
/// - `hiraganaTerm`: The hiragana conversion of the term if romaji conversion
///    was performed, otherwise null.
/// - `processedTerms`: A list of processed terms
({List<String> normalizedTerms, List<DeconjugationResult> termVariants}) preprocessInput(String searchTerm, bool convertRomajiToHiragana) {

  if(searchTerm == "") return (normalizedTerms: [], termVariants: []);

  // 1. convert full-width romaji to half-width and half-width kana to full-width
  String normalizedTerm = searchTerm.toFullwidth(convertKana: true);
  normalizedTerm = normalizedTerm.toHalfwidth(
    convertAlphabet: true, convertNumber: true, convertSymbol: true);

  // 2. convert all kana to hiragana
  normalizedTerm = katakanaToHiragana(normalizedTerm);

  // 3. convert romaji to kana
  String? romajiToHiraganaResult;
  if(convertRomajiToHiragana) {
    romajiToHiraganaResult = romajiToHiragana(normalizedTerm);
  }
  
  // Only set hiraganaTerm if the result contains ONLY Japanese characters
  List<String> normalizedTerms = [normalizedTerm];
  if (romajiToHiraganaResult != null && KanaKit().isJapanese(romajiToHiraganaResult)) {
    normalizedTerms = generateNMoraVariants(romajiToHiraganaResult)..add(romajiToHiraganaResult);
    print(normalizedTerms);
  }

  // 4. find all possible deconjugations of the hiragana term
  Iterable<String>? deconjugate = [searchTerm, normalizedTerm].nonNulls;
  
  List<DeconjugationResult>? termVariants;
  for (String d in deconjugate) {
    JapaneseDeconjugator deconjugator = JapaneseDeconjugator();
    termVariants = deconjugator.deconjugate(d)
      .where((e) =>
        e.deconjugatedTerm != d // filter out the input term itself
        && e.deconjugatedTerm != normalizedTerm // filter out the hiragana term if applicable
        && e.deconjugatedTerm != searchTerm // filter out the original search term
      )
      .toSet() /// remove duplicates
      .toList();
  }

  return (
    normalizedTerms: normalizedTerms,
    termVariants: termVariants ?? []
  );
}

/// A map to define how 'n-row' characters are split into 'ん' + vowel.
const Map<String, String> _nMoraSplitMap = {
  // Hiragana
  'な': 'んあ', 'に': 'んい', 'ぬ': 'んう', 'ね': 'んえ', 'の': 'んお',
};

/// A map to define how a vowel combines with a preceding 'ん'.
const Map<String, String> _nMoraCombineMap = {
  // Hiragana
  'あ': 'な', 'い': 'に', 'う': 'ぬ', 'え': 'ね', 'お': 'の',
};

/// Generates all possible word variants by combining and splitting the 'ん' (n) mora.
/// 
/// Returns a list of all unique variants, EXCLUDING the original word.
List<String> generateNMoraVariants(String word) {
  if (word.isEmpty) {
    return [];
  }

  // Use a Set to automatically handle duplicate variants.
  final variants = <String>{word};
  // Use a Queue for a breadth-first search of all possible transformations.
  final queue = Queue<String>.from([word]);

  while (queue.isNotEmpty) {
    final currentWord = queue.removeFirst();

    // Iterate through each character position to check for possible transformations.
    for (int i = 0; i < currentWord.length; i++) {
      // --- Rule 1: Splitting Logic ---
      // Check if the character at the current position is an 'n-row' mora.
      final char = currentWord[i];
      if (_nMoraSplitMap.containsKey(char)) {
        final splitMora = _nMoraSplitMap[char]!;
        final newWord =
            currentWord.substring(0, i) + splitMora + currentWord.substring(i + 1);

        // If a new, unique variant is found, add it to the set and the queue to explore it further.
        if (variants.add(newWord)) {
          queue.add(newWord);
        }
      }

      // --- Rule 2: Combining Logic ---
      // Check if the current character is 'ん' and is not the last character.
      if (char == 'ん' && i + 1 < currentWord.length) {
        final nextChar = currentWord[i + 1];
        // Check if the next character is a vowel that can be combined.
        if (_nMoraCombineMap.containsKey(nextChar)) {
          final combinedMora = _nMoraCombineMap[nextChar]!;
          final newWord = currentWord.substring(0, i) +
              combinedMora +
              currentWord.substring(i + 2);

          // If a new, unique variant is found, add it to the set and the queue.
          if (variants.add(newWord)) {
            queue.add(newWord);
          }
        }
      }
    }
  }

  // Remove the original word from the set of variants.
  variants.remove(word);

  return variants.toList();
}