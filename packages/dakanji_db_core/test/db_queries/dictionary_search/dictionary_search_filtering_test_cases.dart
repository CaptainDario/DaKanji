import 'dictionary_search_test_helper_classes.dart';



List<DictionarySearchTestCase> tagFilteringTestCases = [

  DictionarySearchTestCase(
    description: "by single tag (DE)",
    query: '人',
    tags: ['DE'],
    queryMatches: const ExpectedMatchGroup(
      tokenMatches: [
        [
          ExpectedDictionaryMatch(term: 'ドイツ人', reading: 'どいつじん', match: 'ドイツ人', definitions: ["Eine deutsche Person"]),
        ]
      ],
    ),
  ),

  DictionarySearchTestCase(
    description: "multiple tags (Japanese and Rare)",
    query: '電車',
    tags: ['JP', 'R'],
    queryMatches: const ExpectedMatchGroup(
      tokenMatches: [
        [
          ExpectedDictionaryMatch(term: '満員電車', reading: 'まんいんでんしゃ', match: '満員電車', definitions: ["crowded train; packed train"]),
        ]
      ],
    ),
  ),

  DictionarySearchTestCase(
    description: "No matches due to tag filtering",
    query: '人',
    tags: ['FR'],
  ),

  DictionarySearchTestCase(
    description: "No tag filtering (empty tag list)",
    query: '人',
    tags: [],
    queryMatches: const ExpectedMatchGroup(
      exactMatches: [
        [ExpectedDictionaryMatch(term: '人', reading: 'じん', match: '人', definitions: ["Person"])]
      ],
      tokenMatches: [
        [ExpectedDictionaryMatch(term: '中国人', reading: 'ちゅうごくじん', match: '中国人', definitions: ["Chinese person"])],
        [ExpectedDictionaryMatch(term: '日本人', reading: 'にほんじん', match: '日本人', definitions: ["Japanese person"])],
        [ExpectedDictionaryMatch(term: 'ドイツ人', reading: 'どいつじん', match: 'ドイツ人', definitions: ["Eine deutsche Person"])]
      ],
    ),
  ),
  DictionarySearchTestCase(
    description: "Filter by single tag (DE) on wildcard search",
    query: '*人',
    tags: ['DE'],
    queryMatches: const ExpectedMatchGroup(
      wildcardMatches: [
        [
          ExpectedDictionaryMatch(term: 'ドイツ人', reading: 'どいつじん', match: 'ドイツ人', definitions: ["Eine deutsche Person"]),
        ]
      ],
    ),
  ),

  // --- PoS -------------------------------------------------------------------

    DictionarySearchTestCase(
    description: "Only nouns should be found",
    query: "食べる",
    pos: ["n"],
    queryMatches: const ExpectedMatchGroup(
      prefixMatches: [
        [
          ExpectedDictionaryMatch(
            term: '食べるラー油',
            reading: 'たべるらーゆ',
            definitions: ['chili oil with garlic, etc. for eating with rice'],
            match: '食べるラー油',
          ),
        ]
      ]
    ),
  ),

  // --- Term/Reading/Definition -----------------------------------------------

  DictionarySearchTestCase(
    description: "Filter by term",
    query: '?t=会社',

    queryMatches: const ExpectedMatchGroup(
      exactMatches: [
        [ExpectedDictionaryMatch(term: '会社', reading: '', match: '会社', definitions: ["Company (term)"])],
        [ExpectedDictionaryMatch(term: '会社', reading: '', match: '会社', definitions: ["かいしゃ (reading in definition)"])],
        [ExpectedDictionaryMatch(term: '会社', reading: 'かいしゃ', match: '会社', definitions: ["company (term+reading+definition)"]),]
      ],
    ),
  ),
  DictionarySearchTestCase(
    description: "Filter by term + reading",
    query: '?t=会社&r=かいしゃ',

    queryMatches: const ExpectedMatchGroup(
      exactMatches: [
        [
          ExpectedDictionaryMatch(term: '会社', reading: 'かいしゃ', match: '会社', definitions: ["company (term+reading+definition)"]),
        ]
      ],
    ),
  ),
  DictionarySearchTestCase(
    description: "Filter by term + definition",
    query: '?t=会社&d=かいしゃ',

    queryMatches: const ExpectedMatchGroup(
      exactMatches: [
        [
          ExpectedDictionaryMatch(term: '会社', reading: '', match: '会社', definitions: ["かいしゃ (reading in definition)"]),
        ]
      ],
    ),
  ),
  DictionarySearchTestCase(
    description: "Filter by term + reading + definition (1 match)",
    query: '?t=会社&r=かいしゃ&d=company (term+reading+definition)',

    queryMatches: const ExpectedMatchGroup(
      exactMatches: [
        [
          ExpectedDictionaryMatch(term: '会社', reading: 'かいしゃ', match: '会社', definitions: ["company (term+reading+definition)"]),
        ]
      ],
    ),
  ),
  DictionarySearchTestCase(
    description: "Filter by term + reading + definition (0 match, entry with this reading does not exist)",
    query: '?t=会社&r=がいしゃ&d=かいしゃ (reading in definition)',

    queryMatches: const ExpectedMatchGroup(),
  ),
];