import "package:collection/collection.dart";
import 'package:dakanji_db_core/data/term_meta_entry_types.dart';
import 'package:dakanji_db_core/database/term_meta/term_meta_bank_entry.dart';
import 'package:dakanji_db_example/search_results/dictionary_match_tag.dart';
import 'package:dakanji_db_example/search_results/dictionary_match_term_meta_freq_widget.dart';
import 'package:dakanji_db_example/search_results/dictionary_match_term_meta_ipa_widget.dart';
import 'package:dakanji_db_example/search_results/dictionary_match_term_meta_pitch_widget.dart';
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

    final freqMap = groupedTermMetaEntries[TermMetaBankEntryTypes.freq.name] ?? {};
    final pitchMap = groupedTermMetaEntries[TermMetaBankEntryTypes.pitch.name] ?? {};
    final ipaMap = groupedTermMetaEntries[TermMetaBankEntryTypes.ipa.name] ?? {};

    final ipaAndPitchIndexIds = {...pitchMap.keys, ...ipaMap.keys};

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // frequency entries
        if(freqMap.isNotEmpty)
          DictionaryMatchTermMetaFreqWidget(freqMap),
        SizedBox(height: 4),

        // pitch and ipa entries list
        for (final indexId in ipaAndPitchIndexIds)
          ...[
            for (final indexId in ipaAndPitchIndexIds)
              _PitchAndIpaGroup(
                indexId: indexId,
                pitchEntries: pitchMap[indexId],
                ipaEntries: ipaMap[indexId],
              ),
          ]
      ]
    );
  }
}

class _PitchAndIpaGroup extends StatelessWidget {
  final String indexId;
  final List<TermMetaBankV3Entry>? pitchEntries;
  final List<TermMetaBankV3Entry>? ipaEntries;

  const _PitchAndIpaGroup({
    required this.indexId,
    this.pitchEntries,
    this.ipaEntries,
  });

@override
  Widget build(BuildContext context) {
    // Get the title from the first available entry
    final title = (pitchEntries ?? ipaEntries)
        ?.firstOrNull
        ?.indexEntry
        .title;

    if (title == null) return const SizedBox.shrink();

    // Return the column of widgets for this group
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DictionaryMatchTag(text: title),
        const SizedBox(height: 4),

        if (pitchEntries != null) DictionaryMatchTermMetaPitchWidget(pitchEntries!),
        if (ipaEntries != null) DictionaryMatchTermMetaIpaWidget(ipaEntries!),

      ],
    );
  }

}