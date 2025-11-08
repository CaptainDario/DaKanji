import 'package:kana_kit/kana_kit.dart';

/// String that can be used for Regex that matches any Kana character
const String kanaRegexGroupString = "ぁ-んァ-ン";
/// Regex that matches any Kana character
final RegExp kanaRegex = RegExp("([$kanaRegexGroupString])");
/// String that can be used for Regex that matches any Kanji character
const String kanjiRegexGroupString = "\u4e00-\u9faf\u3400-\u4dbf々";
/// Regex that matches any Kanji character
final RegExp kanjiRegex = RegExp("([$kanjiRegexGroupString])");
/// Regex that matches everything except Japnaese characters ie.: Kanji / Kana
final RegExp japaneseCharacterRegex =
  RegExp("[$kanaRegexGroupString$kanjiRegexGroupString]", multiLine: true);
/// matches full and half width punctuations
const String punctuations = "。|？|！|\\.|\\!|\\?";
/// matches japanese ending parantheses
const String japaneseParantheses = "』|」";
/// matches any whitespace
const String anyWhiteSpace = "\\s|　";
/// Regex that matches a sentence
RegExp sentenceRegex = RegExp(
  "(?:[^$anyWhiteSpace])+?(?:(?!($punctuations)$japaneseParantheses)$punctuations|\\n|\$)",
  multiLine: true
);
/// Regex that matches a paragraph
RegExp paragraphRegex = RegExp(
  r"(.+?):?(\n\n|$)",
  multiLine: false,
  dotAll: true
);
/// Regex that matchs all question marks
RegExp questionMarkRegex = RegExp(r"\?|\﹖|\︖|\？");
/// Regex that matchs all asteriks
RegExp asteriksMarkRegex = RegExp(r"\*|\＊");
/// Regex that matchs all raw wildcards
RegExp rawWildcardRegex = RegExp('${questionMarkRegex.pattern}|${asteriksMarkRegex.pattern}');


/// Given the list of string `words` removes all characters that are not kanji
/// from it and returns a list containing all **unique** kanji
Set<String> extractKanji(List<String> words) {

  Set<String> uniqueKanji = {};

  for (String word in words) {
    for (int i = 0; i < word.length; i++) {
      if(kanjiRegex.hasMatch(word[i])){
        uniqueKanji.add(word[i]);
      }
    }
  }
  
  return uniqueKanji;
}

/// Converts the given `romaji` string to kana
/// 
/// Note:
///   * `N`, `n'`, `n ` -> ん
///   * `-` long vowel mark are converted to double vowels
String romajiToHiragana(String romaji){

  KanaKit kanaKit = KanaKit();

  if(romaji.contains("N")){
    romaji = romaji.replaceAll("N", "ん");
  }
  if(romaji.contains("n ")){
    romaji = romaji.replaceAll("n ", "ん");
  }

  return kanaKit.toHiragana(kanaKit.toKatakana(romaji));
}

/// Converts all katakana in the given `text` string to hiragana
/// Does nothing with non-katakana characters
/// 
/// Note:
///   * `-` long vowel mark are converted to explicit vowels
List<String> katakanaToHiragana(String text, bool convertRomaji) {
  
  List<String> romajiConversionVariants = [text];
  if(convertRomaji){
    romajiConversionVariants = _getAllRomajiConversionVariants(text);
  }
  KanaKit kanaKit = KanaKit(config: KanaKitConfig(
    passRomaji: !convertRomaji,
    passKanji: true,
    upcaseKatakana: false
  ));
  return romajiConversionVariants.toSet()
    .map((e) => kanaKit.toHiragana(kanaKit.toKatakana(e)))
    .where((e) => (kanaKit.isJapanese(e) && convertRomaji) || !convertRomaji)
  .toList();
}

/// Generates all possible variants of `romaji` that will have different results
/// when converted to kana due to the handling of 'n' + vowel such as
/// 'na' -> 'んあ' vs 'な'
List<String> _getAllRomajiConversionVariants(String romaji) {
  final Set<String> variants = {};
  // 'n' is ambiguous before vowels and 'y' (e.g., 'nya' vs 'n'ya')
  final Set<String> ambiguousFollowers = {'a', 'i', 'u', 'e', 'o', 'y'};

  /// Recursive helper to generate combinations.
  /// [index] is the current character we're processing in the original `romaji` string.
  /// [currentVariant] is the string being built so far.
  void generateVariant(int index, String currentVariant) {
    // Base case: We've processed the entire string.
    if (index == romaji.length) {
      variants.add(currentVariant);
      return;
    }

    // Get the character at the current index.
    final String char = romaji[index];

    // Check if this 'n' is ambiguous.
    final bool isAmbiguous = (char == 'n' &&
        index + 1 < romaji.length &&
        ambiguousFollowers.contains(romaji[index + 1]));

    if (isAmbiguous) {
      // --- Branch 1: Don't split (e.g., "na") ---
      // Add the 'n' and move to the next character.
      generateVariant(index + 1, currentVariant + char);

      // --- Branch 2: Split (e.g., "n'a") ---
      // Add "n'" and move to the next character (the vowel/y).
      generateVariant(index + 1, "${currentVariant}n'");
    } else {
      // Not an ambiguous 'n', so just append the current character
      // and continue processing from the next index.
      generateVariant(index + 1, currentVariant + char);
    }
  }

  // Start the recursive generation from the beginning of the string.
  generateVariant(0, "");

  return variants.toList();
}