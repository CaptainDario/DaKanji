import 'package:da_kanji_mobile/helper/iso/iso_table.dart';
import 'package:da_kanji_mobile/provider/settings/settings.dart';
import 'package:database_builder/database_builder.dart';
import 'package:flutter/material.dart';

import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';

import 'package:da_kanji_mobile/view/dictionary/example_sentence_card.dart';
import 'package:da_kanji_mobile/provider/isars.dart';



class DictionaryExampleTab extends StatefulWidget {

  /// The entry for which examples should be shown
  final JMdict? entry;

  const DictionaryExampleTab(
    this.entry,
    {
      Key? key
    }
  ) : super(key: key);

  @override
  State<DictionaryExampleTab> createState() => _DictionaryExampleTabState();
}

class _DictionaryExampleTabState extends State<DictionaryExampleTab> {

  /// A list of all example sentences that contain `widget.entry.kanjis.first`
  List<ExampleSentence> examples = [];


  @override
  void initState() {
    initExamples();
    super.initState();
  }

  /// Initializes the list of example sentences.
  /// Limit is the maximum number of examples to be loaded. -1 means no limit.
  void initExamples({int limit = 10}){

    if(widget.entry != null){
      var searchTerm = widget.entry!.kanjis.length != 0 ?
        widget.entry!.kanjis.first : widget.entry!.romaji.first;

      List<String> selectedLangs = 
        GetIt.I<Settings>().dictionary.selectedTranslationLanguages;

      Stopwatch stopwatch = Stopwatch()..start();
      // find all examples in ISAR that cotain this words kanji
      examples = GetIt.I<Isars>().examples.exampleSentences
        .where()
          .mecabBaseFormsElementEqualTo(searchTerm)
        .filter()
          // exclude examples that do not contain any translation in any of the
          // selected languages
          .translationsElement((q) => 
            q.anyOf(
              selectedLangs,
              (q, element) => q.languageEqualTo(isoToiso639_3[element]!.name))
          )
        .optional(limit != -1, (q) => q.limit(limit))
        
        .findAllSync();

      stopwatch.stop();
      print("filtering took ${stopwatch.elapsedMilliseconds}ms");
      stopwatch.reset();
      // sort translations by avaiablity of preferred languages
      examples.sort((a, b) {
        int aScore = 0, bScore = 0, cnt = 0;
        for (String lang in selectedLangs) {
          if(a.translations.any((trans) => isoToiso639_1[trans.language]!.name == lang))
            aScore += selectedLangs.length - cnt;
          if(b.translations.any((trans) => isoToiso639_1[trans.language]!.name == lang))
            bScore += selectedLangs.length - cnt;
        
          cnt++;
        }
        return bScore - aScore;
      });
      stopwatch.stop();
      print("sorting took ${stopwatch.elapsedMilliseconds}ms");
    }

  }

  

  @override
  void didUpdateWidget(covariant DictionaryExampleTab oldWidget) {
    initExamples();
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    if(examples.isEmpty){
      return Container();
    }

    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: examples.length,
            itemBuilder: (context, no) {
              return ExampleSentenceCard(
                examples[no]
              );
            }
          ),
        ),
        if(examples.length == 10)
          TextButton(
            onPressed: (){
              initExamples(limit: -1);
              setState(() {});
            },
            child: Text("Show more examples")
          )
      ],
    );
  }
}