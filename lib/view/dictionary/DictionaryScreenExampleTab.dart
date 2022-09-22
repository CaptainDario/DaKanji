import 'package:da_kanji_mobile/view/dictionary/ExampleSentenceCard.dart';
import 'package:flutter/material.dart';



class DictionaryScreenExampleTab extends StatefulWidget {
  DictionaryScreenExampleTab({Key? key}) : super(key: key);

  @override
  State<DictionaryScreenExampleTab> createState() => _DictionaryScreenExampleTabState();
}

class _DictionaryScreenExampleTabState extends State<DictionaryScreenExampleTab> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return AnimatedList(
          initialItemCount: 40,
          itemBuilder: (context, no, animation) {
            return ExampleSentenceCard(
              "Example: ${no.toString()}", 
              "translation: ${no.toString()}"
            );
          }
        );
      }
    );
  }
}