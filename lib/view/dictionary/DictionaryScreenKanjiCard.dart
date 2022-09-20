import 'package:flutter/material.dart';

import 'package:da_kanji_mobile/view/dictionary/KanjiVGWidget.dart';
import 'package:da_kanji_mobile/view/dictionary/KanjiGroupWidget.dart';



class DictionaryScreenKanjiCard extends StatefulWidget {
  DictionaryScreenKanjiCard(
    this.kanji,
    {Key? key}
  ) : super(key: key);

  /// The kanji that should be shown in this card as a svg string
  final String kanji;

  @override
  State<DictionaryScreenKanjiCard> createState() => _DictionaryScreenKanjiCardState();
}

class _DictionaryScreenKanjiCardState extends State<DictionaryScreenKanjiCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: LayoutBuilder(
        builder: (context, constrains) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    // Kanji preview
                    KanjiVGWidget(
                      widget.kanji,
                      constrains.maxWidth * 0.5,
                      constrains.maxWidth * 0.5,
                      colorize: true,
                    ),
                    SizedBox(width: 8,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("On:"),
                        Text("Kun:"),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 8,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Strokes:"),
                    Text("Grade:"),
                    Text("JLPT:"),
                  ],
                ),
                Text("Radicals"),
                ExpansionTile(
                  title: Text("Kanji"),
                  children:
                  [
                    KanjiGroupWidget(
                      widget.kanji,
                      constrains.maxWidth - 16,
                      constrains.maxWidth - 16
                    ),
                  ]
                )
              ],
            ),
          );
        }
      )
    );
  }
}