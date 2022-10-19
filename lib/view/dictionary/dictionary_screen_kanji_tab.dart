import 'package:da_kanji_mobile/provider/settings.dart';
import 'package:flutter/material.dart';

import 'package:database_builder/database_builder.dart';

import 'package:da_kanji_mobile/view/dictionary/dictionary_screen_kanji_card.dart';
import 'package:get_it/get_it.dart';



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
        children: () {

          List<List<int>> idxs = [[0]];

          for (int i = 1; i < widget.kanjiVGs.length; i++) {

            // is this and the previous kanji the same
            if(widget.kanjiVGs[i-1].character == widget.kanjiVGs[i].character){
              idxs[idxs.length-1].add(i);
            }
            else{
              idxs.add([ i]);
            }
          }
          return List.generate(idxs.length, 
          (i) => DictionaryScreenKanjiCard(
            widget.kanjiVGs[idxs[i][0]],
            widget.kanjidic2entries[idxs[i][0]],
            GetIt.I<Settings>().dictionary.selectedTranslationLanguages,
            alternatives: idxs[i].length > 1
              ? List.generate(idxs[i].length-1, 
                (j) => DictionaryScreenKanjiCard(
                  widget.kanjiVGs[idxs[i][j+1]],
                  widget.kanjidic2entries[idxs[i][j+1]],
                  GetIt.I<Settings>().dictionary.selectedTranslationLanguages,
                ) 
              )
              : null
          )
        );
        } ()
      ),
    );
  }
}