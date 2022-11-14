import 'package:da_kanji_mobile/view/dictionary/example_sentence_card.dart';
import 'package:flutter/material.dart';



class DictionaryExampleTab extends StatefulWidget {

  const DictionaryExampleTab(
    {
      Key? key
    }
  ) : super(key: key);

  @override
  State<DictionaryExampleTab> createState() => _DictionaryExampleTabState();
}

class _DictionaryExampleTabState extends State<DictionaryExampleTab> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return AnimatedList(
          initialItemCount: 40,
          itemBuilder: (context, no, animation) {
            return ExampleSentenceCard(
              null
            );
          }
        );
      }
    );
  }
}