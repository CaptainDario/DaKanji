// Flutter imports:
import 'package:da_kanji_mobile/entities/screens.dart';
import 'package:da_kanji_mobile/widgets/drawer/drawer.dart';
import 'package:da_kanji_mobile/widgets/webbrowser/webbrowser_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



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
