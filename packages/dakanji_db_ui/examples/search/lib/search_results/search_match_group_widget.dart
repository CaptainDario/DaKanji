import 'package:collection/collection.dart';
import 'package:dakanji_db_core/database/db_queries/dictionary_search/dictionary_match.dart';
import 'package:dakanji_db_core/database/db_queries/dictionary_search/dictionary_match_group.dart';
import 'package:dakanji_db_ui/search_results/dictionary_match_widget.dart';
import 'package:flutter/material.dart';



class SearchMatchGroupWidget extends StatelessWidget {
  
  final DictionaryMatchGroup matchGroup;

  final bool useStructuredContentDefinitions;
  
  const SearchMatchGroupWidget(
    this.matchGroup,
    this.useStructuredContentDefinitions,
    {
      super.key
    }
  );

  List<DictionaryMatch> get allMatchGroups {
    return CombinedListView([
      matchGroup.exactMatches,
      matchGroup.prefixMatches,
      matchGroup.tokenMatches,
      matchGroup.wildcardMatches
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return SliverList.list(
      children: [
        Text("Exact matches: ${matchGroup.exactMatches.length}"),
        for (final match in matchGroup.exactMatches)
          DictionaryMatchWidget(match),
        Text("Prefix matches: ${matchGroup.prefixMatches.length}"),
        for (final match in matchGroup.prefixMatches)
          DictionaryMatchWidget(match),
        Text("Sub-word matches: ${matchGroup.tokenMatches.length}"),
        for (final match in matchGroup.tokenMatches)
          DictionaryMatchWidget(match),
        Text("Wildcard matches: ${matchGroup.wildcardMatches.length}"),
        for (final match in matchGroup.wildcardMatches)
          DictionaryMatchWidget(match),
      ],
    );
  }
}