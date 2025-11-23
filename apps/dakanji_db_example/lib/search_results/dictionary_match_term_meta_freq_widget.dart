import 'package:dakanji_db_core/database/term_meta/term_meta_bank_entry.dart';
import 'package:dakanji_db_example/search_results/dictionary_match_tag.dart';
import 'package:flutter/material.dart';



class DictionaryMatchTermMetaFreqWidget extends StatelessWidget {

  final Map<int, List<TermMetaBankV3Entry>> freqTermMetaEntries;

  const DictionaryMatchTermMetaFreqWidget(this.freqTermMetaEntries, {super.key});

  @override
  Widget build(BuildContext context) {

    return Wrap(
      spacing: 4,
      runSpacing: 4,
      children: [
        for (final MapEntry(key: index, value: entries) in freqTermMetaEntries.entries)
          DictionaryMatchTag(
            text: () {
              String text = ""; bool firstNoReading = true;

              for (var i = 0; i < entries.length; i++) {
                final e = entries[i];
                if(firstNoReading && i != 0 && e.reading == null) {
                  text += " ◆ ";
                  firstNoReading = false;
                }
                text += "${e.frequencyDisplayValue ?? e.frequency}";
                if(i != entries.length -1 && entries[i+1].reading != null) text += ", ";
              }

              return text;
            } (),
            leadingText: entries.first.indexEntry.title.toString(),
          )
      ]
    );
  }
}