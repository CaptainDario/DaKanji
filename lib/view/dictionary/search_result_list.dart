import 'package:flutter/material.dart';

import 'package:database_builder/database_builder.dart';

import 'search_result_card.dart';



/// List that shows the search results of `DictSearch`
/// Needs a `Provider<Dictsearch>` above it in the widget tree
class SearchResultList extends StatefulWidget {

  /// The search results that should be shown in the list
  final List searchResults;
  /// Callback that is executed when the user pressed on a search result.
  /// Provides the selected entry as a parameter
  final void Function(JMdict selection)? onSearchResultPressed;

  const SearchResultList(
    {
      required this.searchResults,
      this.onSearchResultPressed,
      super.key
    }
  );

  @override
  State<SearchResultList> createState() => _SearchResultListState();
}

class _SearchResultListState extends State<SearchResultList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.searchResults.length,
      itemBuilder: ((context, index) {
        return SearchResultCard(
          dictEntry: widget.searchResults[index],
          resultIndex: index,
          onPressed: (selection) {
            if(widget.onSearchResultPressed != null)
                widget.onSearchResultPressed!(selection);
          } 
        );
      })
    );
  }
}