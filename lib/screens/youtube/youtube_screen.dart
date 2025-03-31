// Flutter imports:
import 'package:da_kanji_mobile/widgets/youtube/youtube_iframe_player.dart';
import 'package:flutter/material.dart';

// Project imports:
import 'package:da_kanji_mobile/entities/screens.dart';
import 'package:da_kanji_mobile/widgets/drawer/drawer.dart';
import 'package:da_kanji_mobile/widgets/youtube/youtube_widget.dart';

class YoutubeScreen extends StatefulWidget {

  /// was this page opened by clicking on the tab in the drawer
  final bool openedByDrawer;
  /// should the focus nodes for the tutorial be included
  final bool includeTutorial;


  const YoutubeScreen(
    this.openedByDrawer,
    this.includeTutorial,
    {
      super.key
    }
  );

  @override
  State<YoutubeScreen> createState() => _YoutubeScreenState();
}

class _YoutubeScreenState extends State<YoutubeScreen> {

  @override
  Widget build(BuildContext context) {
    return DaKanjiDrawer(
      drawerClosed: !widget.openedByDrawer,
      currentScreen: Screens.youtube,
      child: true 
        ? YoutubeIframePlayer(
          "https://www.youtube.com/watch?v=hz6oys4Eem4"
        )
        : YoutubeWidget(
          widget.openedByDrawer,
          widget.includeTutorial
        )
    );
  }

}
