import 'package:flutter/material.dart';

import 'package:da_kanji_mobile/provider/settings/settings.dart';
import 'package:database_builder/database_builder.dart';
import 'package:database_builder/src/kanjiVG_to_Isar/data_classes.dart' as isar_kanji;

import 'package:da_kanji_mobile/view/dictionary/kanji_card.dart';
import 'package:get_it/get_it.dart';



class DictionaryKanjiTab extends StatefulWidget {
  const DictionaryKanjiTab(
    this.kanjiVGs,
    this.kanjidic2entries,
    {Key? key}
  ) : super(key: key);

  /// A list of KanjiVG entries that should be shown
  final List<isar_kanji.KanjiSVG> kanjiVGs;
  /// A List of kanjidic2 entries thath should be shown
  final List<Kanjidic2Entry> kanjidic2entries;

  @override
  State<DictionaryKanjiTab> createState() => _DictionaryKanjiTabState();
}

class _DictionaryKanjiTabState extends State<DictionaryKanjiTab> {
  @override
  Widget build(BuildContext context) {
    return widget.kanjiVGs.isEmpty || widget.kanjidic2entries.isEmpty
      ? SizedBox()
      : SingleChildScrollView(
        child: Column(
          children: () {

            List<List<int>> idxs = [[0]];

            for (int i = 1; i < widget.kanjiVGs.length; i++) {

              // is this and the previous kanji the same
              if(widget.kanjiVGs[i-1].character == widget.kanjiVGs[i].character){
                idxs[idxs.length-1].add(i);
              }
              else{
                idxs.add([i]);
              }
            }
            return List.generate(idxs.length, 
            (i) => DictionaryScreenKanjiCard(
              widget.kanjiVGs[idxs[i][0]],
              widget.kanjidic2entries[idxs[i][0]],
              GetIt.I<Settings>().dictionary.selectedTranslationLanguages,
              // if there are alternative writings for this kanji
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