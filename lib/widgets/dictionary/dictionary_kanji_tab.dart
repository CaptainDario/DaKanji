// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:database_builder/database_builder.dart';
import 'package:get_it/get_it.dart';

// Project imports:
import 'package:da_kanji_mobile/application/japanese_text_processing/japanese_string_operations.dart';
import 'package:da_kanji_mobile/entities/settings/settings.dart';
import 'package:da_kanji_mobile/repositories/dictionary/kanjidic2.dart';
import 'package:da_kanji_mobile/widgets/dictionary/kanji_card.dart';

class DictionaryKanjiTab extends StatefulWidget {
  /// The entry for which examples should be shown
  final JMdict? entry;

  const DictionaryKanjiTab(
    this.entry,
    {
      super.key
    }
  );

  @override
  State<DictionaryKanjiTab> createState() => _DictionaryKanjiTabState();
}

class _DictionaryKanjiTabState extends State<DictionaryKanjiTab> {

  /// List of kanji svgs to display
  List<KanjiSVG> kanjiVGs = [];
  /// list of all entries from kanji dic 2 that should be shown
  List<Kanjidic2> kanjiDic2s = [];
  

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

    if(widget.entry == null){
      return;
    }

    // update search results
    List<String> kanjis = removeAllButKanji(widget.entry!.kanjis);
    kanjiDic2s = findMatchingKanjiDic2(kanjis);
  }

  @override
  Widget build(BuildContext context) {

    if(widget.entry == null){
      return Container();
    }
    if(kanjiDic2s.isEmpty){
      return const Center(
        child: Icon(Icons.search_off)
      );
    }
    else {
      return SingleChildScrollView(
        controller: ScrollController(),
        key: Key(widget.entry!.kanjis.toString()),
        child: Column(
          children: () {
            return List.generate(kanjiDic2s.length, 
            (i) => DictionaryScreenKanjiCard(
              kanjiDic2s[i],
              GetIt.I<Settings>().dictionary.selectedTranslationLanguages,
            )
          );
          } ()
        ),
      );
    }
  }
}
