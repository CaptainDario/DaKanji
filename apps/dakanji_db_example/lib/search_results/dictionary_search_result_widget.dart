


import 'package:dakanji_db_core/database/dakanji_db.dart';
import 'package:dakanji_db_core/database/db_queries/dictionary_search/dictionary_search_result.dart';
import 'package:dakanji_db_example/search_results/search_match_group_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DictionarySearchResultWidget extends StatelessWidget {

  /// The search result to display
  final DictionarySearchResult result;
  /// The database instance
  final DaKanjiDB db;

  

  const DictionarySearchResultWidget(
    this.result,
    this.db,
    {
      super.key
    }
  );

  
  @override
  Widget build(BuildContext context) {

    return Provider.value(
      value: db,
      child: Column(
        children: [
          SearchMatchGroupWidget(result.queryMatches),
          // TODO
          //for (final m in result.normalizedQueryMatchGroups)
          //  SearchMatchGroupWidget(m),
          //for (final m in result.queryVariantMatches)
          //  SearchMatchGroupWidget(m)
        ],
      ),
    );
  }
}