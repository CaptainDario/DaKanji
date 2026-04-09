// Flutter imports:
import 'package:da_db/database/db_queries/dictionary_search/dictionary_match.dart';
import 'package:da_kanji_mobile/features/dictionary/model/dictionary_search_state.dart';
// Project imports:
import 'package:da_kanji_mobile/features/dictionary/widgets/word_tab/dictionary_word_card.dart';
import 'package:da_kanji_mobile/globals.dart';
import 'package:flutter/material.dart';
// Project imports:
import 'package:provider/provider.dart';

/// A [DictionaryWordCard] that can be used to take a off-screen screenshot
class DictionaryWordCardScreenshot extends StatelessWidget {
  final DictionaryMatch match;
  final bool showConjugationTable;
  final ThemeData theme;

  const DictionaryWordCardScreenshot(this.match, this.showConjugationTable, this.theme, {super.key});

  @override
  Widget build(BuildContext context) {

    // 1. Align is the safe "Cropper" that doesn't crash SelectionArea
    return SizedBox(
      width: g_minDesktopWindowSize.width,
      // 2. Material prevents text from rendering with yellow error underlines
      child: Material(
        type: MaterialType.transparency, // Uses the TermEntryWidget's background
        child: Theme(
          data: theme, // Forces your specific screenshot theme
          child: Provider<DictionarySearchState>(
            create: (_) => DictionarySearchState()..selectedResult = match,
            child: DictionaryWordCard(
              showConjugationTable: showConjugationTable,
              conjugationTableExpandable: false,
              showImageSearch: false,
            ),
          ),
        ),
      ),
    );
  }
}