


// Flutter imports:
import 'package:da_kanji_mobile/entities/word_lists/word_lists_sql.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:get_it/get_it.dart';

// Project imports:
import 'package:da_kanji_mobile/entities/screens.dart';
import 'package:da_kanji_mobile/entities/tree/tree_node.dart';
import 'package:da_kanji_mobile/entities/word_lists/word_lists_tree.dart';
import 'package:da_kanji_mobile/entities/word_lists/word_lists_data.dart';
import 'package:da_kanji_mobile/widgets/drawer/drawer.dart';
import 'package:da_kanji_mobile/widgets/word_lists/word_lists.dart' as word_lists;

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

  /// The word lists database
  late WordListsSQLDatabase wordLists;


  @override
  void initState() {
  
    wordLists = GetIt.I<WordListsSQLDatabase>();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return DaKanjiDrawer(
      currentScreen: Screens.wordLists,
      drawerClosed: !widget.openedByDrawer,
      child: word_lists.WordLists(
        widget.includeTutorial,
        wordLists,
        onSelectionConfirmed: widget.onSelectionConfirmed,
      ),
    );
  }

}
