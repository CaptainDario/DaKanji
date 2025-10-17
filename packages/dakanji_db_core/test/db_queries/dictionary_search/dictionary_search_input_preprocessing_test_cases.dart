import 'dictionary_search_test_helper_classes.dart';

String descriptionPrefix = "Input processing";

List<SearchTestCase> inputPreprocessingSearchTestCases = [
  SearchTestCase(
    description: '$descriptionPrefix: Search with Romaji input (taberu -> たべる)',
    query: 'taberu',
    hiraganaQueryMatches: const ExpectedMatchGroup(
      exactMatches: [
        ExpectedSearchResult(term: '食べる', reading: 'たべる', match: 'たべる', definitions: ["to eat"]),
      ],
      prefixMatches: [
        ExpectedSearchResult(term: '食べるラー油', reading: 'たべるらーゆ', match: 'たべるらーゆ', definitions: ["chili oil with garlic, etc. for eating with rice"])
      ],
    ),
  ),
  SearchTestCase(
    description: '$descriptionPrefix: Search with Romaji and kana input (カワii -> かわいい)',
    query: 'カワii',
    hiraganaQueryMatches: const ExpectedMatchGroup(
      exactMatches: [
        ExpectedSearchResult(term: '可愛い', reading: 'かわいい', match: 'かわいい', definitions: ["cute; lovely; charming"]),
      ],
    ),
  ),
  SearchTestCase(
    description: '$descriptionPrefix: Search for こんぴゅーたー should match コンピューター (term) and こんぴゅーたー (reading)',
    query: 'こんぴゅーたー',
    queryMatches: const ExpectedMatchGroup(
      exactMatches: [
        ExpectedSearchResult(term: '', reading: 'こんぴゅーたー', match: 'こんぴゅーたー', definitions: ["Computer"]),
      ],
    ),
    hiraganaQueryMatches: const ExpectedMatchGroup(
      exactMatches: [
        ExpectedSearchResult(term: 'コンピューター', reading: '', match: 'コンピューター', definitions: ["Computer"]),
      ],
    ),
  ),
];