// Flutter imports:
import 'package:da_kanji_mobile/widgets/user/user.dart';
import 'package:flutter/material.dart';

// Package imports:

// Project imports:
import 'package:da_kanji_mobile/entities/screens.dart';
import 'package:da_kanji_mobile/widgets/drawer/drawer.dart';



class UserScreen extends StatefulWidget {

  /// was this page opened by clicking on the tab in the drawer
  final bool openedByDrawer;
  /// should the focus nodes for the tutorial be included
  final bool includeTutorial;


  const UserScreen(
    this.openedByDrawer,
    this.includeTutorial,
    {
      super.key
    }
  );

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {

  @override
  Widget build(BuildContext context) {
    return DaKanjiDrawer(
      drawerClosed: !widget.openedByDrawer,
      currentScreen: Screens.user,
      child: const User()
    );
  }

}
