import 'package:flutter/material.dart';

import 'package:da_kanji_mobile/data/screens.dart';
import 'package:da_kanji_mobile/widgets/drawer/drawer.dart';
import '../../widgets/kanji/kanji_drawing.dart';



/// The screen for all kanji related functionalities
class KanjiTrainerScreen extends StatefulWidget {

  /// was this page opened by clicking on the tab in the drawer
  final bool openedByDrawer;
  /// should the focus nodes for the tutorial be included
  final bool includeTutorial;

  const KanjiTrainerScreen(
    this.openedByDrawer,
    this.includeTutorial,
    {
      super.key
    }
  );

  @override
  State<KanjiTrainerScreen> createState() => _KanjiTrainerScreenState();
}

class _KanjiTrainerScreenState extends State<KanjiTrainerScreen> {



  @override
  Widget build(BuildContext context) {
    return DaKanjiDrawer(
      currentScreen: Screens.kanji_trainer,
      animationAtStart: !widget.openedByDrawer,
      child: KanjiDrawingWidget(
    
      ),
    );
  }
}