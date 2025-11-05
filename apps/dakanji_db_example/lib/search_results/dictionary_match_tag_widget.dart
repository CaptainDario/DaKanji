import 'package:dakanji_db_core/database/tag/tag_bank_v3_entry.dart';
import 'package:flutter/material.dart';



/// A widget that displays a list of tags associated with a dictionary match.
class DictionaryMatchTagWidget extends StatefulWidget {

  /// The tags to display.
  final List<List<TagBankV3Entry>> tags;

  const DictionaryMatchTagWidget(this.tags, {super.key});

  @override
  State<DictionaryMatchTagWidget> createState() => _DictionaryMatchTagWidgetState();
}

class _DictionaryMatchTagWidgetState extends State<DictionaryMatchTagWidget> {

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
          GestureDetector(
            /// show snackbar
            onTap: () => ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(tag.notes)),
            ),
            child: Chip(
              labelPadding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 0.0),
              padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
              
              label: Text(
                tag.name,
                style: const TextStyle(fontSize: 11),
              ),
            ),
          )
      ],
    );
  }
}