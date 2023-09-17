// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:da_kanji_mobile/data/screens.dart';
import 'package:da_kanji_mobile/widgets/drawer/drawer.dart';
import 'package:da_kanji_mobile/widgets/kanji_table/kanji_table.dart';

class KanjiTableScreen extends StatefulWidget {
  
  /// If the screen was navigated by the drawer
  final bool navigatedByDrawer;
  /// Should the tutorial be included
  final bool includeTutorial;

  const KanjiTableScreen(
    this.navigatedByDrawer,
    this.includeTutorial,
    {
      super.key
    }
  );

  @override
  State<KanjiTableScreen> createState() => _KanjiTableScreenState();
}

class _KanjiTableScreenState extends State<KanjiTableScreen> {
  @override
  Widget build(BuildContext context) {
    return DaKanjiDrawer(
      currentScreen: Screens.kanji_table,
      drawerClosed: !widget.navigatedByDrawer,
      child: KanjiTable(
        widget.includeTutorial
      )
    );
  }
}
