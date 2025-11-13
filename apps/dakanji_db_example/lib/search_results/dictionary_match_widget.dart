import 'package:dakanji_db_core/database/db_queries/dictionary_search/dictionary_search_result.dart';
import 'package:dakanji_db_core/database/tag/tag_bank_v3_entry.dart';
import 'package:dakanji_db_example/search_results/dictionary_match_tag_bank_widget.dart';
import 'package:dakanji_db_example/search_results/dictionary_match_term_bank_definitions_widget.dart';
import 'package:dakanji_db_example/search_results/dictionary_match_term_bank_term_widget.dart';
import 'package:dakanji_db_example/search_results/dictionary_match_term_meta_widget.dart';
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

    List<List<TagBankV3Entry>> tags = match.entries.map((e) => e.tags).toList();

    return SizedBox(
      width: double.infinity,
      child: SelectionArea(
        child: Card(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DictionaryMatchTermBankTermWidget(match.entries),
                SizedBox(height: 8.0),

                if(tags.expand((e) => e).isNotEmpty)
                  ...[
                    DictionaryMatchTagBankWidget(tags),
                    SizedBox(height: 4.0),
                  ],
                if(match.metaEntriesForEachEntry.expand((e) => e,).isNotEmpty)
                  ...[
                    DictionaryMatchTermMetaWidget(match.metaEntriesForEachEntry),
                    SizedBox(height: 8.0),
                  ],
                DictionaryMatchTermBankDefinitionsWidget(match.entries)
              ],
            ),
          ),
        ),
      ),
    );
  }
}