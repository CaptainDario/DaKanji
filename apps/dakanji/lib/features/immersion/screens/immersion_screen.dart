// Flutter imports:
// Project imports:
import 'package:da_kanji_mobile/core/routing/screens.dart';
import 'package:da_kanji_mobile/features/drawer/widgets/drawer.dart';
import 'package:da_kanji_mobile/features/reading/widgets/reading_widget.dart';
import 'package:flutter/material.dart';

class ImmersionScreen extends StatefulWidget {

  /// was this page opened by clicking on the tab in the drawer
  final bool openedByDrawer;
  /// should the focus nodes for the tutorial be included
  final bool includeTutorial;


  const ImmersionScreen(
    this.openedByDrawer,
    this.includeTutorial,
    {
      super.key
    }
  );

  @override
  State<ImmersionScreen> createState() => _ImmersionScreenState();
}

class _ImmersionScreenState extends State<ImmersionScreen> {

  @override
  Widget build(BuildContext context) {
    return DaKanjiDrawer(
      drawerClosed: !widget.openedByDrawer,
      currentScreen: Screens.immersion,
      child: ReadingWidget(
        widget.openedByDrawer,
        widget.includeTutorial
      )
    );
  }

}


