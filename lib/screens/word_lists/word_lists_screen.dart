import 'package:flutter/material.dart';

import 'package:get_it/get_it.dart';

import 'package:da_kanji_mobile/domain/tree/tree_node.dart';
import 'package:da_kanji_mobile/domain/word_lists/word_lists.dart';
import 'package:da_kanji_mobile/domain/word_lists/word_lists_data.dart';
import 'package:da_kanji_mobile/widgets/word_lists/word_lists.dart' as word_lists;
import 'package:da_kanji_mobile/widgets/drawer/drawer.dart';
import 'package:da_kanji_mobile/data/screens.dart';



/// The screen for all word lists related functionalities
class WordListsScreen extends StatefulWidget {

  /// was this page opened by clicking on the tab in the drawer
  final bool openedByDrawer;
  /// should the focus nodes for the tutorial be included
  final bool includeTutorial;
  /// the parent of this word lists
  final TreeNode<WordListsData>? parent;
  /// Callback when that is triggered when the user presses the ok button
  /// after selecting word lists
  final void Function(List<TreeNode<WordListsData>>)? onSelectionConfirmed;


  const WordListsScreen(
    this.openedByDrawer,
    this.includeTutorial,
    {
      this.onSelectionConfirmed,
      this.parent,
      super.key
    }
  );

  @override
  State<WordListsScreen> createState() => _WordListsScreenState();
}

class _WordListsScreenState extends State<WordListsScreen> {

  /// the root of this word lists
  late TreeNode<WordListsData> parent;


  @override
  void initState() {
  
    parent = widget.parent ?? GetIt.I<WordLists>().root;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return DaKanjiDrawer(
      currentScreen: Screens.wordLists,
      animationAtStart: !widget.openedByDrawer,
      child: word_lists.WordLists(
        widget.includeTutorial,
        parent,
        onSelectionConfirmed: widget.onSelectionConfirmed,
      ),
    );
  }

}