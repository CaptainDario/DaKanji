// Dart imports:
import 'dart:ffi';
import 'dart:math';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get_it/get_it.dart';
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
import 'package:rive/rive.dart';

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

  /// The duration for the color while hovering to animate
  int hoveringAnimationColorDuration = 100;
  /// The duration of the animation when nodes are moving in the word lists
  /// screen
  int nodeMovementAnimationDuration = 250;


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
          //print("Reloaded");
          for (var d in snapshot.data!) {
            //print(d);
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
            /// the large background area where nodes can be dropped
            return AnimatedContainer(
              duration: Duration(milliseconds: hoveringAnimationColorDuration)*2,
              constraints: const BoxConstraints.expand(),
              color: itemDraggingOverThis
                ? g_Dakanji_green.withOpacity(0.5)
                : Colors.transparent,
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
                                  onPressed: () async {
                                    await addNewWordListNode(WordListNodeType.wordList);
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
                        child: SingleChildScrollView(
                          key: _scrollKey,
                          controller: scrollController,
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: nodeMovementAnimationDuration),
                            height: (findVisibleHigherItems(childrenDFS.length).length+1) * (48+8.0),
                            width: MediaQuery.sizeOf(context).width,
                            child: Stack(
                              alignment: Alignment.topCenter,
                              children: [
                                for (int i = childrenDFS.length-1; i >= 0; i--)
                                  AnimatedPositioned(
                                    key: Key(childrenDFS[i].id.toString()),
                                    duration: Duration(milliseconds: nodeMovementAnimationDuration),
                                    curve: Curves.decelerate,
                                    height: 48+8,
                                    width: MediaQuery.sizeOf(context).width,
                                    // if any parent is collapsed
                                    top: calculateNodeTopPosition(i),
                                    child: AnimatedOpacity(
                                      key: Key(childrenDFS[i].id.toString()),
                                      duration: Duration(milliseconds: nodeMovementAnimationDuration),
                                      curve: Curves.decelerate,
                                      opacity: !childrenDFS[i].parent!.getPath().any((n) => !n.value.isExpanded)
                                        ? 1.0
                                        : 0.0,
                                      child: Column(
                                        children: [
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
                                              hoveringAnimationColorDuration: hoveringAnimationColorDuration,
                                              nodeMovementAnimationDuration: nodeMovementAnimationDuration,
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
                                                else {
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
                                              editTextOnCreate: childrenDFS[i].id == addedNewNode?.id ? true : false,
                                            ),
                                          ),
                                          
                                          // if this is not the last element in the list and
                                          // the next visible node is not a default node ...
                                          if(i < childrenDFS.length-1 &&
                                            wordListUserTypes.contains(
                                              childrenDFS.sublist(i+1).firstWhereOrNull(
                                                (e) => e.parent!.value.isExpanded)?.value.type)
                                          )
                                            // ... add a divider in which lists can be dragged (easier reorder)
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
                                                return AnimatedContainer(
                                                  duration: Duration(milliseconds: hoveringAnimationColorDuration),
                                                  curve: Curves.decelerate,
                                                  height: 8,
                                                  padding: EdgeInsets.fromLTRB(
                                                    15.0*(childrenDFS[i+1].level-1)+8, 0, 0, 0
                                                  ),
                                                  color: draggingOverDividerIndex == i
                                                    ? g_Dakanji_green.withOpacity(0.5)
                                                    : Colors.transparent
                                                );
                                              }
                                            )
                                        ],
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
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

  /// Calculates and returns the top position for the `i`-th word lists node
  double calculateNodeTopPosition(int i){

    double top = 0.0;

    // if any parent is collapsed
    if(childrenDFS[i].parent!.getPath().any((n) => !n.value.isExpanded)){
      // move this node to the position of the next un-collapsed node
      TreeNode<WordListsData> t = childrenDFS[i].parent!.getPath()
        .where((n) => !n.value.isExpanded).last;
      top = (48+8.0)*(findVisibleHigherItems(i).indexOf(t));
    }
    // no parent is collapse, check if any nodes above in the list view are collapsed
    else if(!childrenDFS.sublist(0, i).every((e) => e.value.isExpanded)){
  
      top = (48+8.0)*findVisibleHigherItems(i).length;
    }
    // nothing applies render node as list
    else{
      top = (48+8.0)*i;
    }
    
    return top;

  }

  /// Finds all visible nodes 'above' the `i`-th node in `childrenDFS`
  /// and returns them
  List<TreeNode<WordListsData>> findVisibleHigherItems(int i){
    
    List<TreeNode<WordListsData>> visibleHigherItems = [];

    for (var childDFS in childrenDFS.sublist(0, i)) {

      List<TreeNode<WordListsData>> childPath = childDFS.getPath();
      childPath = childPath.sublist(0, childPath.length-1);

      if(childPath.every((e) => e.value.isExpanded)){
        if(!visibleHigherItems.contains(childDFS)){
          visibleHigherItems.add(childDFS);
        }
      }
    }

    return visibleHigherItems;
  }

  /// Adds a new folder / word list to the tree
  Future<void> addNewWordListNode(WordListNodeType nodeType) async {

    addedNewNode = TreeNode(
      WordListsData("New ${nodeType.name}", nodeType, [], true));

    await widget.wordLists.addNodeToRoot(addedNewNode!, currentRoot);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Future.delayed(const Duration(milliseconds: 500));
      addedNewNode = null;
    });

  }

}
