import 'dart:math';

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
  void initExamples(){

    if(widget.entry != null){
      List<String> selectedLangs = 
        GetIt.I<Settings>().dictionary.selectedTranslationLanguages;

      // find all examples in ISAR that cotain this words kanji
      examples = GetIt.I<Isars>().dictionary.exampleSentences
        .where()
          .mecabBaseFormsElementEqualTo(widget.entry!.kanjis.first)
        .findAllSync();
      // exclude examples that do not contain any translation in any of the
      // selected languages
      examples = examples.where((example) =>
          example.translations.any((trans) => 
            GetIt.I<Settings>().dictionary.selectedTranslationLanguages.contains(
              isoToiso639_1[trans.language]!.name
            )
          )
        )
      .toList()
      // sort translations by avaiablity of preferred languages
      ..sort((a, b) {
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

    return LayoutBuilder(
      builder: (context, constraints) {
        return ListView.builder(
          itemCount: examples.length,
          itemBuilder: (context, no) {
            return ExampleSentenceCard(
              examples[no]
            );
          }
        );
      }
    );
  }
}