import 'package:flutter/material.dart';

import 'package:da_kanji_mobile/model/screens.dart';
import 'package:da_kanji_mobile/view/drawer/drawer.dart';
import 'kanji_drawing.dart';



/// The screen for all kanji related functionalities
class KanjiScreen extends StatefulWidget {

  /// was this page opened by clicking on the tab in the drawer
  final bool openedByDrawer;
  /// should the focus nodes for the tutorial be included
  final bool includeTutorial;

  const KanjiScreen(
    this.openedByDrawer,
    this.includeTutorial,
    {
      super.key
    }
  );

  @override
  State<KanjiScreen> createState() => _KanjiScreenState();
}

class _KanjiScreenState extends State<KanjiScreen> {



  @override
  Widget build(BuildContext context) {
    return DaKanjiDrawer(
      currentScreen: Screens.kanji,
      animationAtStart: !widget.openedByDrawer,
      child: KanjiDrawingWidget(
    
      ),
    );
  }
}