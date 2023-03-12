import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';

import 'package:da_kanji_mobile/model/navigation_arguments.dart';
import 'package:da_kanji_mobile/view/word_lists/word_list_folder_tile.dart';
import 'package:da_kanji_mobile/model/tree_node.dart';
import 'package:da_kanji_mobile/model/word_lists.dart';
import 'package:da_kanji_mobile/provider/isars.dart';
import 'package:da_kanji_mobile/view/drawer/drawer.dart';
import 'package:da_kanji_mobile/model/screens.dart';
import 'package:da_kanji_mobile/model/search_history.dart';



/// The screen for all kanji related functionalities
class WordListsScreen extends StatefulWidget {

  /// was this page opened by clicking on the tab in the drawer
  final bool openedByDrawer;
  /// should the focus nodes for the tutorial be included
  final bool includeTutorial;
  /// the parent of this word lists
  final TreeNode<String>? parent;

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
  late TreeNode<String> parent;
  /// is an item being dragged over the back button
  bool itemDraggingOverBack = false;

  @override
  void initState() {
  
    parent = widget.parent ?? GetIt.I<WordLists>().root;
    
    searchHistoryIds = GetIt.I<Isars>().searchHistory.searchHistorys.where()
      .sortByDateSearchedDesc()
      .dictEntryIdProperty()
      .findAllSync();

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
              DragTarget<TreeNode<String>>(
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
                  // TODO ADD LIST
                  print("TODO ADD LIST");
                });
              },
              icon: Icon(Icons.format_list_bulleted_add)
            ), 
            // add new folder button
            IconButton(
              onPressed: () {
                setState(() {
                  parent.addChild(TreeNode<String>("New folder"));
                });
              },
              icon: Icon(Icons.create_new_folder)
            ), 
          ],
        ),
        proxyDecorator: proxyDecorator,
        children: <Widget>[
          for (int i = 0; i < parent.children.length; i++)
            WordListFolderTile(
              parent.children[i],
              i,
              onTap: (TreeNode<String> node) {
                Navigator.pushNamedAndRemoveUntil(
                  context, "/word_lists", (route) => false,
                  arguments: NavigationArguments(
                    false,
                    wordListScreenNode: node
                  )
                );
              },
              onDragAccept: (destinationNode, thisNode) {
                setState(() {});
              },
              key: Key('$i'),
            ),
        ],
        onReorder: (int oldIndex, int newIndex) {
          setState(() {
            if (oldIndex < newIndex) {
              newIndex -= 1;
            }
            final TreeNode<String> item = parent.children.removeAt(oldIndex);
            parent.children.insert(newIndex, item);
          });
        }
      ),
      /*
      child: ListView(
        children: [
          Card(
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (context) => 
                    WordList(
                      entrySources: [],
                      entryIds: searchHistoryIds,
                      name: "Search History"
                    )
                  ),
                );
              },
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
                      child: Text("Search history"),
                    ),
                    Text("Items: ${searchHistoryIds.length}")
                  ],
                ),
              ),
            )
          )
        ],
      )
      */
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