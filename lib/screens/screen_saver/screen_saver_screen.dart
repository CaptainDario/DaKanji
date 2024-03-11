import 'package:da_kanji_mobile/entities/tree/tree_node.dart';
import 'package:da_kanji_mobile/entities/word_lists/word_lists_data.dart';
import 'package:da_kanji_mobile/widgets/screen_saver/screen_saver.dart';
import 'package:flutter/material.dart';



class ScreenSaverScreen extends StatefulWidget {

  /// The dictionary entries to show
  final List<TreeNode<WordListsData>> wordLists;

  const ScreenSaverScreen(
    this.wordLists,
    {
      super.key
    }
  );

  @override
  State<ScreenSaverScreen> createState() => _ScreenSaverScreenState();
}

class _ScreenSaverScreenState extends State<ScreenSaverScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenSaver(
        widget.wordLists
      )
    );
  }

}