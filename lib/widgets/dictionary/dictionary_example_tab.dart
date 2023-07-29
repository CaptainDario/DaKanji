import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:database_builder/database_builder.dart';
import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';
import 'package:mecab_dart/mecab_dart.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:tuple/tuple.dart';

import 'package:da_kanji_mobile/widgets/dictionary/example_sentence_card.dart';
import 'package:da_kanji_mobile/domain/isar/isars.dart';
import 'package:da_kanji_mobile/data/iso/iso_table.dart';
import 'package:da_kanji_mobile/locales_keys.dart';
import 'package:da_kanji_mobile/domain/settings/settings.dart';
import 'package:da_kanji_mobile/widgets/widgets/da_kanji_loading_indicator.dart';



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

  /// A list of all example sentences that contain the given entry
  List<ExampleSentence> examples = [];
  /// The future that searches for examples in an isolate
  Future<List<ExampleSentence>>? examplesSearch = null;
  /// A spans (start, end) that matched the current dict entry
  List<List<Tuple2<int, int>>> matchSpans = [];


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

      examplesSearch = (compute(searchExamples, Tuple7(
        selectedLangs,
        widget.entry!.kanjis,
        widget.entry!.readings,
        widget.entry!.hiraganas,
        kanjiSplits,
        limit,
        GetIt.I<Isars>().examples.directory
      )).then((value) {
        examples = value;
        matchSpans = getMatchSpans();
        return examples;
      }));
    }    
  }
  

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
      future: examplesSearch,
      builder: (context, snapshot) {
        // Is data loading
        if(!snapshot.hasData){
          return Center(
            child: DaKanjiLoadingIndicator()
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
                examples[no],
                matchSpans[no]
              );
            }
          );
        }
      },
    );

    
  }

  /// Get a list of lists of TextSpan that mark the entry's word in the example sentences
  List<List<Tuple2<int, int>>> getMatchSpans(){

    List<List<Tuple2<int, int>>> matchSpans = [];

    for (var i = 0; i < this.examples.length; i++) {
      matchSpans.add([]);

      // parse example sentence and kanjis of this entry with mecab
      List<TokenNode> example = GetIt.I<Mecab>().parse(examples[i].sentence);
      List<List<String>> kanjiSplits = widget.entry!.kanjis
        .map((e) => (GetIt.I<Mecab>().parse(e))
          .map((e) => e.surface).toList()..removeLast())
        .toList();

      // get index where the entry matches in the example
      for (int i = 0; i < example.length; i++){
        if(example[i].features.length > 5){

          int lengthToCurrentWord = example.sublist(0, i).map((e) => e.surface).join("").length;

          if(widget.entry!.kanjis.contains(example[i].features[6])){
            matchSpans.last.add(Tuple2(lengthToCurrentWord, lengthToCurrentWord+example[i].surface.length));
          }
          else if(widget.entry!.readings.contains(example[i].features[6])){
            matchSpans.last.add(Tuple2(lengthToCurrentWord, lengthToCurrentWord+example[i].surface.length));
          }
          else if(widget.entry!.hiraganas.contains(example[i].features[6])){
            matchSpans.last.add(Tuple2(lengthToCurrentWord, lengthToCurrentWord+example[i].surface.length));
          }
          for (List<String> kanjiSplit in kanjiSplits){
            if(i+kanjiSplit.length < example.length &&
              kanjiSplit.join("") == example.sublist(i, i+kanjiSplit.length).map((e) => e.surface).join()){
              matchSpans.last.add(Tuple2(
                lengthToCurrentWord,
                lengthToCurrentWord+
                  example.sublist(lengthToCurrentWord, kanjiSplit.length)
                  .map((e) => e.surface).join("")
                  .length
              ));
            }
          }
        }
      }
    }
    return matchSpans;
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
    .optional(limit != -1, (q) => q.limit(limit))
    .findAllSync();

  /// if there are no examples try to match mecab base forms
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