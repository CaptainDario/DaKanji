


import 'package:dakanji_db_core/database/db_queries/dictionary_search/dictionary_search_result.dart';
import 'package:dakanji_db_example/search_match_group_widget.dart';
import 'package:flutter/material.dart';

class DictionarySearchResultWidget extends StatelessWidget {

  final DictionarySearchResult result;

  const DictionarySearchResultWidget(
    this.result,
    {
      super.key
    }
  );

  
  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        SearchMatchGroupWidget(result.queryMatches),
        SearchMatchGroupWidget(result.hiraganaQueryMatches),
        for (final m in result.queryVariantMatches)
          SearchMatchGroupWidget(m)
      ],
    );
  }
}