import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:get_it/get_it.dart';
import 'package:database_builder/database_builder.dart';

import 'package:da_kanji_mobile/view/dictionary/kanji_card.dart';
import 'package:da_kanji_mobile/provider/settings/settings.dart';



class DictionaryKanjiTab extends StatefulWidget {
  const DictionaryKanjiTab(
    this.kanjiVGs,
    this.kanjidic2entries,
    {Key? key}
  ) : super(key: key);

  /// A list of KanjiVG entries that should be shown
  final List<KanjiSVG> kanjiVGs;
  /// A List of kanjidic2 entries thath should be shown
  final List<Kanjidic2> kanjidic2entries;

  @override
  State<DictionaryKanjiTab> createState() => _DictionaryKanjiTabState();
}

class _DictionaryKanjiTabState extends State<DictionaryKanjiTab> {

  /// A list with the KanjiVGs last time this widget was updated
  List<KanjiSVG> lastKanjiVGs = [];
  /// List of kanjiSVG without alternatives
  List<KanjiSVG> kanjiVGs = [];
  /// List of KanjiSVG alternatives
  Map<String, List<KanjiSVG>> alternatives = {};
  

  @override
  void initState() {
    
    init();
    
    super.initState();
  }

  /// Initializes this widget by searching aternatives in the passsed Kanjis
  void init(){
    // check that the parameters changed before doing init
    if(!listEquals(lastKanjiVGs, widget.kanjiVGs)){

      lastKanjiVGs = []; kanjiVGs = []; alternatives = {};

      // kanjiVG includes alternate writings of kanji therefore
      // those alternatives need to be added to the `alternatives` list
      // and removed from `widget.kanjiVGs`
      KanjiSVG? last = null;
      for (int i = 0; i < widget.kanjiVGs.length; i++) {
        // if the current and last key are the same add current to alternatives
        if(last?.character == widget.kanjiVGs[i].character){
          alternatives.putIfAbsent(widget.kanjiVGs[i].character, () => []);
          alternatives[widget.kanjiVGs[i].character]!.add(widget.kanjiVGs[i]);
        }
        else
          kanjiVGs.add(widget.kanjiVGs[i]);
        
        last = widget.kanjiVGs[i];
        
      }
    }
    lastKanjiVGs = widget.kanjiVGs;
  }

  @override
  Widget build(BuildContext context) {

    return widget.kanjiVGs.isEmpty || widget.kanjidic2entries.isEmpty
      ? Center(
        child: Icon(Icons.search_off)
      )
      : SingleChildScrollView(
        child: Column(
          children: () {
            return List.generate(kanjiVGs.length, 
            (i) => DictionaryScreenKanjiCard(
              kanjiVGs[i],
              widget.kanjidic2entries[i],
              GetIt.I<Settings>().dictionary.selectedTranslationLanguages,
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