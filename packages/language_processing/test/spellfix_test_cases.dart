List<({
    String description,
    String word,
    int n,
    int maxCost,
    int? substitutionPenalty,
})> spellfixTestCases = [
  (
    description: 'generates valid variations using real rules (General Sanity Check)',
    // Input: 'あ'
    // Rules allow: 'あ' -> 'ああ' (Category 8, Cost 2)
    word: 'あ',
    n: 10,
    maxCost: 5,
    substitutionPenalty: null,
  ),
  (
    description: 'penalizes high-step paths via substitutionPenalty',
    // Changed input from 'な' to 'た' so valid voicing rules exist.
    //
    // Path 1 (Direct): 'た' -> 'だ' (Cost 4). 
    //    Steps: 1. Total: 4 + (1 * 5) = 9. (<= 10, KEEP)
    //
    // Path 2 (2 Steps): 'た' -> 'たあ' (Cost 2) -> 'たああ' (Cost +2 = 4).
    //    (Using rule 'あ'->'ああ' on the suffix).
    //    Steps: 2. Total: 4 + (2 * 5) = 14. (> 10, PRUNE)
    word: 'た',
    n: 50,
    maxCost: 10,
    substitutionPenalty: 5,
  ),
  (
    description: 'prunes outputs containing forbidden sequences (e.g. ^ん)',
    // Input: 'な'
    // Rule: ('な', 'んあ', 3) exists in Category 11.
    // Output 'んあ' starts with 'ん', which matches forbidden pattern r"^ん".
    word: 'な',
    n: 50,
    maxCost: 5,
    substitutionPenalty: null,
  ),
  (
    description: 'excludes the original word from results (Cycle Pruning)',
    // Input: 'じ'
    // Rules: ('じ', 'ぢ', 1) AND ('ぢ', 'じ', 1) exist.
    // This creates a cycle: じ -> ぢ -> じ.
    word: 'じ',
    n: 50,
    maxCost: 5,
    substitutionPenalty: null,
  ),
  (
    description: 'prunes regex-based forbidden sequences (e.g. triplet vowels)',
    // Input: 'こお'
    // Rule: 'お' -> 'おお' (Cost 2)
    // Result: 'こ' + 'おお' = 'こおお' (Matches triplet regex)
    word: 'こお',
    n: 50,
    maxCost: 5,
    substitutionPenalty: null,
  ),
  (
    description: "食べるらあゆ should not generate 食べるらああゆ",
    word: "食べるらあゆ",
    n: 50,
    maxCost: 10,
    substitutionPenalty: null,
  )
];