import 'dart:math';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:da_kanji_mobile/provider/DictSearchResult.dart';
import 'package:da_kanji_mobile/model/Screens.dart';
import 'package:da_kanji_mobile/view/dictionary/DictionaryScreenExampleTab.dart';
import 'package:da_kanji_mobile/view/dictionary/DictionaryScreenKanjiTab.dart';
import 'package:da_kanji_mobile/view/dictionary/DictionaryScreenSearchTab.dart';
import 'package:da_kanji_mobile/view/dictionary/DictionaryScreenWordTab.dart';
import 'package:da_kanji_mobile/view/drawer/Drawer.dart';



class DictionaryScreen extends StatefulWidget {

  /// was this page opened by clicking on the tab in the drawer
  final bool openedByDrawer;
  /// should the hero widgets for animating to the webview be included
  final bool includeHeroes;
  /// should the focus nodes for the tutorial be included
  final bool includeTutorial;

  DictionaryScreen(
    this.openedByDrawer,
    this.includeHeroes,
    this.includeTutorial
  );

  @override
  _DictionaryScreenState createState() => _DictionaryScreenState();
}

class _DictionaryScreenState
  extends State<DictionaryScreen>
  with TickerProviderStateMixin {

  late TabController dictionaryTabController;

  int tabsSideBySide = -1;

  int noTabs = -1;

  late void Function() changeTab;

  DictSearch search = DictSearch();


  @override
  Widget build(BuildContext context) {

    return DaKanjiDrawer(
      currentScreen: Screens.dictionary,
      child: ChangeNotifierProvider<DictSearch>.value(
        value: search,
        child: LayoutBuilder(
          builder: ((context, constraints) {

            tabsSideBySide = min(4, (constraints.maxWidth / 500).floor()) + 1;
            int newNoTabs = 5 - tabsSideBySide;

            if(newNoTabs != noTabs){
              noTabs = newNoTabs;
              dictionaryTabController = TabController(length: noTabs, vsync: this);

              changeTab = () {
                // only change the tab if the tab bar includes the search tab
                if(noTabs != 4) return;
                
                // if a search result was selected change the tab
                if(context.read<DictSearch>().selectedResult != null)
                  // IMPORTANT: use addPostFrameCallback to avoid race condition 
                  // between `animateTo()` and `setState()`
                  WidgetsBinding.instance.addPostFrameCallback((timeStamp) {         
                    dictionaryTabController.animateTo(1);
                  });
              };

              context.read<DictSearch>().removeListener(changeTab);
              context.read<DictSearch>().addListener(changeTab);
            }
      
            return Row(
              children: [
                if(tabsSideBySide > 1)
                  Container(
                    width: constraints.maxWidth / (tabsSideBySide),
                    height: constraints.maxHeight,
                    child: DictionaryScreenSearchTab(
                      constraints.maxHeight,
                      constraints.maxWidth / (tabsSideBySide)
                    ),
                  ),
                if(tabsSideBySide > 2)
                  Container(
                    width: constraints.maxWidth / (tabsSideBySide),
                    height: constraints.maxHeight,
                    child: DictionaryScreenWordTab(
                      context.watch<DictSearch>().selectedResult
                    ),
                  ),
                if(tabsSideBySide > 3)
                  Container(
                    width: constraints.maxWidth / (tabsSideBySide),
                    height: constraints.maxHeight,
                    child: DictionaryScreenKanjiTab(
                      ["鬱"],
                      ["鬱"]
                    ),
                  ),
                if(tabsSideBySide >= 4) 
                  Container(
                    width: constraints.maxWidth / (tabsSideBySide),
                    height: constraints.maxHeight,
                    child: DictionaryScreenExampleTab(),
                  ),
                // 
                if(tabsSideBySide < 4)
                  Container(
                    width: constraints.maxWidth / (tabsSideBySide),
                    height: constraints.maxHeight,
                    child: Column(
                      children: [
                        TabBar(
                          controller: dictionaryTabController,
                          tabs: [
                            if(noTabs > 3) Tab(text: "Search"),
                            if(noTabs > 2) Tab(text: "Word"),
                            if(noTabs > 1) Tab(text: "Kanji"),
                            if(noTabs > 0) Tab(text: "Example"),
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
                                      constraints.maxWidth
                                    ),
                                  if(noTabs > 2)
                                    DictionaryScreenWordTab(
                                      context.watch<DictSearch>().selectedResult
                                    ),
                                  if(noTabs > 1) 
                                    DictionaryScreenKanjiTab(
                                      ["鬱"],
                                      ["鬱"]
                                      //[GetIt.I<Box>().get("鬱").SVG]
                                    ),
                                  if(noTabs > 0) 
                                    DictionaryScreenExampleTab(),
                                  
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