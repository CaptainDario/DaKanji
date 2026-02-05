import 'package:dakanji_db_core/parsing/yomitan/in_memory_cache/term/definition_parsing_classes.dart';

final List<ParsedDefinitions> testExpectations = [
  
  // Index 0: test_case_1.json
  ParsedDefinitions(
    posTags: ["noun", "abbr."], 
    definitions: ["chemical engineering"], 
  ),

  // Index 1: test_case_2.json
  ParsedDefinitions(
    definitions: [],
    references: ["⟶囲みを破る"], 
  ),

  // Index 2: test_case_3.json
  ParsedDefinitions(
    posTags: ["exp", "5-dan", "kana"], 
    definitions: [
      "to be highhanded",
      "to be arrogant",
      "to be overbearing"
    ], 
    forms: [
      TermForm("嵩にかかる", "かさにかかる", ""),
      TermForm("嵩に懸かる", "かさにかかる", ""),
      TermForm("笠にかかる", "かさにかかる", ""),
      TermForm("笠に懸かる", "かさにかかる", ""),
    ],
  ),

  // Index 3: test_case_4.json (Spring / 発条)
  ParsedDefinitions(
    posTags: ["noun", "kana",], 
    definitions: [
      "spring",
      "spring (in one's legs)", 
      "bounce", 
      "springboard", 
      "impetus"
    ],
    examples: [
      ExampleSentence(
        "そのばね１個で車の全重量を支えている。", 
        "That one spring carries the whole weight of the car."
      ),
    ],
    forms: [
      // Row 1: Reading {bane}
      TermForm("発条", "｛ばね｝", "優"),
      TermForm("弾機", "｛ばね｝", "可"),
      TermForm("撥条", "｛ばね｝", "稀"),
      TermForm("∅", "｛ばね｝", ""),

      // Row 2: Reading zenmai
      TermForm("発条", "ぜんまい", "可"),
      TermForm("弾機", "ぜんまい", ""),
      TermForm("撥条", "ぜんまい", "稀"),
      TermForm("∅", "ぜんまい", ""),

      // Row 3: Reading hatsujou
      TermForm("発条", "はつじょう", "可"),
      TermForm("弾機", "はつじょう", ""),
      TermForm("撥条", "はつじょう", "稀"),
      TermForm("∅", "はつじょう", ""),

      // Row 4: Reading danki
      TermForm("発条", "だんき", ""),
      TermForm("弾機", "だんき", "可"),
      TermForm("撥条", "だんき", ""),
      TermForm("∅", "だんき", ""),

      // Row 5: Reading BANE (Katakana)
      TermForm("発条", "バネ", ""),
      TermForm("弾機", "バネ", ""),
      TermForm("撥条", "バネ", ""),
      TermForm("∅", "バネ", "可"),
    ],
  ),

  // Index 4: test_case_5.json (Single plain string)
  ParsedDefinitions(
    definitions: [
      "word; vocabulary; (usually) single-character word"
    ], 
  ),

  // Index 5: test_case_6.json (Multiple plain strings)
  ParsedDefinitions(
    definitions: [
      "to run",
      "to travel (movement of vehicles)",
      "to hurry to",
      "to retreat (from battle); to take flight"
    ], 
  ),
];