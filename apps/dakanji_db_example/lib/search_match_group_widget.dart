import 'package:dakanji_db_core/database/db_queries/dictionary_search/dictionary_search_result.dart';
import 'package:dakanji_db_example/dictionary_match_widget.dart';
import 'package:flutter/material.dart';



class SearchMatchGroupWidget extends StatelessWidget {
  
  final SearchMatchGroup matchGroup;
  
  const SearchMatchGroupWidget(
    this.matchGroup,
    {
      super.key
    }
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Exact matches: ${matchGroup.exactMatches.length}"),
        DictionaryMatchWidget(matchGroup.exactMatches),
        Text("Prefix matches: ${matchGroup.prefixMatches.length}"),
        DictionaryMatchWidget(matchGroup.prefixMatches),
        Text("Sub-word matches: ${matchGroup.tokenMatches.length}"),
        DictionaryMatchWidget(matchGroup.tokenMatches),
        Text("Fuzzy matches: ${matchGroup.fuzzyMatches.length}"),
        DictionaryMatchWidget(matchGroup.fuzzyMatches),
        Text("Wildcard matches: ${matchGroup.wildcardMatches.length}"),
        DictionaryMatchWidget(matchGroup.wildcardMatches),
      ],
    );
  }
}