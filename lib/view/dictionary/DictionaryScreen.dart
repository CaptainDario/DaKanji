import 'dart:math';

import 'package:da_kanji_mobile/model/Screens.dart';
import 'package:da_kanji_mobile/view/dictionary/DictionaryScreenExampleTab.dart';
import 'package:da_kanji_mobile/view/dictionary/DictionaryScreenKanjiTab.dart';
import 'package:da_kanji_mobile/view/dictionary/DictionaryScreenSearchTab.dart';
import 'package:da_kanji_mobile/view/dictionary/DictionaryScreenWordTab.dart';
import 'package:da_kanji_mobile/view/drawer/Drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';



class DictionaryScreen extends StatefulWidget {

  /// was this page opened by clicking on the tab in the drawer
  final bool openedByDrawer;
  /// should the hero widgets for animating to the webview be included
  final bool includeHeroes;
  /// should the focus nodes for the tutorial be included
  final bool includeTutorial;

  DictionaryScreen(this.openedByDrawer, this.includeHeroes, this.includeTutorial);

  @override
  _DictionaryScreenState createState() => _DictionaryScreenState();
}

class _DictionaryScreenState extends State<DictionaryScreen> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {

    return DaKanjiDrawer(
      currentScreen: Screens.dictionary,
      child: LayoutBuilder(
        builder: ((context, constraints) {

          int tabsSideBySide = min(3, (constraints.maxWidth / 400).floor());

          return Row(
            children: [
              if(tabsSideBySide > 0) 
                Container(
                  child: DictionaryScreenSearchTab(
                    constraints.maxHeight,
                    constraints.maxWidth / (tabsSideBySide+1)
                  ),
                  width: constraints.maxWidth / (tabsSideBySide+1),
                ),
              if(tabsSideBySide > 1)
                Container(
                  child: DictionaryScreenWordTab(),
                  width: constraints.maxWidth / (tabsSideBySide+1),
                ),
              if(tabsSideBySide > 2)
                Container(
                  child: DictionaryScreenKanjiTab(),
                  width: constraints.maxWidth / (tabsSideBySide+1),
                ),
              if(tabsSideBySide >= 3) 
                Container(
                  child: DictionaryScreenExampleTab(),
                  width: constraints.maxWidth / (tabsSideBySide+1),
                ),
              if(tabsSideBySide < 3) Container(
                width: constraints.maxWidth / (tabsSideBySide+1),
                height: constraints.maxHeight,
                child: DefaultTabController(
                  length: 4 - tabsSideBySide,
                  child: Column(
                    children: [
                      TabBar(
                        tabs: [
                          if(tabsSideBySide < 1) Tab(text: "Search",),
                          if(tabsSideBySide < 2) Tab(text: "Word"),
                          if(tabsSideBySide < 3) Tab(text: "Kanji"),
                          if(tabsSideBySide < 4) Tab(text: "Example"),
                        ],
                      ),
                      Expanded(
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            return TabBarView(
                              children: [
                                if(tabsSideBySide < 1) DictionaryScreenSearchTab(
                                  constraints.maxHeight,
                                  constraints.maxWidth / (tabsSideBySide+1)
                                ),
                                if(tabsSideBySide < 2) DictionaryScreenWordTab(),
                                if(tabsSideBySide < 3) DictionaryScreenKanjiTab(),
                                if(tabsSideBySide < 4) DictionaryScreenExampleTab()
                              ],
                            );
                          }
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        })
      ),
    );
  }
}