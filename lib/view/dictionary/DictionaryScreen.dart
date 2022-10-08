import 'dart:math';
import 'package:database_builder/database_builder.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'package:provider/provider.dart';

import 'package:da_kanji_mobile/provider/DictSearchResult.dart';
import 'package:da_kanji_mobile/model/Screens.dart';
import 'package:da_kanji_mobile/helper/JapaneseTextConversion.dart';
import 'package:da_kanji_mobile/view/dictionary/DictionaryScreenExampleTab.dart';
import 'package:da_kanji_mobile/view/dictionary/DictionaryScreenKanjiTab.dart';
import 'package:da_kanji_mobile/view/dictionary/DictionaryScreenSearchTab.dart';
import 'package:da_kanji_mobile/view/dictionary/DictionaryScreenWordTab.dart';
import 'package:da_kanji_mobile/view/drawer/Drawer.dart';



class DictionaryScreen extends StatefulWidget {

  const DictionaryScreen(
    this.openedByDrawer,
    this.includeHeroes,
    this.includeTutorial,
    this.initialSearch
  );

  /// was this page opened by clicking on the tab in the drawer
  final bool openedByDrawer;
  /// should the hero widgets for animating to the webview be included
  final bool includeHeroes;
  /// should the focus nodes for the tutorial be included
  final bool includeTutorial;
  /// the term that should be searched when this screen was opened
  final String initialSearch;

  @override
  _DictionaryScreenState createState() => _DictionaryScreenState();
}

class _DictionaryScreenState
  extends State<DictionaryScreen>
  with TickerProviderStateMixin {

  /// TabController to manage the different tabs in the dictionary
  late TabController dictionaryTabController;
  /// How many tabs should be shown side by side in the window 
  int tabsSideBySide = -1;
  /// Number of tabs in the Dictionaries TabBar
  int noTabs = -1;
  /// Function that is executed when the tab was changed
  late void Function() changeTab;
  /// Current search in the dictionary
  DictSearch search = DictSearch();
  /// A
  List<KanjiSVG> kanjiVGs = [];
  /// A List of kanjidic2 entries thath should be shown
  List<Kanjidic2Entry> kanjidic2Entries = [];

  @override
  void initState() {
    search.currentSearch = widget.initialSearch;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return DaKanjiDrawer(
      currentScreen: Screens.dictionary,
      child: ChangeNotifierProvider<DictSearch>.value(
        value: search,
        child: LayoutBuilder(
          builder: ((context, constraints) {

            // calculate how many tabs should be placed side by side
            tabsSideBySide = min(4, (constraints.maxWidth / 500).floor()) + 1;
            int newNoTabs = 5 - tabsSideBySide;

            // if the window size was changed and a different number of tabs 
            // should be shown 
            if(newNoTabs != noTabs){
              noTabs = newNoTabs;
              dictionaryTabController = TabController(length: noTabs, vsync: this);

              changeTab = () {
                // only change the tab if the tab bar includes the search tab
                if(noTabs != 4) return;
                
                // if a search result was selected change the tab
                if(context.read<DictSearch>().selectedResult != null) {
                  WidgetsBinding.instance.addPostFrameCallback((timeStamp) {         
                    dictionaryTabController.animateTo(1);
                  });
                }
              };

              context.read<DictSearch>().removeListener(changeTab);
              context.read<DictSearch>().addListener(changeTab);
            }

            // if a search result was selected
            // search the kanjis from the selected word in KanjiVG
            if(context.watch<DictSearch>().selectedResult != null){

              List<String> kanjis = 
                removeKana(context.watch<DictSearch>().selectedResult!.kanjis);

              kanjiVGs = List.generate(
                kanjis.length, (index) => 
                  GetIt.I<Box<KanjiSVG>>().query(
                    KanjiSVG_.character.equals(kanjis[index])
                  ).build().find()
              ).expand((element) => element).toList();

              kanjidic2Entries = List.generate(kanjiVGs.length, (index) =>
                GetIt.I<Box<Kanjidic2Entry>>().query(
                  Kanjidic2Entry_.literal.equals(kanjiVGs[index].character)
                ).build().find()
              ).expand((element) => element).toList();
            }
      
            return Row(
              children: [
                if(tabsSideBySide > 1)
                  SizedBox(
                    width: constraints.maxWidth / (tabsSideBySide),
                    height: constraints.maxHeight,
                    child: DictionaryScreenSearchTab(
                      constraints.maxHeight,
                      constraints.maxWidth / (tabsSideBySide),
                      context.watch<DictSearch>().currentSearch
                    ),
                  ),
                if(tabsSideBySide > 2)
                  SizedBox(
                    width: constraints.maxWidth / (tabsSideBySide),
                    height: constraints.maxHeight,
                    child: DictionaryScreenWordTab(
                      context.watch<DictSearch>().selectedResult
                    ),
                  ),
                if(tabsSideBySide > 3)
                  SizedBox(
                    width: constraints.maxWidth / (tabsSideBySide),
                    height: constraints.maxHeight,
                    child: DictionaryScreenKanjiTab(
                      kanjiVGs,
                      kanjidic2Entries
                    ),
                  ),
                if(tabsSideBySide >= 4) 
                  SizedBox(
                    width: constraints.maxWidth / (tabsSideBySide),
                    height: constraints.maxHeight,
                    child: const DictionaryScreenExampleTab(),
                  ),
                // 
                if(tabsSideBySide < 4)
                  SizedBox(
                    width: constraints.maxWidth / (tabsSideBySide),
                    height: constraints.maxHeight,
                    child: Column(
                      children: [
                        TabBar(
                          controller: dictionaryTabController,
                          tabs: [
                            if(noTabs > 3) const Tab(text: "Search"),
                            if(noTabs > 2) const Tab(text: "Word"),
                            if(noTabs > 1) const Tab(text: "Kanji"),
                            if(noTabs > 0) const Tab(text: "Example"),
                          ],
                        ),
                        Expanded(
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              return TabBarView(
                                controller: dictionaryTabController,
                                children: [
                                  if(noTabs > 3) 
                                    DictionaryScreenSearchTab(
                                      constraints.maxHeight,
                                      constraints.maxWidth,
                                      context.watch<DictSearch>().currentSearch
                                    ),
                                  if(noTabs > 2)
                                    DictionaryScreenWordTab(
                                      context.watch<DictSearch>().selectedResult
                                    ),
                                  if(noTabs > 1) 
                                    DictionaryScreenKanjiTab(
                                      kanjiVGs,
                                      kanjidic2Entries
                                    ),
                                  if(noTabs > 0) 
                                    const DictionaryScreenExampleTab(),
                                  
                                ],
                              );
                            }
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            );
          })
        ),
      ),
    );
  }
}