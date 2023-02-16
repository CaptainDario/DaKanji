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
      examples = GetIt.I<Isars>().dictionary.exampleSentences
        .where()
          .mecabBaseFormsElementEqualTo(widget.entry!.kanjis.first)
        .findAllSync();
      examples = examples.where((example) =>
          example.translations.any((trans) => 
            GetIt.I<Settings>().dictionary.selectedTranslationLanguages.contains(
              isoToiso639_1[trans.language]!.name
            )
          )
        ).toList();
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