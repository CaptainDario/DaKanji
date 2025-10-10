import 'package:dakanji_db_core/database/db_queries/dictionary_search/dictionary_search_result.dart';
import 'package:flutter/material.dart';



class DictionaryMatchWidget extends StatelessWidget {
  
  final List<DictionaryMatch> matchs;

  const DictionaryMatchWidget(
    this.matchs,
    {
      super.key
    }
  );

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          for (final match in matchs)
            ...[
              Text("Matched: ${match.match}"),
              Text(match.entry.term),
              Text(match.entry.reading),
              Text(match.entry.definitions.join(", ")),
            ]
        ],
      ),
    );
  }
}