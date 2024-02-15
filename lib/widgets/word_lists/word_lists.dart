// Dart imports:
import 'dart:math';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get_it/get_it.dart';
import 'package:drift/drift.dart' as drift;
import 'package:onboarding_overlay/onboarding_overlay.dart';

// Project imports:
import 'package:da_kanji_mobile/entities/word_lists/word_lists_sql.dart';
import 'package:da_kanji_mobile/entities/word_lists/word_lists_tree.dart';
import 'package:da_kanji_mobile/entities/show_cases/tutorials.dart';
import 'package:da_kanji_mobile/entities/tree/tree_node.dart';
import 'package:da_kanji_mobile/entities/user_data/user_data.dart';
import 'package:da_kanji_mobile/entities/word_lists/word_list_types.dart';
import 'package:da_kanji_mobile/entities/word_lists/word_lists_data.dart';
import 'package:da_kanji_mobile/globals.dart';
import 'package:da_kanji_mobile/locales_keys.dart';
import 'package:da_kanji_mobile/screens/word_lists/word_list_screen.dart';
import 'package:da_kanji_mobile/widgets/word_lists/word_list_node.dart';

/// A widget that shows the default and user defined word lists as a tree
class WordLists extends StatefulWidget {

  /// should the focus nodes for the tutorial be included
  final bool includeTutorial;
  /// the parent of this word lists
  final WordListsSQLDatabase wordLists;
  /// should the default word lists be included
  final bool showDefaults;
  /// Callback when that is triggered when the user presses the ok button
  /// after selecting word lists / folders. Provides a list with all selected
  /// nodes
  final void Function(List<TreeNode<WordListsData>>)? onSelectionConfirmed;

  const WordLists(
    this.includeTutorial,
    this.wordLists,
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

  /// The current root node, includes default lists and lists read from the sql
  /// database
  late TreeNode<WordListsData> currentRoot;
  /// A list with all ids from the search history
  late List<int> searchHistoryIds;
  /// is an item being dragged over the back button
  bool itemDraggingOverBack = false;
  /// did the user add a new node (folder / word list)
  TreeNode<WordListsData>? addedNewNode;
  /// Is currently an word lists node dragged over list
  bool itemDraggingOverThis = false;
  /// Is a WordListNode currently being dragged
  bool draggingWordListNode = false;
  /// The index of the divider that is currently being dragged over
  int? draggingOverDividerIndex;
  /// The controller for the list view
  ScrollController scrollController = ScrollController();
  /// Global key for the listview, because without a key it resets the scroll
  /// position after each setState
  final _scrollKey = GlobalKey();
  /// All word list nodes read from the database as a tree traversed in dfs
  List<TreeNode<WordListsData>> childrenDFS = [];


  @override
  void initState() {
    // after first frame
    WidgetsBinding.instance.addPostFrameCallback((Duration timeStamp) async {
      if(widget.includeTutorial){
        // init tutorial
        final OnboardingState? onboarding = Onboarding.of(context);
        if (onboarding != null && GetIt.I<UserData>().showTutorialWordLists) {
          onboarding.showWithSteps(
            GetIt.I<Tutorials>().wordListsScreenTutorial.indexes![0],
            GetIt.I<Tutorials>().wordListsScreenTutorial.indexes!
          );
        }
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return StreamBuilder<List<WordListsSQLData>>(
      stream: widget.wordLists.watchAllWordlists(),
      builder: (context, snapshot) {
        
        if(snapshot.data == null) {
          return const SizedBox();
        }
        if(snapshot.connectionState == ConnectionState.active){
          print("Reloaded");
          for (var d in snapshot.data!) {
            print(d);
          }
          currentRoot = WordListsTree.fromWordListsSQL(snapshot.data!).root;
          childrenDFS = currentRoot.dfs().toList();
        }

        return DragTarget<TreeNode<WordListsData>>(
          hitTestBehavior: HitTestBehavior.opaque,
          onWillAccept: (data) {
        
            // mark this widget as accepting the element
            itemDraggingOverThis = true;
            
            return true;
          },
          onLeave: (data) {
            itemDraggingOverThis = false;
          },
          onAccept: (data) {
            itemDraggingOverThis = false;
            data.parent!.removeChild(data);
            currentRoot.addChild(data);
            widget.wordLists.updateNode(data);
          },
          builder: (context, candidateData, rejectedData) {
            return Container(
              constraints: const BoxConstraints.expand(),
              color: itemDraggingOverThis ? g_Dakanji_green.withOpacity(0.5) : null,
              child: Stack(
                children: [
                  Column(
                    children: [
                      // header with tools
                      DragTarget<TreeNode<WordListsData>>(
                        hitTestBehavior: HitTestBehavior.opaque,
                        onWillAccept: (data) {
                          // start animation to the top of the list d
                          if(scrollController.offset > 60) {
                            scrollController.animateTo(0,
                              duration: Duration(milliseconds: scrollController.offset.round()*5),
                              curve: Curves.linear
                            );
                          }
                          return false;
                        },
                        onLeave: (data) {
                          // cancel animation
                          scrollController.position.hold(() { });
                        },
                        builder: (context, candidateData, rejectedData) {
                          return Row(
                            children: [
                              const Expanded(child: SizedBox()),
                              // add new list button
                              Focus(
                                focusNode: widget.includeTutorial
                                  ? GetIt.I<Tutorials>().wordListsScreenTutorial.focusNodes![3]
                                  : null,
                                child: IconButton(
                                  onPressed: () {
                                    addNewWordListNode(WordListNodeType.wordList);
                                  },
                                  icon: const Icon(Icons.format_list_bulleted_add)
                                ),
                              ), 
                              // add new folder button
                              Focus(
                                focusNode: widget.includeTutorial
                                  ? GetIt.I<Tutorials>().wordListsScreenTutorial.focusNodes![4]
                                  : null,
                                child: IconButton(
                                  onPressed: () {
                                    addNewWordListNode(WordListNodeType.folder);
                                  },
                                  icon: const Icon(Icons.create_new_folder)
                                ),
                              ), 
                            ],
                          );
                        }
                      ),
                      
                      // the word lists / folders
                      Expanded(
                        child: ListView(
                          key: _scrollKey,
                          controller: scrollController,
                          children: [
                            for (int i = 0; i < childrenDFS.length; i++)
                              // Only show if the parent is expanded
                              // Only show the default lists/folder if `showDefaults` is true
                              if(!childrenDFS[i].parent!.getPath().any((n) => !n.value.isExpanded) &&
                                (widget.showDefaults || !childrenDFS[i].value.type.toString().contains("Default")))
                                ...[
                                  Focus(
                                    focusNode: widget.includeTutorial && [0, 1].contains(i)
                                      ? GetIt.I<Tutorials>().wordListsScreenTutorial.focusNodes![1+i]
                                      : null,
                                    child: WordListNode(
                                      // if the tutorial should be shown, open the default lists
                                      i == 0 && widget.includeTutorial &&
                                        GetIt.I<UserData>().showTutorialWordLists
                                        ? (childrenDFS[i]..value.isExpanded=true)
                                        : childrenDFS[i],
                                      i,
                                      onDragStarted: (){
                                        draggingWordListNode = true;
                                      },
                                      onDragEnd: (){
                                        draggingWordListNode = false;
                                      },
                                      onTap: (TreeNode<WordListsData> node) {
                                        // if the node is a word list, navigate to the word list screen
                                        if(wordListListypes.contains(node.value.type)){
                                          Navigator.push(
                                            context, 
                                            MaterialPageRoute(builder: (context) => 
                                              WordListScreen(node)
                                            ),
                                          );
                                        }
                                        // if the node is a folder, toggle the expanded state (whole tile callback)
                                        else if(wordListFolderTypes.contains(node.value.type)) {
                                          node.value.isExpanded = !node.value.isExpanded;
                                          widget.wordLists.updateNode(node);
                                        }
                                      },
                                      onRenameFinished: (node) {
                                        widget.wordLists.updateNode(node);
                                      },
                                      onDragAccept: (destinationNode, node, folder) async {
                                        if(folder != null) {
                                          await widget.wordLists.addFolderWithNodes(
                                            folder,
                                            [destinationNode, node,
                                            destinationNode.parent, node.parent]);
                                        }
                                        else{
                                          await widget.wordLists.updateNodes(
                                            [destinationNode, destinationNode.parent!,
                                            node, node.parent!]
                                          );
                                        }
                                      },
                                      onDeletePressed: (TreeNode<WordListsData> node) {
                                        final parent = node.parent!;
                                        parent.removeChild(node);
                                        // TODO function to do this in one transaction
                                        widget.wordLists.updateNode(parent);
                                        widget.wordLists.deleteEntryAndSubTree(node);
                                      },
                                      onFolderPressed: (node) {
                                        widget.wordLists.updateNode(node);
                                      },
                                      onSelectedToggled: widget.onSelectionConfirmed == null
                                        ? null
                                        : (node) => setState(() {}),
                                      key: Key('$i'),
                                      editTextOnCreate: childrenDFS[i] == addedNewNode ? true : false,
                                    ),
                                  ),
                                  
                                  // if this is not the last element in the list and
                                  // the next visible node is not a default node
                                  if(i < childrenDFS.length-1 &&
                                    wordListUserTypes.contains(
                                      childrenDFS.sublist(i+1).firstWhereOrNull(
                                        (e) => e.parent!.value.isExpanded
                                      )?.value.type
                                    )
                                  )
                                  // add a divider in which lists can be dragged (easier reorder)
                                  DragTarget<TreeNode<WordListsData>>(
                                    onWillAccept: (TreeNode<WordListsData>? data) {
                              
                                      // do no allow self drags
                                      if(data == null) return false;
                              
                                      draggingOverDividerIndex = i;
                                      return true;
                                    },
                                    onAccept: (data) {
                              
                                      // do nothing on self drag
                                      if(i == childrenDFS.indexOf(data)-1) return;
                              
                                      TreeNode<WordListsData> node = childrenDFS[i+1];
                                      if(node.parent!.value.type == WordListNodeType.folderDefault) {
                                        node = childrenDFS.firstWhere((n) => 
                                          wordListUserTypes.contains(n.value.type)
                                        );
                                      }
                              
                                      data.parent!.removeChild(data);
                                      node.parent!.insertChild(data, node.parent!.children.indexOf(node));

                                      widget.wordLists.updateNodes(
                                        [data.parent!, data, node.parent!, node]);

                                      draggingOverDividerIndex = null;
                                    },
                                    onLeave: (node) {
                                      draggingOverDividerIndex = null;
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
                                ],
                            // if the list is scrollable add a gap
                            const SizedBox(
                              height: 48,
                            )
                          ],
                        ),
                      ),
                        
                      // confirm selection button if word lists are opened in selection mode
                      if(widget.onSelectionConfirmed != null)
                        ...[
                          const SizedBox(height: 16),
                          const Divider(),
                          const SizedBox(height: 8),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 0),
                            child: SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(100),
                                    ),
                                  ),
                                ),
                                onPressed: (){
                                  // TODO remap
                                  /*
                                  List<TreeNode<WordListsData>> selection =
                                    widget.parent!.dfs().where(
                                      (node) => node.value.isChecked
                                    ).toList();
                                  widget.onSelectionConfirmed!(selection);
                                  */
                                },
                                child: Text(
                                  LocaleKeys.WordListsScreen_ok.tr()
                                )
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                        ]
                    ],
                  ),
                  // the list is scrollable and
                  // the scroll position is not at the end
                  if(draggingWordListNode &&
                    !(scrollController.positions.first.pixels == scrollController.positions.first.maxScrollExtent))
                    Positioned(
                      bottom: 0,
                      child: DragTarget<TreeNode<WordListsData>>(
                        onWillAccept: (data) {
                          scrollController.animateTo(
                            scrollController.position.maxScrollExtent,
                            duration: Duration(milliseconds: 
                              max(1, ((scrollController.position.maxScrollExtent - scrollController.offset) * 5).toInt())
                            ),
                            curve: Curves.linear
                          ).then((value) => setState((){}));
                          return false;
                        },
                        onLeave: (data) {
                          scrollController.position.hold(() { });
                        },
                        builder: (context, candidateData, rejectedData) {
                          if(!draggingWordListNode) return const SizedBox();
        
                          return SizedBox(
                            height: 48,
                            width: MediaQuery.of(context).size.width,
                            //color: Theme.of(context).canvasColor,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(LocaleKeys.WordListsScreen_drag_to_scroll.tr()),
                                const Icon(Icons.arrow_downward),
                              ],
                            ),
                          );
                        }
                      ),
                    )
                ],
              ),
            );
          }
        );
      }
    );
  }

  /// Adds a new folder / word list to the tree
  void addNewWordListNode(WordListNodeType nodeType){

    addedNewNode = TreeNode(
      WordListsData("New ${nodeType.name}", nodeType, [], true));
    currentRoot.addChild(addedNewNode!);

    widget.wordLists.addNode(addedNewNode!, false);

  }
}
