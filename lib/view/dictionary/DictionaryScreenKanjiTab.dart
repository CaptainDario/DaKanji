import 'package:flutter/material.dart';

import 'package:database_builder/database_builder.dart';

import 'package:da_kanji_mobile/view/dictionary/DictionaryScreenKanjiCard.dart';



class DictionaryScreenKanjiTab extends StatefulWidget {
  const DictionaryScreenKanjiTab(
    this.kanjiVGs,
    this.kanjidic2entries,
    {Key? key}
  ) : super(key: key);

  /// A list of KanjiVG entries that should be shown
  final List<KanjiSVG> kanjiVGs;
  /// A List of kanjidic2 entries thath should be shown
  final List<Kanjidic2Entry> kanjidic2entries;

  @override
  State<DictionaryScreenKanjiTab> createState() => _DictionaryScreenKanjiTabState();
}

class _DictionaryScreenKanjiTabState extends State<DictionaryScreenKanjiTab> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ...List.generate(widget.kanjiVGs.length,
            (int i) => 
            DictionaryScreenKanjiCard(
              widget.kanjiVGs[i],
              widget.kanjidic2entries[i],
              "en"
            ),
          )
        ],
      ),
    );
  }
}