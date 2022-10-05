import 'package:flutter/material.dart';

import 'package:database_builder/database_builder.dart';

import 'package:da_kanji_mobile/view/dictionary/DictionaryScreenKanjiCard.dart';



class DictionaryScreenKanjiTab extends StatefulWidget {
  DictionaryScreenKanjiTab(
    this.kanjiVGs,
    {Key? key}
  ) : super(key: key);

  /// A list of KanjiVG entries that should be shown
  final List<KanjiSVG> kanjiVGs;

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
              widget.kanjiVGs[i]
            ),
          )
        ],
      ),
    );
  }
}