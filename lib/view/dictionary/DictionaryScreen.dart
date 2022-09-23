import 'dart:math';
import 'package:da_kanji_mobile/view/dictionary/DictionaryScreenSearchResult.dart';
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

class _DictionaryScreenState extends State<DictionaryScreen> with SingleTickerProviderStateMixin {


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return DaKanjiDrawer(
      currentScreen: Screens.dictionary,
      child: ChangeNotifierProvider(
        create: (context) => DictSearch(),
        child: LayoutBuilder(
          builder: ((context, constraints) {
      
            int tabsSideBySide = min(3, (constraints.maxWidth / 500).floor()) + 1;
      
            return Stack(
              children: [
                Positioned(
                  left: 0,
                  top: 0,
                  width: constraints.maxWidth / (tabsSideBySide),
                  height: constraints.maxHeight,
                  child: DictionaryScreenSearchTab(
                    constraints.maxHeight,
                    constraints.maxWidth / (tabsSideBySide)
                  ),
                ),
                if(tabsSideBySide > 2)
                  Positioned(
                    left: constraints.maxWidth / (tabsSideBySide),
                    top: 0,
                    width: constraints.maxWidth / (tabsSideBySide),
                    height: constraints.maxHeight,
                    child: Container(
                      child: DictionaryScreenWordTab(
                        context.watch<DictSearch>().selectedResult
                      ),
                      width: constraints.maxWidth / (tabsSideBySide),
                    ),
                  ),
                if(tabsSideBySide > 3)
                  Positioned(
                    left: constraints.maxWidth / (tabsSideBySide) * 2,
                    top: 0,
                    width: constraints.maxWidth / (tabsSideBySide),
                    height: constraints.maxHeight,
                    child: DictionaryScreenKanjiTab(
                      ["鬱"],
                      ["鬱"]
                    ),
                  ),
                if(tabsSideBySide >= 4) 
                  Positioned(
                    left: constraints.maxWidth / (tabsSideBySide) * 3,
                    top: 0,
                    width: constraints.maxWidth / (tabsSideBySide),
                    height: constraints.maxHeight,
                    child: DictionaryScreenExampleTab(),
                  ),
                // dict entry tabs
                if(tabsSideBySide < 4 && tabsSideBySide > 1) 
                  Positioned(
                    left: (constraints.maxWidth / (tabsSideBySide)) * 
                      (tabsSideBySide-1),
                    top: 0,
                    width: constraints.maxWidth / (tabsSideBySide),
                    height: constraints.maxHeight,
                    child: DictionaryScreenSearchResult(
                      noTabs: 5 - tabsSideBySide, 
                    ),
                  )
              ],
            );
          })
        ),
      ),
    );
  }
}