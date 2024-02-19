// Dart imports:
import 'dart:math';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:get_it/get_it.dart';
import 'package:onboarding_overlay/onboarding_overlay.dart';

// Project imports:
import 'package:da_kanji_mobile/entities/show_cases/tutorials.dart';
import 'package:da_kanji_mobile/entities/tree/tree_node.dart';
import 'package:da_kanji_mobile/entities/user_data/user_data.dart';
import 'package:da_kanji_mobile/entities/word_lists/word_list_types.dart';
import 'package:da_kanji_mobile/entities/word_lists/word_lists_data.dart';
import 'package:da_kanji_mobile/entities/word_lists/word_lists_sql.dart';
import 'package:da_kanji_mobile/entities/word_lists/word_lists_tree.dart';
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
  /// did the user add a new node (folder / word list)
  TreeNode<WordListsData>? addedNewNode;
  /// Is currently a word lists node dragged over the toolbar
  bool itemDraggingOverToolbar = false;
  /// Is currently a word lists node dragged over the empty bottom section
  bool itemDraggingOverBottom = false;
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

  /// [FocusNode] of the search field
  FocusNode searchInputFocusNode = FocusNode();
  /// The [TextEditingController] to handle the search inputs
  TextEditingController searchTextEditingController = TextEditingController();

  /// List of bools that indicate which nodes are currently not being shown
  /// When switching a false to a true the correseponding entry will be animated
  List<bool> animateListTileIn = [];
  /// The duration for the color while hovering to animate
  int hoveringAnimationColorDuration = 100;
  /// The duration of the animation when nodes are moving in the word lists
  /// screen
  int nodeMovementAnimationDuration = 250;
  /// The delay before the slidin in of the word list nodes starts
  int slideInAnimationDelay = 250;
  /// The time between starting the slide in transitions of the word list nodes
  /// * first node slides in at time `slideInDelay`,
  /// * seconds node slides in at time `slideInDelay + staggerAnimationInteleaveDuration`
  int staggerAnimationInteleaveDuration = 50;


  @override
  void initState() {

    // listen to focus changes of the search bar
    // this is needed so that when the user clicks out of the searchbar, the
    // underline disappears
    searchInputFocusNode.addListener(() {setState((){});});

    // listen to changes in the search filter
    searchTextEditingController.addListener(textEditingListener);

    // after first frame
    WidgetsBinding.instance.addPostFrameCallback((Duration timeStamp) async {
      
      // show the tutorial if necessary
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

    searchTextEditingController.removeListener(() {setState((){});});

    searchTextEditingController.removeListener(() { setState(() {});});

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
        if(snapshot.connectionState == ConnectionState.active &&
          !draggingWordListNode){
          currentRoot = WordListsTree.fromWordListsSQL(snapshot.data!).root;
          childrenDFS = currentRoot.dfs()
            // apply filter
            .where((e) => e.value.name.contains(searchTextEditingController.text))
            .toList();
          animateListTilesIn();
        }

        return LayoutBuilder(
          builder: (context, constraints) {
            return Stack(
              children: [
                Column(
                  children: [
                    // header with tools
                    DragTarget<TreeNode<WordListsData>>(
                      hitTestBehavior: HitTestBehavior.opaque,
                      onWillAccept: (data) {
                        // start animation to the top of the list
                        if(scrollController.offset > 60) {
                          scrollController.animateTo(0,
                            duration: Duration(milliseconds: scrollController.offset.round()*5),
                            curve: Curves.linear
                          );
                        }
                        itemDraggingOverToolbar = true;
                        return true;
                      },
                      onLeave: (data) {
                        // cancel animation
                        scrollController.position.hold(() { });
                        itemDraggingOverToolbar = false;
                      },
                      onAccept: (data) {
                        itemDraggingOverToolbar = false;
                        final oldParent = data.parent!;
                        oldParent.removeChild(data);
                        currentRoot.insertChild(data, 0);
                        widget.wordLists.updateNodes([currentRoot, oldParent]);
                      },
                      builder: (context, candidateData, rejectedData) {
                        return AnimatedContainer(
                          height: 40,
                          duration: Duration(milliseconds: hoveringAnimationColorDuration),
                          color: itemDraggingOverToolbar
                            ? g_Dakanji_green.withOpacity(0.5)
                            : Colors.transparent,
                          child: Row(
                            children: [
                              const SizedBox(width: 16,),
                              IconButton(
                                icon: const Icon(Icons.search),
                                onPressed: () {
                                  searchInputFocusNode.requestFocus();
                                  setState(() {});
                                },
                              ),
                              const SizedBox(width: 16,),
                              Expanded(
                                child: TextField(
                                  controller: searchTextEditingController,
                                  focusNode: searchInputFocusNode,
                                  decoration: searchInputFocusNode.hasPrimaryFocus
                                    ? const InputDecoration()
                                    : const InputDecoration.collapsed(
                                      hintText: ""
                                    ),
                                )
                              ),
                              const SizedBox(width: 16,),
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
                          ),
                        );
                      }
                    ),
                    
                    // the word lists / folders
                    Expanded(
                      child: SingleChildScrollView(
                        key: _scrollKey,
                        controller: scrollController,
                        child: AnimatedContainer(
                          curve: Curves.decelerate,
                          duration: Duration(milliseconds: nodeMovementAnimationDuration),
                          // for each node (48+8)
                          // + 48 at the end so that the scroll indicator has space
                          height: (findVisibleHigherItems(childrenDFS.length).length) * (48+8.0) + 48
                            + (draggingOverDividerIndex != null ? 30 : 8),
                          width: constraints.maxWidth,
                          child: Stack(
                            alignment: Alignment.topCenter,
                            children: [
                              for (int i = childrenDFS.length-1; i >= 0; i--)
                                AnimatedPositioned(
                                  key: Key("AnimatedPositioned_${childrenDFS[i].id}"),
                                  duration: Duration(milliseconds: nodeMovementAnimationDuration),
                                  curve: Curves.decelerate,
                                  height: 48+8 + (draggingOverDividerIndex != null ? 30 : 8),
                                  width: constraints.maxWidth,
                                  // if any parent is collapsed
                                  top: calculateNodeTopPosition(i),
                                  left: animateListTileIn[i] ? 0 : constraints.maxWidth,
                                  child: AnimatedOpacity(
                                    key: Key("AnimatedOpacity_${childrenDFS[i].id}"),
                                    duration: Duration(milliseconds: nodeMovementAnimationDuration),
                                    curve: Curves.decelerate,
                                    opacity: !childrenDFS[i].parent!.getPath().any((n) => !n.value.isExpanded) ||
                                      searchMatches(childrenDFS[i].value.name)
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
                                              setState(() => draggingWordListNode = true);
                                            },
                                            onDragEnd: (){
                                              setState(() => draggingWordListNode = false);
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
                                            onWillDragAccept: (node, other) {
                                              setState(() {
                                                draggingOverDividerIndex = null;
                                              });
                                            },
                                            onDragAccept: dragNodeOnNodeAccept,
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
                                              : (node) {},
                                            key: Key('$i'),
                                            editTextOnCreate: childrenDFS[i].id == addedNewNode?.id ? true : false,
                                          ),
                                        ),
                                        
                                        // if the next visible node is not a default node ...
                                        if(wordListUserTypes.contains(childrenDFS[i].value.type))
                                          // ... add a divider in which lists can be dragged (easier reorder)
                                          DragTarget<TreeNode<WordListsData>>(
                                            onWillAccept: (TreeNode<WordListsData>? data) {
                                      
                                              // do no allow self drags
                                              if(data == null) return false;
                                      
                                              draggingOverDividerIndex = i;
                                              setState(() {});
                                              return true;
                                            },
                                            onAccept: (data) {
                                      
                                              // do nothing on self drag
                                              if(i == childrenDFS.indexOf(data)-1) {
                                                draggingOverDividerIndex = null;
                                                return;
                                              }
                                      
                                              TreeNode<WordListsData> node = childrenDFS[i+1];
                                              if(node.parent!.value.type == WordListNodeType.folderDefault) {
                                                node = childrenDFS.firstWhere((n) => 
                                                  wordListUserTypes.contains(n.value.type)
                                                );
                                              }
                                      
                                              final oldParent = data.parent!;
                                              oldParent.removeChild(data);
                                              node.parent!.insertChild(data, node.parent!.children.indexOf(node));
                                                                      
                                              widget.wordLists.updateNodes(
                                                [data.parent!, data, node.parent!, node, oldParent]);
                                                                      
                                              draggingOverDividerIndex = null;
                                            },
                                            onLeave: (node) {
                                              draggingOverDividerIndex = null;
                                            },
                                            builder: (context, candidateData, rejectedData) {
                                              return AnimatedContainer(
                                                duration: Duration(milliseconds: nodeMovementAnimationDuration),
                                                curve: Curves.decelerate,
                                                height: draggingOverDividerIndex == i ? 30 : 8,
                                                padding: EdgeInsets.fromLTRB(
                                                  15.0*(childrenDFS[i].level-1)+8, 0, 0, 0
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

                // container at the bottom where a node can be dragged to scroll
                Positioned(
                  bottom: 0,
                  child: AnimatedOpacity(
                    duration: Duration(milliseconds: hoveringAnimationColorDuration),
                    opacity: draggingWordListNode ? 1.0 : 0.0,
                    child: DragTarget<TreeNode<WordListsData>>(
                      onWillAccept: (data) {
                  
                        itemDraggingOverBottom = true;
                  
                        scrollController.animateTo(
                          scrollController.position.maxScrollExtent,
                          duration: Duration(milliseconds: 
                            max(1, ((scrollController.position.maxScrollExtent - scrollController.offset) * 5).toInt())
                          ),
                          curve: Curves.linear
                        ).then((value) => setState((){}));

                        return true;
                      },
                      onLeave: (data) {
                        itemDraggingOverBottom = false;
                        scrollController.position.hold(() { });
                      },
                      onAccept: (data) {
                        final oldParent = data.parent!;
                        oldParent.removeChild(data);
                        currentRoot.addChild(data);
                        widget.wordLists.updateNodes([currentRoot, oldParent]);
                      },
                      builder: (context, candidateData, rejectedData) {
                        if(!draggingWordListNode) return const SizedBox();
                    
                        return AnimatedContainer(
                          height: 48,
                          duration: Duration(milliseconds: hoveringAnimationColorDuration),
                          color: itemDraggingOverBottom
                            ? g_Dakanji_green.withOpacity(0.5)
                            : Colors.transparent,
                          width: MediaQuery.of(context).size.width,
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
                  ),
                )
              ],
            );
          }
        );
      }
    );
  }

  /// Callback that is attached to `searchTextEditingController`
  void textEditingListener(){

    setState(() {});
  
  }

  /// Does the current search term match the given `item`
  /// 
  /// Caution: This does not match if the searchbar is empty
  bool searchMatches(String item){

    if(searchTextEditingController.text.isNotEmpty &&
      item.contains(searchTextEditingController.text)){
        return true;
    }

    return false;

  }

  /// Animates all List tiles in, in a staggered fashion
  Future animateListTilesIn() async {

    // if there are no values set for the slide in animation, slide all in
    if(animateListTileIn.isEmpty){
      animateListTileIn = List.filled(childrenDFS.length, false, growable: true);

      // after the first frame wait short amount of time ...
      Future.delayed(Duration(milliseconds: slideInAnimationDelay)).then((result) async {
        // ... and animate each tile staggered in
        for (int i = 0; i < childrenDFS.length; i++) {
          await Future.delayed(Duration(milliseconds: staggerAnimationInteleaveDuration));
          setState(() => animateListTileIn[i] = true);
        }
      });
    }
    else{
      // a new node was added
      if(animateListTileIn.length < childrenDFS.length){

        // set same length
        int animateInOldLen = animateListTileIn.length;
        animateListTileIn.addAll(
          List.filled(childrenDFS.length-animateInOldLen, false, growable: true));

        // animate new entries staggered in
        for (var i = animateInOldLen; i < animateListTileIn.length; i++) {
          await Future.delayed(Duration(milliseconds: staggerAnimationInteleaveDuration));
          try {
            animateListTileIn[i] = true;
          } catch (e) {
            return;
          }
          setState(() {});
        }
      }
      // if the same amount exists, do nothing ?
      else if(animateListTileIn.length == childrenDFS.length){
        
      }
      // a node has been removed
      else if(animateListTileIn.length > childrenDFS.length){
        animateListTileIn = List.filled(childrenDFS.length, true, growable: true);
      }
    }
  }

  /// Callback that is triggered when the drag of one node onto another is
  /// accepted
  Future dragNodeOnNodeAccept(destinationNode, node, folder, otherAffected) async {

    // a new folder has been created
    if(folder != null) {
      // do not animate the folder
      animateListTileIn.add(true);
      await widget.wordLists.addFolderWithNodes(
        folder,
        [destinationNode, node, ...otherAffected]);
    }
    // a node has been moved without new folder
    else {
      await widget.wordLists.updateNodes(
        [destinationNode, node, ...otherAffected]
      );
    }

  }

  /// Calculates and returns the top position for the `i`-th word lists node
  double calculateNodeTopPosition(int i){

    double top = 0.0;

    // check if search filters are set
    if(searchMatches(childrenDFS[i].value.name)){
      top = (48+8.0)*i;
    }
    // if not, calculate positions for whole tree
    else {
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
    }

    // if this node is after the divider over which is currently being dragged,
    // add additional space
    if(draggingOverDividerIndex != null && draggingOverDividerIndex! < i){
      top += 24;
    }
    
    return top;

  }

  /// Finds all visible nodes 'above' the `i`-th node in `childrenDFS`
  /// and returns them
  List<TreeNode<WordListsData>> findVisibleHigherItems(int i){
    
    // all items that should be visible 'above' this node in the list
    List<TreeNode<WordListsData>> visibleHigherItems = [];

    for (var childDFS in childrenDFS.sublist(0, i)) {

      // get the path to this node without this node
      List<TreeNode<WordListsData>> childPath = childDFS.getPath();
      childPath = childPath.sublist(0, childPath.length-1);

      // every child is expanded and this node is not already marked as visible
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
      await Future.delayed(const Duration(milliseconds: 100));
      addedNewNode = null;
    });

  }

}
