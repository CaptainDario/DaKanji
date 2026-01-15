import 'package:dakanji_db_core/database/db_queries/dictionary_search/dictionary_match.dart';
import 'package:dakanji_db_core/database/tag/tag_bank_v3_entry.dart';
import 'package:dakanji_db_ui/search_results/dictionary_match_tag_bank_widget.dart';
import 'package:dakanji_db_ui/search_results/dictionary_match_term_bank_definitions_widget.dart';
import 'package:dakanji_db_ui/search_results/dictionary_match_term_bank_term_widget.dart';
import 'package:dakanji_db_ui/search_results/dictionary_match_term_meta_widget.dart';
import 'package:dakanji_util/widgets/conditional_parent_widget.dart';
import 'package:flutter/material.dart';



class DictionaryMatchWidget extends StatelessWidget {
  
  /// The dictionary match to display.
  final DictionaryMatch match;

  /// Whether to show tags.
  final bool showTags;

  /// Whether to show meta entries.
  final bool showMetaEntries;

  /// Max height for definitions section. 0 = unlimited.
  final double definitionsMaxHeight;

  /// Callback that is called when this widget is tapped.
  final Function(DictionaryMatch match)? onTap;

  const DictionaryMatchWidget(
    this.match,
    {
      this.showTags = true,
      this.showMetaEntries = true,
      this.definitionsMaxHeight = 0,
      this.onTap,
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
          clipBehavior: Clip.hardEdge,
          child: InkWell(
            onTap: onTap?.call(match),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DictionaryMatchTermBankTermWidget(match.entries),
                  SizedBox(height: 8.0),
          
                  if(showTags)
                    if(tags.expand((e) => e).isNotEmpty)
                      ...[
                        DictionaryMatchTagBankWidget(tags),
                        SizedBox(height: 4.0),
                      ],
                  if(showMetaEntries)
                    if(match.metaEntriesForEachEntry.expand((e) => e,).isNotEmpty)
                      ...[
                        DictionaryMatchTermMetaWidget(match.metaEntriesForEachEntry),
                        SizedBox(height: 8.0),
                      ],
                  ConditionalParentWidget(
                    condition: definitionsMaxHeight == 0,
                    child: DictionaryMatchTermBankDefinitionsWidget(
                      match.entries,
                      definitionsMaxHeight: definitionsMaxHeight,
                    ),
                    conditionalBuilder: (child) {
                      return SelectionContainer.disabled(child: child);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}