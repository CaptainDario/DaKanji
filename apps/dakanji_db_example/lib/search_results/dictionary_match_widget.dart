import 'package:dakanji_db_core/database/db_queries/dictionary_search/dictionary_search_result.dart';
import 'package:dakanji_db_example/search_results/dictionary_match_index_widget.dart';
import 'package:dakanji_db_example/search_results/dictionary_match_tag_widget.dart';
import 'package:dakanji_db_example/search_results/dictionary_match_term_widget.dart';
import 'package:flutter/material.dart';



class DictionaryMatchWidget extends StatelessWidget {
  
  /// The dictionary match to display.
  final DictionaryMatch match;

  const DictionaryMatchWidget(
    this.match,
    {
      super.key
    }
  );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DictionaryMatchTermWidget(match.entries),
              DictionaryMatchTagWidget(match.entries.map((e) => e.tags).toList()),
              DictionaryMatchIndexWidget(match.indexTableData)
            ],
          ),
        ),
      ),
    );
  }
}