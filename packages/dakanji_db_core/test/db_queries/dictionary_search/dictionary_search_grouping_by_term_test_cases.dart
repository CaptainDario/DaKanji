
import 'dictionary_search_test_helper_classes.dart';



List<ExpectedDictionarySearchResult> groupByTermTests = [

  ExpectedDictionarySearchResult(
    description: "",
    query: "水餃子",
    queryMatches: const ExpectedMatchGroup(
      exactMatches: [
        [
          ExpectedDictionaryMatch(
            term: '水餃子',
            reading: 'すいぎょうざ',
            definitions: ['2) dumplings cooked in boiling water; boiled dumplings'],
            match: '水餃子',
          ),
          ExpectedDictionaryMatch(
            term: '水餃子',
            reading: 'すいぎょうざ',
            definitions: ['1) dumplings cooked in boiling water; boiled dumplings'],
            match: '水餃子',
          ),
          ExpectedDictionaryMatch(
            term: '水餃子',
            reading: 'すいぎょうざ',
            definitions: ['3) dumplings cooked in boiling water; boiled dumplings'],
            match: '水餃子',
          ),
        ],
      ],
    ),
  ),

];