import 'package:kana_kit/kana_kit.dart';
import 'package:language_processing/src/japanese/mecab/unidic_fields.dart';
import 'package:language_processing/src/japanese/mecab/unidic_strings.dart';
import 'package:language_processing/src/japanese/mecab_text_processing/mecab_process_text.dart';
import 'package:mecab_for_dart/mecab_dart.dart';



/// Extracts all constituent parts of the given [word] and attempts to deconjugate them.
///
/// Returns a list of unique, deconjugated string variations. If the input is not 
/// recognized as Japanese, it returns an empty list.
List<String> getDeconjugatedTerms(String word, Mecab mecab) {
  KanaKit kanaKit = const KanaKit();
  List<List<String>> deconjugations = [];

  // Fast exit: Is a valid Japanese word given?
  if (word.isEmpty || !kanaKit.isJapanese(word)) return [];

  // Parse using MeCab and remove the EOS (End of Sentence) token
  List<TokenNode> nodes = mecab.parse(word)..removeLast();
  
  if (nodes.isEmpty) return [];

  // Group conjugations and suffixes into a single logical word
  List<TokenNode> maxLengthWord = selectMaxLengthWord(nodes);

  for (int i = maxLengthWord.length - 1; i >= 0; i--) {
    final features = maxLengthWord[i].features;
    
    // Ensure sufficient features exist to safely access orthBase and lemma
    if (features.length <= UniDicFields.orthBase) continue;

    // Deconjugate the full word by only modifying the ending.
    // Skips inflection-dependent words (e.g., auxiliary verbs like 助動詞)
    if (features[UniDicFields.pos1] != UnidicStrings.inflectionDependentWord) {
      
      if (deconjugations.isEmpty) {
        final orthBase = features[UniDicFields.orthBase];
        final lemma = features[UniDicFields.lemma];

        // If the written base form differs from the dictionary lemma, add both
        if (lemma != orthBase && orthBase != '*') {
          deconjugations.add([orthBase]);
        }
        if (lemma != '*') {
          deconjugations.add([lemma]);
        }
      }
      else {
        // Prepend the current surface text to all existing deconjugation chains
        deconjugations = deconjugations
            .map((List<String> f) => f..insert(0, nodes[i].surface))
            .toList();
      }
    }
  }

  // Flatten, join, and remove duplicates
  return deconjugations.map((e) => e.join()).toSet().toList();
}