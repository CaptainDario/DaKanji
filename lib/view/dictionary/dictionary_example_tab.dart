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
  List<Tatoeba> examples = [];


  @override
  void initState() {
    initExamples();
    super.initState();
  }

  void initExamples(){

    if(widget.entry != null){
      examples = GetIt.I<Isars>().dictionary.tatoebas
        .where()
          .mecabBaseFormsElementEqualTo(widget.entry!.kanjis.first)
        .findAllSync();
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
        return AnimatedList(
          initialItemCount: 40,
          itemBuilder: (context, no, animation) {
            if(no >= examples.length){
              return SizedBox();
            }
            return ExampleSentenceCard(
              examples[no]
            );
          }
        );
      }
    );
  }
}