// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:da_kanji_mobile/data/screens.dart';
import 'package:da_kanji_mobile/widgets/drawer/drawer.dart';

/// The screen for all kuzushiji related functionalities
class KuzushijiScreen extends StatefulWidget {

  /// was this page opened by clicking on the tab in the drawer
  final bool openedByDrawer;
  /// should the focus nodes for the tutorial be included
  final bool includeTutorial;

  const KuzushijiScreen(
    this.openedByDrawer,
    this.includeTutorial,
    {
      super.key
    }
  );

  @override
  State<KuzushijiScreen> createState() => _KuzushijiScreenState();
}

class _KuzushijiScreenState extends State<KuzushijiScreen> {



  @override
  Widget build(BuildContext context) {
    return DaKanjiDrawer(
      currentScreen: Screens.kuzushiji,
      drawerClosed: !widget.openedByDrawer,
      child: const Text(
        "崩",
        style: TextStyle(
          fontFamily: "kouzan",
          fontSize: 200
        ),
      ),
    );
  }
}
