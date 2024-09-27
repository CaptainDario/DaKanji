// Flutter imports:
import 'package:da_kanji_mobile/widgets/reading/reading_widget.dart';
import 'package:flutter/material.dart';

// Project imports:
import 'package:da_kanji_mobile/entities/screens.dart';
import 'package:da_kanji_mobile/widgets/drawer/drawer.dart';

class ReadingScreen extends StatefulWidget {

  /// was this page opened by clicking on the tab in the drawer
  final bool openedByDrawer;
  /// should the focus nodes for the tutorial be included
  final bool includeTutorial;


  const ReadingScreen(
    this.openedByDrawer,
    this.includeTutorial,
    {
      super.key
    }
  );

  @override
  State<ReadingScreen> createState() => _ReadingScreenState();
}

class _ReadingScreenState extends State<ReadingScreen> {

  @override
  Widget build(BuildContext context) {
    return DaKanjiDrawer(
      drawerClosed: !widget.openedByDrawer,
      currentScreen: Screens.reading,
      child: const ReadingWidget()
    );
  }

}
