// Flutter imports:
import 'package:da_kanji_mobile/widgets/video/video_player.dart';
import 'package:da_kanji_mobile/widgets/video/video_widget.dart';
import 'package:flutter/material.dart';

// Project imports:
import 'package:da_kanji_mobile/entities/screens.dart';
import 'package:da_kanji_mobile/widgets/drawer/drawer.dart';
import 'package:da_kanji_mobile/widgets/reading/reading_widget.dart';
import 'package:universal_io/io.dart';

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

  String videoPath = "/Users/darioklepoch/dev/DaKanji/testing_files/aot_s4_e1";

  late File videoFile;
  late File subsFile;


  @override
  void initState() {
    videoFile = File("$videoPath.mp4");
    subsFile = File("$videoPath.srt");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DaKanjiDrawer(
      drawerClosed: !widget.openedByDrawer,
      currentScreen: Screens.immersion,
      child:
        VideoPlayer(videoFile, subsFile)
      //ReadingWidget(widget.openedByDrawer, widget.includeTutorial)
    );
  }

}


