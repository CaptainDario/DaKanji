import 'package:da_kanji_mobile/view/dictionary/DictionaryScreenKanjiCard.dart';
import 'package:flutter/material.dart';



class DictionaryScreenKanjiTab extends StatefulWidget {
  DictionaryScreenKanjiTab({Key? key}) : super(key: key);

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
            
          ),
        ],
      ),
    );
  }
}