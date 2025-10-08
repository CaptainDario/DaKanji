import 'dictionary_search_test_helper_classes.dart';



List<SearchTestCase> tagFilteringTestCases = [
  SearchTestCase(
    description: "Filter by single tag (DE)",
    query: '人',
    tags: ['DE'],
    queryMatches: const ExpectedMatchGroup(
      tokenMatches: [
        ExpectedSearchResult(term: 'ドイツ人', reading: 'どいつじん', match: 'ドイツ人', definitions: ["Eine deutsche Person"]),
      ],
    ),
  ),
  SearchTestCase(
    description: "Filter by multiple tags (Japanese and Rare)",
    query: '電車',
    tags: ['JP', 'R'],
    queryMatches: const ExpectedMatchGroup(
      tokenMatches: [
        ExpectedSearchResult(term: '満員電車', reading: 'まんいんでんしゃ', match: '満員電車', definitions: ["crowded train; packed train"]),
      ],
    ),
  ),
  SearchTestCase(
    description: "No matches due to tag filtering",
    query: '人',
    tags: ['FR'],
  ),
  SearchTestCase(
    description: "No tag filtering (empty tag list)",
    query: '人',
    tags: [],
    queryMatches: const ExpectedMatchGroup(
      exactMatches: [
        ExpectedSearchResult(term: '人', reading: 'じん', match: '人', definitions: ["Person"]),
      ],
      tokenMatches: [
        ExpectedSearchResult(term: '中国人', reading: 'ちゅうごくじん', match: '中国人', definitions: ["Chinese person"]),
        ExpectedSearchResult(term: '日本人', reading: 'にほんじん', match: '日本人', definitions: ["Japanese person"]),
        ExpectedSearchResult(term: 'ドイツ人', reading: 'どいつじん', match: 'ドイツ人', definitions: ["Eine deutsche Person"]),
      ],
    ),
  ),
  SearchTestCase(
    description: "Filter by single tag (DE) on wildcard search",
    query: '*人',
    tags: ['DE'],
    queryMatches: const ExpectedMatchGroup(
      wildcardMatches: [
        ExpectedSearchResult(term: 'ドイツ人', reading: 'どいつじん', match: 'ドイツ人', definitions: ["Eine deutsche Person"]),
      ],
    ),
  ),
];