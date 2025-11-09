import "package:collection/collection.dart";
import 'package:dakanji_db_core/data/term_meta_entry_types.dart';
import 'package:dakanji_db_core/database/term_meta/term_meta_bank_entry.dart';
import 'package:dakanji_db_example/search_results/dictionary_match_term_meta_freq_widget.dart';
import 'package:flutter/material.dart';


class DictionaryMatchTermMetaWidget extends StatefulWidget {

  final List<List<TermMetaBankV3Entry>> termMetaEntries;

  const DictionaryMatchTermMetaWidget(this.termMetaEntries, {super.key});

  @override
  State<DictionaryMatchTermMetaWidget> createState() => _DictionaryMatchTermMetaWidgetState();
}

class _DictionaryMatchTermMetaWidgetState extends State<DictionaryMatchTermMetaWidget> {

  /// A list that groups frequency term meta entries by their index ID.
  late Map<String, Map<String, List<TermMetaBankV3Entry>>> groupedTermMetaEntries;

  @override
  void initState() {
    final metaEntries = widget.termMetaEntries.expand((e) => e).toSet().toList();

    // first group by type
    final groupedByType = groupBy(
      metaEntries, (TermMetaBankV3Entry e) => e.type,
    );

    /// Then nest created a nestedgroup by index ID
    groupedTermMetaEntries = groupedByType.map((typeKey, entriesForThisType) {
      final groupedByIndexId = groupBy(
        entriesForThisType, (TermMetaBankV3Entry e) => e.indexEntry.id.toString(),
      );
      return MapEntry(typeKey, groupedByIndexId);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if(groupedTermMetaEntries[TermMetaBankEntryTypes.freq.name] != null)
          DictionaryMatchTermMetaFreqWidget(groupedTermMetaEntries[TermMetaBankEntryTypes.freq.name]!)
      ]
    );
  }
}