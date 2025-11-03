
import 'dictionary_search_test_helper_classes.dart';



List<ExpectedDictionarySearchResult> fuzzySearchTestCases = [

  ExpectedDictionarySearchResult(
    description: "The entries with the same sequence number as 食べる should be found",
    query: "食べる",
    fuzzyMatches: [
      const ExpectedMatchGroup(
        exactMatches: [
          [
            ExpectedDictionaryMatch(
              term: '食べる',
              reading: 'たべる',
              definitions: ['to eat'],
              match: '食べる',
            ),
            ExpectedDictionaryMatch(
              term: '食べます',
              reading: 'たべます',
              definitions: ['to eat (polite)'],
              match: 'Sequence number',
            ),
          ]
        ],
      ),
    ]
  ),

];