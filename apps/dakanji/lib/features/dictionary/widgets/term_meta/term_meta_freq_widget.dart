import 'package:da_db/database/term_meta/term_meta_bank_entry.dart';
import 'package:da_db_ui/widgets/tag/tag_widget.dart';
import 'package:flutter/material.dart';



class TermMetaFreqWidget extends StatelessWidget {

  final Map<int, List<TermMetaBankV3Entry>> freqTermMetaEntries;

  const TermMetaFreqWidget(this.freqTermMetaEntries, {super.key});

  List<({List<String> texts, List<Color?> textColors})> prepareTags(
    Iterable<MapEntry<int, List<TermMetaBankV3Entry>>> entries,
    bool containsMultipleGroupedEntries
  ) {

    List<({List<String> texts, List<Color?> textColors})> ret = [];

    for (final MapEntry(key: index, value: entries) in entries){

      List<String> texts = []; 
      List<Color?> textColors = [];
      String currentText = "";
      String lastGroupingTerm = "";

      for (var i = 0; i < entries.length; i++) {
        final entry = entries[i];

        // Handle Group Switching (New Term)
        // If showing groups, and this term is different from the last one
        if(containsMultipleGroupedEntries && entry.term != lastGroupingTerm){
          
          // If there is text from the previous group, push it now
          if(currentText.isNotEmpty) {
             texts.add(currentText);
             textColors.add(null);
             currentText = "";
          }

          // If this isn't the very first item, add the separator pipe
          if(i != 0) {
            texts.add(" | ");
            textColors.add(Colors.grey);
          }

          // Update the group tracker
          lastGroupingTerm = entry.term;

          // Add the Group Header (e.g., "term" or "term:reading")
          texts.add(
            "${entry.term}${entry.reading != null ? ":${entry.reading}" : ""} "
          );
          textColors.add(Colors.grey);
        }

        // Add the value
        currentText += "${entry.frequencyDisplayValue ?? entry.frequency}";

        // We add a comma if:
        //  - It is NOT the last item in the list
        //  - AND the NEXT item belongs to the same group (so we don't put a comma before a pipe '|')
        bool isNotLast = i < entries.length - 1;
        
        if (isNotLast) {
          final nextEntry = entries[i+1];
          // Check if the next entry is part of the same grouping
          // (If grouping is disabled, lastGroupingTerm is "", so it always matches)
          bool nextIsSameGroup = !containsMultipleGroupedEntries || nextEntry.term == lastGroupingTerm;

          if (nextIsSameGroup) {
            currentText += ", ";
          }
        }
      }
    
      // Flush any remaining text at the end of the list
      if(currentText.isNotEmpty){
        texts.add(currentText);
        textColors.add(null);
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