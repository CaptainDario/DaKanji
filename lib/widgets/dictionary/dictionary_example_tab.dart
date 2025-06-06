// Dart imports:
import 'dart:math';

// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:database_builder/database_builder.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';
import 'package:mecab_for_flutter/mecab_for_flutter.dart';
import 'package:tuple/tuple.dart';

// Project imports:
import 'package:da_kanji_mobile/entities/isar/isars.dart';
import 'package:da_kanji_mobile/entities/iso/iso_table.dart';
import 'package:da_kanji_mobile/entities/settings/settings.dart';
import 'package:da_kanji_mobile/globals.dart';
import 'package:da_kanji_mobile/locales_keys.dart';
import 'package:da_kanji_mobile/widgets/dictionary/example_sentence_card.dart';
import 'package:da_kanji_mobile/widgets/widgets/da_kanji_loading_indicator.dart';

class DictionaryExampleTab extends StatefulWidget {

  /// The entry for which examples should be shown
  final JMdict? entry;

  const DictionaryExampleTab(
    this.entry,
    {
      super.key
    }
  );

  @override
  State<DictionaryExampleTab> createState() => _DictionaryExampleTabState();
}

class _DictionaryExampleTabState extends State<DictionaryExampleTab> {

  /// A list of all example sentences that contain the given entry
  List<ExampleSentence> examples = [];
  /// The future that searches for examples in an isolate
  Future<List<ExampleSentence>>? examplesSearch;
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
  Future initExamples({int limit = 10}) async {

    if(widget.entry != null){
      List<String> selectedLangs = 
        GetIt.I<Settings>().dictionary.selectedTranslationLanguages;

      examples = await searchExamples(
        selectedLangs,
        widget.entry!.kanjis,
        widget.entry!.readings,
        widget.entry!.hiraganas,
        limit,
        GetIt.I<Isars>().examples.directory
      );

      matchSpans = getMatchSpans(widget.entry!, examples);
      return examples;

    }    
  }
  

  @override
  Widget build(BuildContext context) {

    if(widget.entry == null) {
      return Container();
    }

    return FutureBuilder(
      future: initExamples(),
      builder: (context, snapshot) {
        // Is data loading
        if(!snapshot.hasData){
          return const Center(
            child: DaKanjiLoadingIndicator()
          );
        }
        else{
          // if a result was selected, but there are no examples for it,
          // show no results icon
          if(examples.isEmpty && widget.entry != null){
            return const Center(
              child: Icon(Icons.search_off)
            );
          }
          // if no result was selected, show nothing
          else if(examples.isEmpty && widget.entry == null){
            return Container();
          }

          // Otherwise, if there are examples, show them
          return ListView.builder(
            key: Key(widget.entry!.id.toString()),
            itemCount: examples.length,
            itemBuilder: (context, no) {
              if(examples.length == 10 && no == 9) {
                return TextButton(
                  onPressed: (){
                    initExamples(limit: -1);
                    setState(() {});
                  },
                  child: Text(LocaleKeys.DictionaryScreen_examples_more.tr())
                );
              }

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

}

  /// Get a list of lists of TextSpan that mark the entry's word in the example sentences
  List<List<Tuple2<int, int>>> getMatchSpans(
    JMdict entry, List<ExampleSentence> examples){

    List<List<Tuple2<int, int>>> matchSpans = [];

    for (var e = 0; e < examples.length; e++) {
      matchSpans.add([]);

      // parse example sentence and kanjis of this entry with mecab
      String example = examples[e].sentence;
      List<TokenNode> parsedExample = GetIt.I<Mecab>().parse(example);

      for (List<String> items in [entry.kanjis, entry.readings, entry.hiraganas]){
        for (int k = 0; k < items.length; k++){
          String item = items[k];

          // does the kanji of the entry match
          int match = example.indexOf(item);
          while(match != -1) {
            if(!matchSpans.last.contains(Tuple2(match, match+item.length))){
              matchSpans.last.add(Tuple2(match, match+item.length));
            }
            match = example.indexOf(item, min(match+1, example.length));
          }
        }
      }
      
      for (int i = 0; i < parsedExample.length; i++){
        if(parsedExample[i].features.length > 5){

          int lengthToCurrentWord = parsedExample.sublist(0, i).map((e) => e.surface).join("").length;

          // get the current span and check if a highlight has already been added for it
          Tuple2<int, int> currentSpan = Tuple2(lengthToCurrentWord, lengthToCurrentWord+parsedExample[i].surface.length);
          if(matchSpans.last.contains(currentSpan)) {
            continue;
          }

          if(entry.kanjis.contains(parsedExample[i].features[6])){
            matchSpans.last.add(currentSpan);
          }
          else if(entry.readings.contains(parsedExample[i].features[6])){
            matchSpans.last.add(currentSpan);
          }
          else if(entry.hiraganas.contains(parsedExample[i].features[6])){
            matchSpans.last.add(currentSpan);
          }
        }
      }
    }
    return matchSpans;
  }

/// Searches for examples in the database that contain JMEntry.
List<ExampleSentence> _searchExamples(Tuple6 query){

  List<String> selectedLangs = query.item1;
  List<String> kanjis = query.item2;
  List<String> readings = query.item3;
  List<String> hiraganas = query.item4;
  int limit = query.item5;
  String isarPath = query.item6;
  
  // find all examples in ISAR that cotain this words kanji
  Isar examplesIsar = Isar.openSync(
    [ExampleSentenceSchema], directory: isarPath,
    name: "examples", maxSizeMiB: g_IsarExampleMaxMiB
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
      // exclude examples that do not contain any translation in any of the selected languages
      .translationsElement((q) => 
        q.anyOf(selectedLangs, (q, element) => 
          q.languageEqualTo(isoToiso639_3[element]!.name))
      )
    .optional(limit != -1, (q) => q.limit(limit))
    .findAllSync();

  /// if there are no examples try to match the word with sentence (no mecab transforms)
  if(examples.isEmpty && kanjis.isNotEmpty){
    examples = examplesIsar.exampleSentences
      .filter()
        .anyOf(kanjis, (q, kanji) => q.sentenceContains(kanji))
      .or()
        .anyOf(readings, (q, reading) => q.sentenceContains(reading, caseSensitive: false))
        // apply language filters
        .translationsElement((q) => 
          q.anyOf(selectedLangs, (q, element) => 
            q.languageEqualTo(isoToiso639_3[element]!.name))
        )
      .optional(limit != -1, (q) => q.limit(limit))
      .findAllSync();
  }

  // sort translations by availability of preferred languages
  examples.sort((a, b) {
    int aScore = 0, bScore = 0, cnt = 0;
    for (String lang in selectedLangs) {
      if(a.translations.any((trans) => isoToiso639_1[trans.language]!.name == lang)) {
        aScore += selectedLangs.length - cnt;
      }
      if(b.translations.any((trans) => isoToiso639_1[trans.language]!.name == lang)) {
        bScore += selectedLangs.length - cnt;
      }
    
      cnt++;
    }
    return bScore - aScore;
  });

  return examples;
}

/// Searches for example sentences, same as `_searchExamples` but does so in 
/// an isolate to prevent blocking the UI. Therefore, this method should be
/// preferred over `_searchExamples`
Future<List<ExampleSentence>> searchExamples(
  List<String> selectedLangs,
  List<String> kanjis,
  List<String> readings,
  List<String> hiraganas,
  int limit,
  String? directory
){

  return compute(_searchExamples, Tuple6(
    selectedLangs,
    kanjis,
    readings,
    hiraganas,
    limit,
    directory
  ));

}
