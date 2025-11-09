import 'package:dakanji_db_core/database/term_meta/term_meta_bank_entry.dart';
import 'package:dakanji_db_example/search_results/dictionary_match_tag.dart';
import 'package:flutter/material.dart';



class DictionaryMatchTermMetaFreqWidget extends StatelessWidget {

  final Map<String, List<TermMetaBankV3Entry>> freqTermMetaEntries;

  const DictionaryMatchTermMetaFreqWidget(this.freqTermMetaEntries, {super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 4,
      runSpacing: 4,
      children: [
        for (final MapEntry(key: index, value: entries) in freqTermMetaEntries.entries)
          DictionaryMatchTag(
            text: entries.map((e) => 
              e.frequencyDisplayValue ?? e.frequency
            ).join(", "),
            leadingText: entries.first.indexEntry.title.toString(),
          )
      ]
    );
  }
}