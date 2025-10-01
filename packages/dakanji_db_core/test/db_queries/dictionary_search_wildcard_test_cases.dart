import 'dictionary_search_test_helper_classes.dart';



List<SearchTestCase> wildcardSearchTestCases = [
  SearchTestCase(
    description: "Wildcard '?': single character",
    query: '?本',
    queryMatches: const ExpectedMatchGroup(
      wildcardMatches: [
        ExpectedSearchResult(term: '日本', reading: 'にほん', match: '?本', definitions: ["Japan"]),
      ],
    ),
  ),
  SearchTestCase(
    description: "Wildcard '?': Two wildcards",
    query: '?本?',
    queryMatches: const ExpectedMatchGroup(
      wildcardMatches: [
        ExpectedSearchResult(term: '日本人', reading: 'にほんじん', match: '?本?', definitions: ["Japanese person"]),
      ],
    ),
  ),
  SearchTestCase(
    description: "Wildcard '*': zero to many characters",
    query: '*人',
    queryMatches: const ExpectedMatchGroup(
      wildcardMatches: [
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
        ExpectedSearchResult(term: '日本人', reading: 'にほんじん', match: '日本人', definitions: ["Japanese person"]),
      ],
    ),
  ),
  SearchTestCase(
    description: "Wildcard '*' and '?': using both wildcards in one query",
    query: '*本?',
    queryMatches: const ExpectedMatchGroup(
      wildcardMatches: [
        ExpectedSearchResult(term: '日本人', reading: 'にほんじん', match: '日本人', definitions: ["Japanese person"]),
      ],
    ),
  ),
];