import 'package:flutter/material.dart';
import 'dart:ui';

import 'package:da_kanji_mobile/view/word_lists/word_list_screen.dart';
import 'package:da_kanji_mobile/view/word_lists/word_list_node.dart';
import 'package:da_kanji_mobile/model/tree_node.dart';
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
                // Only show if the parent is expanded
                // Only show the default lists/folder if `showDefaults` is true
                if(!childrenDFS[i].parent!.getPath().any((n) => !n.value.isExpanded) &&
                  (widget.showDefaults || !childrenDFS[i].value.type.toString().contains("Default")))
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
                      setState(() {

                      });
                    },
                    onDeletePressed: (TreeNode node) {
                      setState(() {
                        widget.parent!.removeChild(widget.parent!.children[i]);
                      });
                    },
                    onFolderPressed: (node) => setState(() {}),
                    onSelectedToggled: widget.onSelectionConfirmed == null
                      ? null
                      : (thisNode) => setState(() {}),
                    key: Key('$i'),
                    editTextOnCreate: childrenDFS[i] == addedNewNode ? true : false,
                  ),
                
                // confirm selection button if word lists are opened in selection mode
                if(widget.onSelectionConfirmed != null)
                  TextButton(
                    onPressed: (){

                      List<TreeNode<WordListsData>> selection =
                        widget.parent!.DFS().where(
                          (node) => node.value.isChecked
                        ).toList();

                      widget.onSelectionConfirmed!(selection);
                    },
                    child: Text("OK")
                  ),
            ],
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