import 'package:flutter/material.dart';

import 'package:da_kanji_mobile/view/dictionary/KanjiGroupWidget.dart';
import 'package:da_kanji_mobile/model/TreeNode.dart';



class DictionaryScreenKanjiCard extends StatefulWidget {
  DictionaryScreenKanjiCard({Key? key}) : super(key: key);

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
                    Container(
                      height: constrains.maxWidth * 0.33,
                      width: constrains.maxWidth * 0.33,
                      color: Colors.orange,
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
                KanjiGroupWidget(
                  () {
                    TreeNode<String> tree = TreeNode("品");
                    tree.add(TreeNode("口"));
                    tree.add(TreeNode("口"));
                    tree.add(TreeNode("口"));
                    return tree;
                  } (),
                  constrains.maxWidth,
                  constrains.maxWidth
                )
              ],
            ),
          );
        }
      )
    );
  }
}