import 'package:da_db/database/tag/tag_bank_v3_entry.dart';
import 'package:da_db_ui/widgets/tag/tag_widget.dart';
import 'package:flutter/material.dart';



/// A widget that displays a list of tags associated with a dictionary match.
class TagBankWidget extends StatefulWidget {

  /// The tags to display.
  final List<List<TagBankV3Entry>> tags;

  const TagBankWidget(this.tags, {super.key});

  @override
  State<TagBankWidget> createState() => _TagBankWidgetState();
}

class _TagBankWidgetState extends State<TagBankWidget> {

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
          DictionaryMatchTag(texts: [tag.name], details: tag.notes)
      ],
    );
  }
}