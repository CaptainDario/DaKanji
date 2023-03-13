import 'dart:ui';
import 'package:flutter/material.dart';

import 'package:get_it/get_it.dart';
import 'package:tuple/tuple.dart';

import 'package:da_kanji_mobile/view/word_lists/word_list_screen.dart';
import 'package:da_kanji_mobile/view/word_lists/word_list_node.dart';
import 'package:da_kanji_mobile/model/tree_node.dart';
import 'package:da_kanji_mobile/model/WordLists/word_lists.dart';
import 'package:da_kanji_mobile/model/WordLists/word_lists_data.dart';
import 'package:da_kanji_mobile/view/drawer/drawer.dart';
import 'package:da_kanji_mobile/model/screens.dart';



/// The screen for all kanji related functionalities
class WordListsScreen extends StatefulWidget {

  /// was this page opened by clicking on the tab in the drawer
  final bool openedByDrawer;
  /// should the focus nodes for the tutorial be included
  final bool includeTutorial;
  /// the parent of this word lists
  final TreeNode<WordListsData>? parent;

  const WordListsScreen(
    this.openedByDrawer,
    this.includeTutorial,
    {
      this.parent,
      super.key
    }
  );

  @override
  State<WordListsScreen> createState() => _WordListsScreenState();
}

class _WordListsScreenState extends State<WordListsScreen> {

  /// A list with all ids from the search history
  late List<int> searchHistoryIds;
  /// the root of this word lists
  late TreeNode<WordListsData> parent;
  /// is an item being dragged over the back button
  bool itemDraggingOverBack = false;
  /// did the user add a new node (folder / word list)
  TreeNode<WordListsData>? addedNewNode;
  /// Is currently an word lists node dragged over list
  bool itemDraggingOverThis = false;


  @override
  void initState() {
  
    parent = widget.parent ?? GetIt.I<WordLists>().root;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    List<TreeNode<WordListsData>> childrenDFS = parent.DFS().toList();

    return DaKanjiDrawer(
      currentScreen: Screens.word_lists,
      animationAtStart: !widget.openedByDrawer,
      child: DragTarget<TreeNode<WordListsData>>(
        onWillAccept: (data) {

          if(parent.children.contains(data)) return false;

          // mark this widget as accepting the element
          setState(() {itemDraggingOverThis = true;});
          return true;
        },
        onLeave: (data) {
          setState(() {itemDraggingOverThis = false;});
        },
        onAccept: (data) {
          setState(() {
            itemDraggingOverThis = false;
            data.parent!.removeChild(data);
            parent.addChild(data);
          });
        },
        builder: (context, candidateData, rejectedData) {
          return Container(
            color: itemDraggingOverThis ? Colors.grey[300] : null,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(child: SizedBox()),
                    // add new list button
                    IconButton(
                      onPressed: () {
                        addNewWordListNode(WordListNodeType.wordList);
                      },
                      icon: Icon(Icons.format_list_bulleted_add)
                    ), 
                    // add new folder button
                    IconButton(
                      onPressed: () {
                        addNewWordListNode(WordListNodeType.folder);
                      },
                      icon: Icon(Icons.create_new_folder)
                    ), 
                  ],
                ),
                for (int i = 0; i < childrenDFS.length; i++)
                  if(!childrenDFS[i].parent!.getPath().any((n) => !n.value.isExpanded))
                    WordListNode(
                      childrenDFS[i],
                      i,
                      onTap: (TreeNode<WordListsData> node) {
                        if(wordListListypes.contains(node.value.type)){
                          Navigator.push(
                            context, 
                            MaterialPageRoute(builder: (context) => 
                              WordListScreen(
                                node,
                              )
                            ),
                          );
                        }
                      },
                      onDragAccept: (destinationNode, thisNode) {
                        setState(() {});
                      },
                      onDeletePressed: (TreeNode node) {
                        setState(() {
                          parent.removeChild(parent.children[i]);
                        });
                      },
                      onFolderPressed: (node) => setState(() {}),
                      key: Key('$i'),
                      editTextOnCreate: childrenDFS[i] == addedNewNode ? true : false,
                    )
              ],
            ),
          );
        }
      )
    );
  }

  /// Adds a new folder / word list to the tree
  void addNewWordListNode(WordListNodeType nodeType){

    // update the tree with the new widget
    setState(() {
      addedNewNode =
        TreeNode(WordListsData("New folder", nodeType, [], true));
      parent.addChild(addedNewNode!);
    });
    // after the naming text field has focus unset `addedNewNode`
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      addedNewNode = null;
    });

  }

  Widget proxyDecorator(
    Widget child, int index, Animation<double> animation) {
    return AnimatedBuilder(
      animation: animation,
      builder: (BuildContext context, Widget? child) {
        final double animValue = Curves.easeInOut.transform(animation.value);
        final double elevation = lerpDouble(0, 6, animValue)!;
        return Center(
          child: Material(
            elevation: elevation,
            //color: Colors.grey,
            shadowColor: Colors.grey,
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}