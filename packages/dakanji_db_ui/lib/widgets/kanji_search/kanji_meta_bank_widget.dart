import 'package:dakanji_db_core/database/kanji_meta/kanji_meta_bank_v3_entry.dart';
import 'package:dakanji_db_ui/widgets/search_results/dictionary_match_tag.dart';
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
    return DictionaryMatchTag(
      texts: widget.entries.map((e) => e.freqDisplayValue).nonNulls.toList(),
    );
  }
}