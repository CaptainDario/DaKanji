import 'dictionary_search_test_helper_classes.dart';

String descriptionPrefix = "Index On/Off";

List<DictionarySearchTestCase> indexOnOffTestCases = [
  // nothing off
  DictionarySearchTestCase(
    description: '$descriptionPrefix: Nothing turned off - should return all results',
    query: '帽子',
    queryMatches: const ExpectedMatchGroup(
      exactMatches: [
        [ExpectedDictionaryMatch(term: '帽子', reading: 'ぼうし', match: '帽子', definitions: ["hat; cap (dict 3)"])],
        [ExpectedDictionaryMatch(term: '帽子', reading: 'ぼうし', match: '帽子', definitions: ["hat; cap (dict 4)"])],
        [ExpectedDictionaryMatch(term: '帽子', reading: 'ぼうし', match: '帽子', definitions: ["hat; cap (dict 5)"])],
      ],
    ),
  ),
  // only dict [1, 2, 3]
  DictionarySearchTestCase(
    description: '$descriptionPrefix: Only index 1, 2, 3 - should return all results from them',
    query: '帽子',
    indexesToInclude: [1, 2, 3],
    queryMatches: const ExpectedMatchGroup(
      exactMatches: [
        [ExpectedDictionaryMatch(term: '帽子', reading: 'ぼうし', match: '帽子', definitions: ["hat; cap (dict 3)"])],
      ],
    ),
  ),
  // only default dicts
  DictionarySearchTestCase(
    description: '$descriptionPrefix: Only default dictionaries - should return dict 5',
    query: '帽子',
    useOnlyDefaultDictionaries: true,
    queryMatches: const ExpectedMatchGroup(
      exactMatches: [
        [ExpectedDictionaryMatch(term: '帽子', reading: 'ぼうし', match: '帽子', definitions: ["hat; cap (dict 4)"])],
      ],
    ),
  ),
  // only enabled dicts
  DictionarySearchTestCase(
    description: '$descriptionPrefix: Only enabled dictionaries - should return dict 5',
    query: '帽子',
    useOnlyEnabledDictionaries: true,
    queryMatches: const ExpectedMatchGroup(
      exactMatches: [
        [ExpectedDictionaryMatch(term: '帽子', reading: 'ぼうし', match: '帽子', definitions: ["hat; cap (dict 5)"])],
      ],
    ),
  ),
];