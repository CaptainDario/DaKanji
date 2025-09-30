import 'dictionary_search_test_helper_classes.dart';



List<SearchTestCase> fuzzySearchTestCases = [

  // Test Case 2: Sorting Fuzzy Matches by Cost
  // This test ensures that fuzzy results are sorted correctly among themselves.
  // A 'ち' -> 'じ' substitution has a cost of 10.
  // A 'にほん' -> 'でんしゃ' substitution has a much higher cost (multiple default substitutions of 100).
  // Therefore, 'にほんじん' should appear first.
  SearchTestCase(
    description: "Fuzzy (Sort Order): Lower cost errors (voiced kana, cost 10) should rank higher than higher cost errors (default substitution, cost 100+)",
    query: "にほんちん",
    termMatches: const ExpectedMatchGroup(
      fuzzyMatches: [
        // 1. Expected: 日本人 (にほんじん)
        // Reason: 'ち' -> 'じ' is a single, low-cost (10) substitution.
        ExpectedSearchResult(
          term: '日本人',
          reading: 'にほんじん',
          definitions: ['Japanese person'],
          match: 'にほんじん',
        ),
        // 2. Expected: 電車賃 (でんしゃちん)
        // Reason: 'にほん' vs 'でんしゃ' has multiple high-cost substitutions.
        // The total distance will be much greater than 10.
        ExpectedSearchResult(
          term: '電車賃',
          reading: 'でんしゃちん',
          definitions: ['train fare'],
          match: 'でんしゃちん',
        ),
      ],
    ),
  ),

  // Tests a common phonetic error defined in your cost table.
  SearchTestCase(
    description: "Fuzzy (match): Long vowel confusion りょこお -> りょこう (Cost 25)",
    query: "りょこお",
    termMatches: const ExpectedMatchGroup(
      fuzzyMatches: [
        ExpectedSearchResult(
          term: '旅行',
          reading: 'りょこう',
          definitions: ['travel; trip'],
          match: 'りょこう',
        ),
      ],
    ),
  ),

  // Tests a common typing mistake involving yōon characters.
  SearchTestCase(
    description: "Fuzzy (match): Small vs large kana でんしや -> でんしゃ (Cost 20)",
    query: "でんしや",
    termMatches: const ExpectedMatchGroup(
      fuzzyMatches: [
        ExpectedSearchResult(
          term: '電車',
          reading: 'でんしゃ',
          definitions: ['(electric) train'],
          match: 'でんしゃ',
        ),
      ],
    ),
    
  ),
];