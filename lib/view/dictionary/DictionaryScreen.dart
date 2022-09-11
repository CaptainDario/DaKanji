import 'package:da_kanji_mobile/model/Screens.dart';
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

class _DictionaryScreenState extends State<DictionaryScreen> {
  @override
  Widget build(BuildContext context) {
    return DaKanjiDrawer(
      currentScreen: Screens.dictionary,
      child: LayoutBuilder(
        builder: ((context, constraints) {
          return Container(
            width: constraints.maxWidth,
            height: constraints.maxHeight,
          );
        })
      ),
    );
  }
}