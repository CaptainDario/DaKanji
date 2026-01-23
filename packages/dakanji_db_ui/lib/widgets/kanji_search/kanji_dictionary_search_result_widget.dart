import 'package:dakanji_db_core/database/db_queries/kanji_dictionary_search/kanji_dictionary_search_result.dart';
import 'package:dakanji_db_ui/widgets/search_results/dictionary_match_tag_bank_widget.dart';
import 'package:flutter/material.dart';



class KanjiDictionarySearchResultWidget extends StatelessWidget {

  final KanjiDictionarySearchResult result;

  const KanjiDictionarySearchResultWidget(
    this.result,
    {
      super.key
    }
  );

  @override
  Widget build(BuildContext context) {

    final kanjiEntry = result.kanjiBankEntry;
    final KanjiMetaEntries = result.kanjiMetaBankEntries;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: .start,
          crossAxisAlignment: .start,
          children: [
            Align(
              alignment: .centerLeft,
              child: SizedBox(
                height: 100,
                width: 100,
                child: FittedBox(
                  child: Text(
                    result.kanjiBankEntry.kanji,
                  ),
                ),
              ),
            ),
            DictionaryMatchTagBankWidget([kanjiEntry.tags])
          ],
        ),
      ),
    );
  }
}