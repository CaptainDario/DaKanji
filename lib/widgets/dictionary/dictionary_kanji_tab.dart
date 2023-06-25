import 'package:da_kanji_mobile/domain/isar/isars.dart';
import 'package:flutter/material.dart';

import 'package:get_it/get_it.dart';
import 'package:database_builder/database_builder.dart';
import 'package:provider/provider.dart';

import 'package:da_kanji_mobile/application/dictionary/kanjidic2.dart';
import 'package:da_kanji_mobile/widgets/dictionary/kanji_card.dart';
import 'package:da_kanji_mobile/domain/settings/settings.dart';
import 'package:da_kanji_mobile/application/helper/japanese_text_processing.dart';
import 'package:da_kanji_mobile/domain/dictionary/dict_search_result.dart';
import 'package:da_kanji_mobile/application/dictionary/kanjiVG_util.dart';
import 'package:da_kanji_mobile/application/radicals/radicals.dart';



class DictionaryKanjiTab extends StatefulWidget {
  /// The entry for which examples should be shown
  final JMdict? entry;

  const DictionaryKanjiTab(
    this.entry,
    {
      Key? key
    }
  ) : super(key: key);

  @override
  State<DictionaryKanjiTab> createState() => _DictionaryKanjiTabState();
}

class _DictionaryKanjiTabState extends State<DictionaryKanjiTab> {

  /// A list with the KanjiVGs last time this widget was updated
  List<KanjiSVG> lastKanjiVGs = [];
  /// List of kanjiSVG without alternatives
  List<KanjiSVG> kanjiVGs = [];
  /// list of all entries from kanji dic 2 that should be shown
  List<Kanjidic2> kanjiDic2s = [];
  /// list of lists of all radicals that kanjis use 
  List<List<String>> radicals = [];
  /// List of KanjiSVG alternatives
  Map<String, List<KanjiSVG>> alternatives = {};
  

  @override
  void initState() {
    
    init();
    
    super.initState();
  }

  @override
  void didUpdateWidget(covariant DictionaryKanjiTab oldWidget) {
    init();
    super.didUpdateWidget(oldWidget);
  }

  /// Initializes this widget by searching aternatives in the passsed Kanjis
  void init(){

    if(context.read<DictSearch>().selectedResult == null){
      return;
    }

    // update search results
    List<String> kanjis =
      removeAllButKanji(context.read<DictSearch>().selectedResult!.kanjis);
    kanjiVGs = findMatchingKanjiSVG(kanjis);
    kanjiDic2s = findMatchingKanjiDic2(kanjis);
    radicals = kanjiDic2s.map((e) => 
      getRadicalsOf(e.character, GetIt.I<Isars>().krad.krads, GetIt.I<Isars>().radk.radks)
    ).toList();

    lastKanjiVGs = []; kanjiVGs = []; alternatives = {};

    // kanjiVG includes alternate writings of kanji therefore
    // those alternatives need to be added to the `alternatives` list
    // and removed from `widget.kanjiVGs`
    KanjiSVG? last = null;
    for (int i = 0; i < findMatchingKanjiSVG(kanjis).length; i++) {
      // if the current and last key are the same add current to alternatives
      if(last?.character == findMatchingKanjiSVG(kanjis)[i].character){
        alternatives.putIfAbsent(findMatchingKanjiSVG(kanjis)[i].character, () => []);
        alternatives[findMatchingKanjiSVG(kanjis)[i].character]!.add(findMatchingKanjiSVG(kanjis)[i]);
      }
      else
        kanjiVGs.add(findMatchingKanjiSVG(kanjis)[i]);
      
      last = findMatchingKanjiSVG(kanjis)[i];
      
    }
    
    lastKanjiVGs = findMatchingKanjiSVG(kanjis);
  }

  @override
  Widget build(BuildContext context) {

    if(context.read<DictSearch>().selectedResult == null){
      return Container();
    }
    if(kanjiVGs.isEmpty){
      return Center(
        child: Icon(Icons.search_off)
      );
    }
    else
      return SingleChildScrollView(
        child: Column(
          children: () {
            return List.generate(kanjiVGs.length, 
            (i) => DictionaryScreenKanjiCard(
              kanjiVGs[i],
              kanjiDic2s[i],
              GetIt.I<Settings>().dictionary.selectedTranslationLanguages,
              radicals[i],
              // if there are alternative writings for this kanji
              alternatives: alternatives.containsKey(kanjiVGs[i].character)
                ? alternatives[kanjiVGs[i].character]
                : null
            )
          );
          } ()
        ),
      );
  }
}