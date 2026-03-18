import 'dart:async';
import 'package:da_db/database/db_queries/dictionary_search/dictionary_match.dart';
import 'package:da_db/database/tag/tag_bank_v3_entry.dart';
import 'package:da_kanji_mobile/features/dictionary/widgets/tag/tag_bank_widget.dart';
import 'package:da_kanji_mobile/features/dictionary/widgets/term/term_bank_definitions_widget.dart';
import 'package:da_kanji_mobile/features/dictionary/widgets/term/term_bank_term_widget.dart';
import 'package:da_kanji_mobile/features/dictionary/widgets/term_meta/term_meta_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_util/widgets/conditional_parent_widget.dart';



class TermEntryWidget extends StatelessWidget {
  
  /// The dictionary match to display.
  final DictionaryMatch match;

  /// Whether to show tags.
  final bool showTags;

  /// Whether to show meta entries.
  final bool showMetaEntries;

  /// Max height for definitions section. 0 = unlimited.
  final double definitionsMaxHeight;

  /// Whether to use katakana for furigana readings.
  final bool useKatakanaForFurigana;

  /// Whether to show audio playback buttons.
  final bool showAudioPlaybackButtons;

  /// Whether to render in compact mode (term bank entries and definitions in one line)
  final bool compactMode;

  /// Whether to include a card widget or just render the content directly.
  final bool includeCard;

  /// Callback that is called when this widget is tapped.
  final Function(DictionaryMatch match)? onTap;

  /// Callback that is called when a URL is tapped.
  /// Should return true if the URL was handled.
  final FutureOr<bool> Function(String url)? onUrlTap;

  const TermEntryWidget(
    this.match,
    {
      this.showTags = true,
      this.showMetaEntries = true,
      this.definitionsMaxHeight = 0,
      this.useKatakanaForFurigana = false,
      this.showAudioPlaybackButtons = false,
      this.compactMode = false,
      this.includeCard = true,
      this.onTap,
      this.onUrlTap,
      super.key
    }
  );

  @override
  Widget build(BuildContext context) {

    List<List<TagBankV3Entry>> tags = match.entries.map((e) => e.tags).toList();

    return SizedBox(
      width: double.infinity,
      child: SelectionArea(
        child: ConditionalParentWidget(
          condition: includeCard,
          conditionalBuilder: (child) {
            return Card(child: child);
          },
          child: InkWell(
            onTap: onTap == null
              ? null
              : () {
                onTap?.call(match);
              },
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TermBankTermWidget(
                    match.entries,
                    useKatakanaForFurigana: useKatakanaForFurigana,
                    showAudioPlaybackButtons: showAudioPlaybackButtons,
                  ),
                  SizedBox(height: 8.0),
          
                  if(showTags)
                    if(tags.expand((e) => e).isNotEmpty)
                      ...[
                        TagBankWidget(tags),
                        SizedBox(height: 4.0),
                      ],
                  if(showMetaEntries)
                    if(match.metaEntriesForEachEntry.expand((e) => e,).isNotEmpty)
                      ...[
                        TermMetaWidget(match.metaEntriesForEachEntry),
                        SizedBox(height: 8.0),
                      ],
                  TermBankDefinitionsWidget(
                    match.entries,
                    definitionsMaxHeight: definitionsMaxHeight,
                    compactMode: compactMode,
                    onTapUrl: onUrlTap,
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