// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Project imports:
import 'package:da_kanji_mobile/core/routing/screens.dart';
import 'package:da_kanji_mobile/features/drawer/widgets/drawer.dart';
import 'package:da_kanji_mobile/features/webbrowser/widgets/webbrowser_widget.dart';

class WebBrowserScreen extends StatefulWidget {

  /// was this page opened by clicking on the tab in the drawer
  final bool openedByDrawer;
  /// should the focus nodes for the tutorial be included
  final bool includeTutorial;

  const WebBrowserScreen(
    this.openedByDrawer,
    this.includeTutorial,
    {
      super.key
    }
  );

  @override
  State<WebBrowserScreen> createState() => _WebBrowserScreenState();
}

class _WebBrowserScreenState extends State<WebBrowserScreen> {

  @override
  Widget build(BuildContext context) {
    return DaKanjiDrawer(
      currentScreen: Screens.webbrowser,
      drawerClosed: !widget.openedByDrawer,
      child: WebbrowserWidget(
        widget.openedByDrawer,
        widget.includeTutorial
      )
    );
  }

}
