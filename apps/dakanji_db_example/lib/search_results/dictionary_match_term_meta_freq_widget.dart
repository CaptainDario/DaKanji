import 'package:dakanji_db_core/database/term_meta/term_meta_bank_entry.dart';
import 'package:dakanji_db_example/search_results/dictionary_match_tag.dart';
import 'package:flutter/material.dart';



class DictionaryMatchTermMetaFreqWidget extends StatelessWidget {

  final Map<int, List<TermMetaBankV3Entry>> freqTermMetaEntries;

  const DictionaryMatchTermMetaFreqWidget(this.freqTermMetaEntries, {super.key});

  List<({List<String> texts, List<Color?> textColors})> prepareTags(
    Iterable<MapEntry<int, List<TermMetaBankV3Entry>>> entries,
    bool containsMultipleGroupedEntries
  ) {

    List<({List<String> texts, List<Color?> textColors})> ret = [];

    for (final MapEntry(key: index, value: entries) in entries){

      List<String> texts = []; List<Color?> textColors = [];
      String currentText = ""; bool firstNoReading = true;
      String lastGroupingTerm = "";

      for (var i = 0; i < entries.length; i++) {
        final e = entries[i];

        if(
          containsMultipleGroupedEntries && // this contains multiple grouped entries
          entries[i].term != lastGroupingTerm // and this is a new term
        ){
          lastGroupingTerm = entries[i].term;
          if(i != 0) {
            texts.add(currentText);
            textColors.add(null);
            currentText = "";
          }
          texts.add(
            "${entries[i].term}${entries[i].reading == null ? "${entries[i].reading}" : ""} "
          );
          textColors.add(Colors.grey);
        }

        if(firstNoReading && i != 0 && e.reading == null) {
          currentText += " ◆ ";
          firstNoReading = false;
        }
        currentText += "${e.frequencyDisplayValue ?? e.frequency}";
        if(i != entries.length -1 &&
          entries[i+1].reading != null &&
          (entries[i+1].term == lastGroupingTerm || lastGroupingTerm == "")) {
          currentText += ", ";
        }
      }
      ret.add((texts: texts, textColors: textColors));
    }

    return ret;
  }

  @override
  Widget build(BuildContext context) {

    List<String> allTerms = freqTermMetaEntries.values.expand((e) => e.map((e) => e.term)).toSet().toList();
    bool containsMultipleGroupedEntries = allTerms.length > 1;
    final tags = prepareTags(
      freqTermMetaEntries.entries,
      containsMultipleGroupedEntries
    );

    return Wrap(
      spacing: 4,
      runSpacing: 4,
      children: [
        for (final (i, MapEntry(key: index, value: entries)) in freqTermMetaEntries.entries.indexed)
          DictionaryMatchTag(
            texts: tags[i].texts,
            textColors: tags[i].textColors,
            leadingText: entries.first.indexEntry.title.toString(),
          )
      ]
    );
  }
}