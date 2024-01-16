// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:da_kanji_mobile/entities/screens.dart';
import 'package:da_kanji_mobile/widgets/drawer/drawer.dart';
import 'package:da_kanji_mobile/widgets/kanji_map/kanji_map.dart';

class KanjiMapScreen extends StatefulWidget {

  /// If the screen was navigated by the drawer
  final bool navigatedByDrawer;
  /// should the focus nodes for the tutorial be included
  final bool includeTutorial;

  const KanjiMapScreen(
    this.navigatedByDrawer,
    this.includeTutorial,
    {
      super.key
    }
  );

  @override
  State<KanjiMapScreen> createState() => _KanjiMapScreenState();
}

class _KanjiMapScreenState extends State<KanjiMapScreen> {
  @override
  Widget build(BuildContext context) {
    return DaKanjiDrawer(
      currentScreen: Screens.kanjiMap,
      drawerClosed: !widget.navigatedByDrawer,
      child: KanjiMap(
        widget.navigatedByDrawer,
        widget.includeTutorial,
      )
    );
  }
}
