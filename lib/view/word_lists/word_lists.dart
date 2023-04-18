import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';

import 'package:da_kanji_mobile/globals.dart';
import 'package:da_kanji_mobile/locales_keys.dart';
import 'package:da_kanji_mobile/view/word_lists/word_list_screen.dart';
import 'package:da_kanji_mobile/view/word_lists/word_list_node.dart';
import 'package:da_kanji_mobile/model/tree/tree_node.dart';
import 'package:da_kanji_mobile/model/WordLists/word_lists.dart';
import 'package:da_kanji_mobile/model/WordLists/word_lists_data.dart';



/// A widget that shows the default and user defined word lists as a tree
class WordLists extends StatefulWidget {

  /// should the focus nodes for the tutorial be included
  final bool includeTutorial;
  /// the parent of this word lists
  final TreeNode<WordListsData>? parent;
  /// should the default word lists be included
  final bool showDefaults;
  /// Callback when that is triggered when the user presses the ok button
  /// after selecting word lists / folders. Provides a list with all selected
  /// nodes
  final void Function(List<TreeNode<WordListsData>>)? onSelectionConfirmed;

  const WordLists(
    this.includeTutorial,
    this.parent,
    {
      this.showDefaults = true,
      this.onSelectionConfirmed,
      super.key
    }
  );

  @override
  State<WordLists> createState() => _WordListsState();
}

class _WordListsState extends State<WordLists> {

  /// A list with all ids from the search history
  late List<int> searchHistoryIds;
  /// is an item being dragged over the back button
  bool itemDraggingOverBack = false;
  /// did the user add a new node (folder / word list)
  TreeNode<WordListsData>? addedNewNode;
  /// Is currently an word lists node dragged over list
  bool itemDraggingOverThis = false;
  /// The index of the divider that is currently being dragged over
  int? draggingOverDividerIndex;

  @override
  Widget build(BuildContext context) {

    List<TreeNode<WordListsData>> childrenDFS = widget.parent!.DFS().toList();

    return DragTarget<TreeNode<WordListsData>>(
      onWillAccept: (data) {

        if(widget.parent!.children.contains(data)) return false;

        // mark this widget as accepting the element
        setState(() {itemDraggingOverThis = true;});
        return true;
      },
      onLeave: (data) {
        setState(() {
          itemDraggingOverThis = false;
        });
      },
      onAccept: (data) {
        setState(() {
          itemDraggingOverThis = false;
          data.parent!.removeChild(data);
          widget.parent!.addChild(data);
        });
      },
      builder: (context, candidateData, rejectedData) {
        return Container(
                            // add a divider in which lists can be dragged (eaier reorder)
                            DragTarget<TreeNode<WordListsData>>(
                              onWillAccept: (TreeNode<WordListsData>? data) {

                                // do no allow self drags
                                if(data == null || i == childrenDFS.indexOf(data)-1)
                                  return false;

                                draggingOverDividerIndex = i; 
                                return true;
                              },
                              onAccept: (data) {

                                TreeNode<WordListsData> thisNode =
                                  childrenDFS[i+1];
                                if(thisNode.parent!.value.type == WordListNodeType.folderDefault) {
                                  thisNode = childrenDFS.firstWhere((n) => 
                                    wordListUserTypes.contains(n.value.type)
                                  );
                                }

                                setState(() {
                                  data.parent!.removeChild(data);
                                  thisNode.parent!.insertChild(
                                    data, 
                                    thisNode.parent!.children.indexOf(thisNode)
                                  );
                                });
                                draggingOverDividerIndex = null;
                              },
                              onLeave: (node) {
                                setState(() {
                                  draggingOverDividerIndex = null;
                                });
                              },
                              builder: (context, candidateData, rejectedData) {
                                return Padding(
                                  padding: EdgeInsets.fromLTRB(
                                    15.0*(childrenDFS[i+1].level-1)+8, 0, 0, 0
                                  ),
                                  child: Container(
                                    height: 8,
                                    color: draggingOverDividerIndex == i
                                      ? g_Dakanji_green.withOpacity(0.5)
                                      : null, //Colors.pink.withOpacity(0.5),
                                  ),
                                );
                              }
                            )
                        ]
                        
          ),
        );
      }
    );
  }

  /// Adds a new folder / word list to the tree
  void addNewWordListNode(WordListNodeType nodeType){

    // update the tree with the new widget
    setState(() {
      addedNewNode =
        TreeNode(WordListsData("New ${nodeType.name}", nodeType, [], true));
      widget.parent!.addChild(addedNewNode!);
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
            shadowColor: Colors.grey,
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}