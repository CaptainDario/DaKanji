import 'package:collection/collection.dart';
import 'package:da_db/database/kanji_meta/kanji_meta_bank_v3_entry.dart';
import 'package:da_kanji_mobile/features/dictionary/widgets/tag/tag_widget.dart';
import 'package:flutter/material.dart';



class KanjiMetaBankWidget extends StatefulWidget {
  
  final List<KanjiMetaBankV3Entry> entries;

  const KanjiMetaBankWidget(
    this.entries,
    {
      super.key
    }
  );

  @override
  State<KanjiMetaBankWidget> createState() => _KanjiMetaBankWidgetState();
}

class _KanjiMetaBankWidgetState extends State<KanjiMetaBankWidget> {

  @override
  Widget build(BuildContext context) {
    
    if(widget.entries.isEmpty) return SizedBox();
    
    return DictionaryMatchTag(
      // for kanji there are no grouping options so the first entry is fine
      leadingText: widget.entries.first.indexEntry.title,
      texts: widget.entries
        .map((e) => (e.freqValue?.toString()) ?? e.freqDisplayValue)
        .nonNulls
        .mapIndexed((index, e) => e + (index < widget.entries.length - 1 ? ", " : ""))
        .toList(),
    );
  }
}