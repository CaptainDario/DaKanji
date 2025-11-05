import 'package:dakanji_db_core/database/tag/tag_bank_v3_entry.dart';
import 'package:dakanji_db_example/search_results/dictionary_match_tag.dart';
import 'package:flutter/material.dart';



/// A widget that displays a list of tags associated with a dictionary match.
class DictionaryMatchTagBankWidget extends StatefulWidget {

  /// The tags to display.
  final List<List<TagBankV3Entry>> tags;

  const DictionaryMatchTagBankWidget(this.tags, {super.key});

  @override
  State<DictionaryMatchTagBankWidget> createState() => _DictionaryMatchTagBankWidgetState();
}

class _DictionaryMatchTagBankWidgetState extends State<DictionaryMatchTagBankWidget> {

  List<TagBankV3Entry> uniqueTags = [];

  @override
  void initState() {
    // get the unique tags
    final map = <String, TagBankV3Entry>{};
    for (final tag in widget.tags.expand((group) => group)) {
      map.putIfAbsent(tag.name, () => tag);
    }
    uniqueTags = map.values.toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 4.0,
      children: [
        for (final tag in uniqueTags)
          DictionaryMatchTag(tag.name, tag.notes)
      ],
    );
  }
}