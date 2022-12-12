import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:database_builder/database_builder.dart';

import 'package:da_kanji_mobile/provider/dict_search_result.dart';
import 'search_result_card.dart';



/// List that shows the search results of `DictSearch`
/// Needs a `Provider<Dictsearch>` above it in the widget tree
class SearchResultList extends StatefulWidget {

  final void Function(JMdict selection)? onSearchResultPressed;

  const SearchResultList(
    {
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
      itemCount: context.watch<DictSearch>().searchResults.length,
      itemBuilder: ((context, index) {
        return SearchResultCard(
          dictEntry: context.watch<DictSearch>().searchResults[index],
          resultIndex: index,
          onPressed: (selection) {
            context.read<DictSearch>().selectedResult = selection;
            if(widget.onSearchResultPressed != null)
              widget.onSearchResultPressed!(selection);
          } 
        );
      })
    );
  }
}