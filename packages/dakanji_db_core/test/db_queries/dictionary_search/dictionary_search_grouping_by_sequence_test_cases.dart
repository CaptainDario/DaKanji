
import 'dictionary_search_test_helper_classes.dart';



List<ExpectedDictionarySearchResult> groupBySequenceTests = [

  ExpectedDictionarySearchResult(
    description: "The entries with the same sequence number as 食べる should be found",
    query: "食べる",
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
          ExpectedDictionaryMatch(
            term: '召し上がる',
            reading: 'めしあがる',
            definitions: ['to eat (honorific)', 'to eat'],
            match: 'Sequence number',
          ),
        ],
      ],
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

];