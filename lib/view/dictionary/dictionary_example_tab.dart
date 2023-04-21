import 'package:da_kanji_mobile/model/search_history.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:database_builder/database_builder.dart';
import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:da_kanji_mobile/view/dictionary/example_sentence_card.dart';
import 'package:da_kanji_mobile/provider/isars.dart';
import 'package:mecab_dart/mecab_dart.dart';
import 'package:da_kanji_mobile/helper/iso/iso_table.dart';
import 'package:da_kanji_mobile/locales_keys.dart';
import 'package:da_kanji_mobile/provider/settings/settings.dart';
import 'package:da_kanji_mobile/view/widgets/da_kanji_progress_indicator.dart';
import 'package:tuple/tuple.dart';



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

  Future<List<ExampleSentence>>? dictSearch = null;


  @override
  void initState() {
    initExamples();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant DictionaryExampleTab oldWidget) {
    initExamples();
    super.didUpdateWidget(oldWidget);
  }

  /// Initializes the list of example sentences.
  /// Limit is the maximum number of examples to be loaded. -1 means no limit.
  void initExamples({int limit = 10}){

    if(widget.entry != null){
      List<String> selectedLangs = 
        GetIt.I<Settings>().dictionary.selectedTranslationLanguages;

    
      List<String> kanjiSplits = widget.entry!.kanjis.map((e) => 
        GetIt.I<Mecab>().parse(e)
          .where((e) => e.features.length > 6)
          .map((e) => e.features[6]).toList()
      )
      .expand((e) => e)
      .toList();

      dictSearch = compute(searchExamples, Tuple7(
        selectedLangs,
        widget.entry!.kanjis,
        widget.entry!.readings,
        widget.entry!.hiraganas,
        kanjiSplits,
        limit,
        GetIt.I<Isars>().examples.directory
      )).then((value) => examples = value);
    }    

  }
  

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
      future: dictSearch,
      builder: (context, snapshot) {
        // Is data loading
        if(snapshot.connectionState != ConnectionState.done){
          return Center(
            child: DaKanjiProgressIndicator()
          );
        }
        else{
          // if a result was selected, but there are no examples for it,
          // show no results icon
          if(examples.isEmpty && widget.entry != null){
            return Center(
              child: Icon(Icons.search_off)
            );
          }
          // if no result was selected, show nothing
          else if(examples.isEmpty && widget.entry == null){
            return Container();
          }

          // Otherwise, if there are examples, show them
          return ListView.builder(
            itemCount: examples.length,
            itemBuilder: (context, no) {
              if(examples.length == 10 && no == 9)
                return TextButton(
                  onPressed: (){
                    initExamples(limit: -1);
                    setState(() {});
                  },
                  child: Text(LocaleKeys.DictionaryScreen_examples_more.tr())
                );

              return ExampleSentenceCard(
                examples[no]
              );
            }
          );
        }
      },
    );

    
  }
}

/// Searches for examples in the database that contain JMEntry.
List<ExampleSentence> searchExamples(Tuple7 query){

  List<String> selectedLangs = query.item1;
  List<String> kanjis = query.item2;
  List<String> readings = query.item3;
  List<String> hiraganas = query.item4;
  List<String> kanjiSplits = query.item5;
  int limit = query.item6;
  String isarPath = query.item7;

  print(selectedLangs);

  
  // find all examples in ISAR that cotain this words kanji
  Isar examplesIsar = Isar.openSync(
    [ExampleSentenceSchema], directory: isarPath,
    name: "examples", maxSizeMiB: 512
  );
  List<ExampleSentence> examples = examplesIsar.exampleSentences
    .where()
      // any kanji matches
        .anyOf(kanjis, (q, element) => q.mecabBaseFormsElementEqualTo(element))
      .or()
      // any reading matches
        .anyOf(readings, (q, element) => q.mecabBaseFormsElementEqualTo(element))
      .or()
      // any hiragana matches
        .anyOf(hiraganas, (q, element) => q.mecabBaseFormsElementEqualTo(element))
      
    .filter()
      // exclude examples that do not contain any translation in any of the
      // selected languages
      .translationsElement((q) => 
        q.anyOf(
          selectedLangs,
          (q, element) => q.languageEqualTo(isoToiso639_3[element]!.name))
      )
    
    
    .findAllSync();

  if(examples.isEmpty){
    examples = examplesIsar.exampleSentences
      .filter()
        // mecab splits of all kanjis must match
        .allOf(kanjiSplits, (q, e) => q.mecabBaseFormsElementEqualTo(e))
      .optional(limit != -1, (q) => q.limit(limit))
      .findAllSync();
  }

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

  print(examples.length);
  return examples;
}