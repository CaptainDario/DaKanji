import 'dart:ui';
import 'package:flutter/material.dart';

import 'package:get_it/get_it.dart';
import 'package:tuple/tuple.dart';

import 'package:da_kanji_mobile/view/word_lists/word_list_screen.dart';
import 'package:da_kanji_mobile/model/navigation_arguments.dart';
import 'package:da_kanji_mobile/view/word_lists/word_list_node.dart';
import 'package:da_kanji_mobile/model/tree_node.dart';
import 'package:da_kanji_mobile/model/word_lists.dart';
import 'package:da_kanji_mobile/view/drawer/drawer.dart';
import 'package:da_kanji_mobile/model/screens.dart';



/// The screen for all kanji related functionalities
class WordListsScreen extends StatefulWidget {

  /// was this page opened by clicking on the tab in the drawer
  final bool openedByDrawer;
  /// should the focus nodes for the tutorial be included
  final bool includeTutorial;
  /// the parent of this word lists
  final TreeNode<Tuple3<String, WordListNodeType, List<int>>>? parent;

  const WordListsScreen(
    this.openedByDrawer,
    this.includeTutorial,
    this.parent,
    {
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
  late TreeNode<Tuple3<String, WordListNodeType, List<int>>> parent;
  /// is an item being dragged over the back button
  bool itemDraggingOverBack = false;
  /// did the user add a new node (folder / word list)
  bool addedNewNode = false;


  @override
  void initState() {
  
    parent = widget.parent ?? GetIt.I<WordLists>().root;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return DaKanjiDrawer(
      currentScreen: Screens.word_lists,
      animationAtStart: !widget.openedByDrawer,
      child: ReorderableListView(
        buildDefaultDragHandles: false,
        header: Row(
          children: [
            // back button
            if(parent.parent != null)
              DragTarget<TreeNode<Tuple3<String, WordListNodeType, List<int>>>>(
                onWillAccept: (data) {
                  setState(() {itemDraggingOverBack = true;});
                  return true;
                },
                onLeave: (data) {
                  setState(() {itemDraggingOverBack = false;});
                },
                onAccept: (data) {
                  setState(() {
                    parent.removeChild(data);
                    parent.parent!.addChild(data);
                  });
                },
                builder: (context, candidateItems, rejectedItems) {
                  return Container(
                    color: itemDraggingOverBack ? Colors.grey[300] : null,
                    child: IconButton(
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(
                          context, "/word_lists", (route) => false,
                          arguments: NavigationArguments(
                            false,
                            wordListScreenNode: parent.parent
                          )
                        );
                      },
                      icon: Icon(Icons.arrow_back)
                    ),
                  );
                }
              ),
            Expanded(child: SizedBox()),
            // add new list button
            IconButton(
              onPressed: () {
                setState(() {
                  addedNewNode = true;
                  parent.addChild(TreeNode(Tuple3("New List", WordListNodeType.wordList, [])));
                });
              },
              icon: Icon(Icons.format_list_bulleted_add)
            ), 
            // add new folder button
            IconButton(
              onPressed: () {
                setState(() {
                  addedNewNode = true;
                  parent.addChild(TreeNode(Tuple3("New folder", WordListNodeType.folder, [])));
                });
              },
              icon: Icon(Icons.create_new_folder)
            ), 
          ],
        ),
        proxyDecorator: proxyDecorator,
        children: <Widget>[
          for (int i = 0; i < parent.children.length; i++)
            WordListNode(
              parent.children[i],
              i,
              onTap: (TreeNode<Tuple3<String, WordListNodeType, List<int>>> node) {
                if(wordListFolderTypes.contains(node.value.item2)){
                  Navigator.pushNamedAndRemoveUntil(
                    context, "/word_lists", (route) => false,
                    arguments: NavigationArguments(
                      false,
                      wordListScreenNode: node
                    )
                  );
                }
                else if(wordListListypes.contains(node.value.item2)){
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
              key: Key('$i'),
              editTextOnCreate: addedNewNode && i == parent.children.length - 1 ? true : false,
            ),
        ],
        onReorder: (int oldIndex, int newIndex) {
          setState(() {
            if (oldIndex < newIndex) {
              newIndex -= 1;
            }
            final TreeNode<Tuple3<String, WordListNodeType, List<int>>> item =
              parent.children.removeAt(oldIndex);
            parent.insertChild(item, newIndex);
          });
        }
      ),
    );
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