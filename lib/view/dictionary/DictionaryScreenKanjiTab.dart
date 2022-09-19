import 'package:flutter/material.dart';

import 'package:da_kanji_mobile/view/dictionary/DictionaryScreenKanjiCard.dart';



class DictionaryScreenKanjiTab extends StatefulWidget {
  DictionaryScreenKanjiTab(
    this.kanjiSVGs,
    {Key? key}
  ) : super(key: key);

  /// A list of SVG strings that contain Kanjis
  final List<String> kanjiSVGs;

  @override
  State<DictionaryScreenKanjiTab> createState() => _DictionaryScreenKanjiTabState();
}

class _DictionaryScreenKanjiTabState extends State<DictionaryScreenKanjiTab> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          DictionaryScreenKanjiCard(
            widget.kanjiSVGs[0]
          ),
        ],
      ),
    );
  }
}