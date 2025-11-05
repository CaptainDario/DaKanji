import 'package:dakanji_db_core/database/db_queries/dictionary_search/dictionary_search_result.dart';
import 'package:dakanji_db_example/search_results/dictionary_match_widget.dart';
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
        for (final match in matchGroup.exactMatches)
          DictionaryMatchWidget(match),
        //Text("Prefix matches: ${matchGroup.prefixMatches.length}"),
        //DictionaryMatchWidget(matchGroup.prefixMatches),
        //Text("Sub-word matches: ${matchGroup.tokenMatches.length}"),
        //DictionaryMatchWidget(matchGroup.tokenMatches),
        //Text("Wildcard matches: ${matchGroup.wildcardMatches.length}"),
        //DictionaryMatchWidget(matchGroup.wildcardMatches),
      ],
    );
  }
}