import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';

import 'package:da_kanji_mobile/globals.dart';
import 'package:da_kanji_mobile/locales_keys.dart';
import 'package:da_kanji_mobile/screens/word_list/word_list_screen.dart';
import 'package:da_kanji_mobile/widgets/word_list/word_list_node.dart';
import 'package:da_kanji_mobile/domain/tree/tree_node.dart';
import 'package:da_kanji_mobile/domain/word_lists/word_lists.dart';
import 'package:da_kanji_mobile/domain/word_lists/word_lists_data.dart';



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
          constraints: BoxConstraints.expand(),
          color: itemDraggingOverThis ? g_Dakanji_green.withOpacity(0.5) : null,
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
              Expanded(
                child: ListView(
                  children: [
                    for (int i = 0; i < childrenDFS.length; i++)
                      // Only show if the parent is expanded
                      // Only show the default lists/folder if `showDefaults` is true
                      if(!childrenDFS[i].parent!.getPath().any((n) => !n.value.isExpanded) &&
                        (widget.showDefaults || !childrenDFS[i].value.type.toString().contains("Default")))
                        ...[
                          WordListNode(
                            childrenDFS[i],
                            i,
                            onTap: (TreeNode<WordListsData> node) {
                              // if the node is a word list, navigate to the word list screen
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
                              // if the node is a folder, toggle the expanded state
                              else if(wordListFolderTypes.contains(node.value.type)) {
                                setState(() {
                                  node.value.isExpanded = !node.value.isExpanded;
                                });
                              }
                            },
                            onDragAccept: (destinationNode, thisNode) {
                              setState(() {
                            
                              });
                            },
                            onDeletePressed: (TreeNode node) {
                              setState(() {
                                node.parent!.removeChild(node);
                              });
                            },
                            onFolderPressed: (node) => setState(() {}),
                            onSelectedToggled: widget.onSelectionConfirmed == null
                              ? null
                              : (thisNode) => setState(() {}),
                            key: Key('$i'),
                            editTextOnCreate: childrenDFS[i] == addedNewNode ? true : false,
                          ),
                          
                          // if this is not the last element in the list and
                          // the next visible node is not a default node
                          if(i < childrenDFS.length - 1 &&
                            wordListUserTypes.contains(
                              childrenDFS.sublist(i+1).firstWhereOrNull(
                                (e) => e.parent!.value.isExpanded
                              )?.value.type
                            )
                          )
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
                  ],
                ),
              ),
                
                // confirm selection button if word lists are opened in selection mode
                if(widget.onSelectionConfirmed != null)
                  ...[
                    SizedBox(height: 16),
                    Divider(),
                    SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 0),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(100),
                              ),
                            ),
                          ),
                          onPressed: (){
                            List<TreeNode<WordListsData>> selection =
                              widget.parent!.DFS().where(
                                (node) => node.value.isChecked
                              ).toList();
                            widget.onSelectionConfirmed!(selection);
                          },
                          child: Text(
                            LocaleKeys.WordListsScreen_ok.tr()
                          )
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                  ]
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