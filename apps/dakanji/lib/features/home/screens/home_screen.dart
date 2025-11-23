// Flutter imports:
import 'package:da_kanji_mobile/core/routing/screens.dart';
import 'package:da_kanji_mobile/features/drawer/widgets/drawer.dart';
import 'package:da_kanji_mobile/features/home/widgets/user.dart';
import 'package:flutter/material.dart';


class HomeScreen extends StatefulWidget {

  /// was this page opened by clicking on the tab in the drawer
  final bool openedByDrawer;
  /// should the focus nodes for the tutorial be included
  final bool includeTutorial;


  const HomeScreen(
    this.openedByDrawer,
    this.includeTutorial,
    {
      super.key
    }
  );

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return DaKanjiDrawer(
      drawerClosed: !widget.openedByDrawer,
      currentScreen: Screens.home,
      child: const User()
    );
  }

}
