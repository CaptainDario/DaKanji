
import 'dictionary_search_test_helper_classes.dart';



List<ExpectedDictionarySearchResult> groupingTests = [

  ExpectedDictionarySearchResult(
    description: "The entries with the same sequence number as 食べる should be found",
    query: "食べ",
    queryMatches: const ExpectedMatchGroup(
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
        ],
        [
          ExpectedDictionaryMatch(
            term: '食べるラー油',
            reading: 'たべるラーゆ',
            definitions: ['chili oil with garlic, etc. for eating with rice'],
            match: 'Sequence number',
          ),
        ]
      ],
    ),
  ),

];