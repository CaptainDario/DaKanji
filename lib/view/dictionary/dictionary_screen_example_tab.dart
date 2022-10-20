import 'package:da_kanji_mobile/view/dictionary/example_sentence_card.dart';
import 'package:flutter/material.dart';



class DictionaryScreenExampleTab extends StatefulWidget {

  const DictionaryScreenExampleTab(
    {
      Key? key
    }
  ) : super(key: key);

  @override
  State<DictionaryScreenExampleTab> createState() => _DictionaryScreenExampleTabState();
}

class _DictionaryScreenExampleTabState extends State<DictionaryScreenExampleTab> {
  @override
  Widget build(BuildContext context) {
    return false
      ? SizedBox()
      : LayoutBuilder(
        builder: (context, constraints) {
          return AnimatedList(
            initialItemCount: 40,
            itemBuilder: (context, no, animation) {
              return ExampleSentenceCard(
                "Example: ${no.toString()}", 
                ["translation: ${no.toString()}"]
              );
            }
          );
        }
      );
  }
}