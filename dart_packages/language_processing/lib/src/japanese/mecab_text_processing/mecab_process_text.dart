import 'package:language_processing/src/japanese/mecab/unidic_fields.dart';
import 'package:language_processing/src/japanese/mecab/unidic_strings.dart';
import 'package:mecab_for_dart/mecab_dart.dart';



/// Finds and returns the maximum length word starting from the first element of [mecabTokens].
///
/// Combines base words with their conjugations, suffixes, and inflection-dependent
/// auxiliary words. Returns a list containing the combined [TokenNode]s.
List<TokenNode> selectMaxLengthWord(List<TokenNode> mecabTokens) {
  if (mecabTokens.isEmpty) return [];
  
  List<TokenNode> nodes = [mecabTokens.first];
  if (mecabTokens.length == 1) return nodes;

  int i = 1;

  // 1. Join conjugations (Check cType index)
  while (mecabTokens.first.features.length > UniDicFields.cType && 
         mecabTokens[i].features.length > UniDicFields.cType &&
         mecabTokens.first.features[UniDicFields.cType] != "*" && 
         mecabTokens[i].features[UniDicFields.cType] != "*") {
    
    nodes.add(mecabTokens[i]);
    if (++i == mecabTokens.length) return nodes;
  }

  // 2. Add suffixes and specific inflection-dependent words (e.g., な)
  while (mecabTokens[i].features.isNotEmpty &&
        (mecabTokens[i].features[UniDicFields.pos1] == UnidicStrings.suffix ||
        (mecabTokens[i].features[UniDicFields.pos1] == UnidicStrings.inflectionDependentWord &&
         mecabTokens[i].surface == "な"))) {
         
    nodes.add(mecabTokens[i]);
    if (++i == mecabTokens.length) return nodes;
  }

  return nodes;
}

/// Determines the primary Part of Speech (POS) tags for a combined list of [nodes].
///
/// Specifically looks for edge-cases like Na-adjectives (`形状詞`) and words 
/// that can act as Na-adjectives (`形状詞可能`). Returns up to 4 POS string tags.
List<String> posFromTokeNodes(List<TokenNode> nodes) {
  if (nodes.isEmpty) return [];

  bool naAdjectivePossible = false;

  for (var node in nodes) {
    for (var feature in node.features) {
      
      // Words that are definitively na-adjectives
      if (feature.contains(UnidicStrings.naAdjective) &&
          !feature.contains(UnidicStrings.naAdjectivePossibility)) {
        return [UnidicStrings.naAdjective];
      }
      
      // Words that have the potential to be na-adjectives, followed by "な"
      if (naAdjectivePossible && node.surface == "な") {
        return [UnidicStrings.naAdjective];
      }
      
      if (feature.contains(UnidicStrings.naAdjectivePossibility)) {
        naAdjectivePossible = true;
      }
    }
  }

  // Fallback: safely return up to the first 4 POS tags of the root word
  final rootFeatures = nodes.first.features;
  final posCount = rootFeatures.length < 4 ? rootFeatures.length : 4;
  return rootFeatures.sublist(0, posCount);
}