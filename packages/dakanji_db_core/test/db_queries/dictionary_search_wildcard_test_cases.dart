import 'dictionary_search_test_helper_classes.dart';



List<SearchTestCase> wildcardSearchTestCases = [
  SearchTestCase(
    description: "Wildcard '?': single character",
    query: '?本',
    queryMatches: const ExpectedMatchGroup(
      wildcardMatches: [
        ExpectedSearchResult(term: '日本', reading: 'にほん', match: '日本', definitions: ["Japan"]),
        ExpectedSearchResult(term: '二本', reading: 'にほん', match: '二本', definitions: ["two long objects"]),
      ],
    ),
  ),
  SearchTestCase(
    description: "Wildcard '?': Two wildcards",
    query: '?本?',
    queryMatches: const ExpectedMatchGroup(
      wildcardMatches: [
        ExpectedSearchResult(term: '日本人', reading: 'にほんじん', match: '日本人', definitions: ["Japanese person"]),
        ExpectedSearchResult(term: '日本酒', reading: 'にほんしゅ', match: '日本酒', definitions: ["sake; Japanese rice wine"]),
      ],
    ),
  ),
  /// 中国人 has the highest popularity (147) so it should come first
  /// 人, 日本人 and ドイツ人 all have the same popularity (99) so they are sorted
  /// by length (shorter first)
  SearchTestCase(
    description: "Wildcard '*': zero to many characters",
    query: '*人',
    queryMatches: const ExpectedMatchGroup(
      wildcardMatches: [
        ExpectedSearchResult(term: '中国人', reading: 'ちゅうごくじん', match: '中国人', definitions: ["Chinese person"]),
        ExpectedSearchResult(term: '人', reading: 'じん', match: '人', definitions: ["Person"]),
        ExpectedSearchResult(term: '日本人', reading: 'にほんじん', match: '日本人', definitions: ["Japanese person"]),
        ExpectedSearchResult(term: 'ドイツ人', reading: 'どいつじん', match: 'ドイツ人', definitions: ["German person"]),
        
      ],
    ),
  ),
  SearchTestCase(
    description: "Wildcard '*': zero characters",
    query: '*日本人',
    queryMatches: const ExpectedMatchGroup(
      wildcardMatches: [
        ExpectedSearchResult(term: '日本人', reading: 'にほんじん', match: '日本人', definitions: ["Japanese person"]),
      ],
    ),
  ),
SearchTestCase(
    description: "Wildcard '*': multiple wild cards",
    query: '*本*',
    queryMatches: const ExpectedMatchGroup(
      wildcardMatches: [
        // Rule 4: Sorted by frequency (99 > 95 > 90 > 80).
        ExpectedSearchResult(term: '日本', reading: 'にほん', match: '日本', definitions: ["Japan"]),

        // This group is tied by frequency (95) and length (3), so order is by appearance.
        ExpectedSearchResult(term: '日本人', reading: 'にほんじん', match: '日本人', definitions: ["Japanese person"]),
        ExpectedSearchResult(term: '日本酒', reading: 'にほんしゅ', match: '日本酒', definitions: ["sake; Japanese rice wine"]),
        ExpectedSearchResult(term: '日本晴れ', reading: 'にほんばれ', match: '日本晴れ', definitions: ["clear weather; cloudless sky"]),

        ExpectedSearchResult(term: '本日', reading: 'ほんじつ', match: '本日', definitions: ["today"]),
        
        // Rule 6: This group is tied by frequency (80) but broken by length.
        // '二本' (len 2) comes before '全日本' (len 3).
        ExpectedSearchResult(term: '二本', reading: 'にほん', match: '二本', definitions: ["two long objects"]),
        ExpectedSearchResult(term: '全日本', reading: 'ぜんにほん', match: '全日本', definitions: ["all Japan"]),
      ],
    ),
  ),
  SearchTestCase(
    description: "Wildcard '*' and '?': using both wildcards in one query",
    query: '*本?',
    queryMatches: const ExpectedMatchGroup(
      wildcardMatches: [
        ExpectedSearchResult(term: '日本人', reading: 'にほんじん', match: '日本人', definitions: ["Japanese person"]),
        ExpectedSearchResult(term: '日本酒', reading: 'にほんしゅ', match: '日本酒', definitions: ["sake; Japanese rice wine"]),
        ExpectedSearchResult(term: '本日', reading: 'ほんじつ', match: '本日', definitions: ["today"]),
      ],
    ),
  ),
];