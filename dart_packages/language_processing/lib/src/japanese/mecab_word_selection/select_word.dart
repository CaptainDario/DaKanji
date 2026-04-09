import 'package:kana_kit/kana_kit.dart';
import 'package:language_processing/src/japanese/mecab/unidic_fields.dart';
import 'package:language_processing/src/japanese/mecab_text_processing/mecab_process_text.dart';
import 'package:language_processing/src/parse_result.dart';
import 'package:mecab_for_dart/mecab_dart.dart';



/// Processes the given [text] with MeCab and groups compound words.
///
/// Returns a [ParseResult] containing aligned lists of segments (surfaces), 
/// tokens (base forms), phonetic readings, and POS tags.
ParseResult processText(String text, Mecab mecab, KanaKit kanaKit) {
  
  // Fast exit for empty or whitespace-only strings
  if (text.isEmpty) return ParseResult();
  if (text.trim().isEmpty) {
    return ParseResult(
      surfaces: [text], 
      tokens: [text], 
      readings: [" "], 
      pos: [[]]
    );
  }

  // Split the text by newline as MeCab does not retain formatting natively
  List<String> subTexts = text.split("\n");

  final segments = <String?>[];
  final tokens = <String?>[];
  final readings = <String?>[];
  final pos = <List<String?>>[];

  for (int j = 0; j < subTexts.length; j++) {
    List<TokenNode> analyzedText = mecab.parse(subTexts[j]);
    
    if (analyzedText.isNotEmpty) analyzedText.removeLast(); // Remove EOS

    for (var i = 0; i < analyzedText.length; i++) {
      
      // Handle parsing failures or empty nodes safely
      if (analyzedText[i].features.isEmpty) {
        segments.add("　"); 
        tokens.add("　");
        readings.add(" "); 
        pos.add([]);
        continue;
      }

      // Group tokens into maximum length logical words
      List<TokenNode> maxLengthWord = selectMaxLengthWord(analyzedText.sublist(i));
      
      // 1. Segments: The exact surface text
      segments.add(maxLengthWord.map((e) => e.surface).join());
      
      // 2. Tokens: The uninflected base forms combined
      String combinedToken = "";
      for (var node in maxLengthWord) {
        if (node.features.length > UniDicFields.orthBase && node.features[UniDicFields.orthBase] != '*') {
          combinedToken += node.features[UniDicFields.orthBase];
        } else {
          combinedToken += node.surface; // Fallback to surface
        }
      }
      tokens.add(combinedToken);

      // 3. POS tags
      pos.add(posFromTokeNodes(maxLengthWord));
      
      // 4. Readings: Decide if furigana should be shown
      if (!kanaKit.isJapanese(analyzedText[i].surface) ||
          kanaKit.isKana(analyzedText[i].surface) ||
          analyzedText[i].features.length <= UniDicFields.pron ||
          analyzedText[i].features[UniDicFields.pron] == analyzedText[i].surface ||
          analyzedText[i].features[UniDicFields.pron] == '*') {
        readings.add(" ");
      } else {
        // Concatenate the pronunciation for the entire compound word
        String fullReading = "";
        for (var k = 0; k < maxLengthWord.length; k++) {
          final featureList = analyzedText[i + k].features;
          if (featureList.length > UniDicFields.pron && featureList[UniDicFields.pron] != '*') {
            fullReading += featureList[UniDicFields.pron];
          } else {
            fullReading += analyzedText[i + k].surface; // Fallback to surface
          }
        }
        readings.add(fullReading); 
      }
      
      // Skip ahead the number of tokens just grouped
      i += maxLengthWord.length - 1;
    }

    // Re-inject the newline character if this isn't the last line
    if (j != subTexts.length - 1) {
      segments.add("\n"); 
      tokens.add("\n");
      readings.add(""); 
      pos.add([]);
    }
  }

  return ParseResult(
    surfaces: segments,
    tokens: tokens,
    readings: readings,
    pos: pos
  );
}