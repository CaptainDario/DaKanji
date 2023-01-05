import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'package:isar/isar.dart';

import 'package:da_kanji_mobile/provider/isars.dart';
import 'package:da_kanji_mobile/view/word_lists/word_list.dart';
import 'package:da_kanji_mobile/view/drawer/Drawer.dart';
import 'package:da_kanji_mobile/model/screens.dart';
import 'package:da_kanji_mobile/model/search_history.dart';



/// The screen for all kanji related functionalities
class WordListsScreen extends StatefulWidget {

  /// was this page opened by clicking on the tab in the drawer
  final bool openedByDrawer;
  /// should the focus nodes for the tutorial be included
  final bool includeTutorial;

  const WordListsScreen(
    this.openedByDrawer,
    this.includeTutorial,
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

  @override
  void initState() {
    
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
    );
  }
}