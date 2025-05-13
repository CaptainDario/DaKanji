// Dart imports:
import 'dart:io';

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:fvp/fvp.dart';

// Package imports:
import 'package:video_player/video_player.dart' as flutter_video_player;

// Project imports:
import 'package:da_kanji_mobile/widgets/widgets/da_kanji_loading_indicator.dart';

class VideoPlayer extends StatefulWidget {

  /// The file that contains the video that should be played
  final File videoFile;
  /// The file that contains the subtitles that should be displayed
  final File subsFile;

  const VideoPlayer(
    this.videoFile,
    this.subsFile,
    {
      super.key
    }
  );

  @override
  State<VideoPlayer> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer>  with TickerProviderStateMixin {

  /// The flutter video player controller
  late flutter_video_player.VideoPlayerController videoPlayerController;

  /// The subtitle that is currently being shown
  String currentSubtitle = "";
  /// The current user selection
  ValueNotifier<String> currentSelection = ValueNotifier<String>("");

  /// the animation controller for scaling in the popup window
  late AnimationController popupAnimationController;
  /// the tab controller for the tab bar of the popup
  late TabController popupTabController;
  /// the animation for scaling in the popup window
  late final Animation<double> popupAnimation;

  /// the output surfaces of mecab
  ValueNotifier<List<String>> mecabSurfaces = ValueNotifier<List<String>>([]);
  //List<String> mecabSurfaces = const [];
  /// the output part of speech elements of mecab
  List<List<String>> mecabPOS = const [];
  /// the output readings of mecab
  List<String> mecabReadings = const [];

  Offset subtitleOffset = Offset.zero;




  @override
  void initState() {

    popupAnimationController = AnimationController(
      duration: const Duration(milliseconds: 250),
      value: 0.0,
      vsync: this,
    );
    popupAnimation = popupAnimationController.drive(
      CurveTween(curve: Curves.easeInOut)
    );

    super.initState();
  }

  Future<bool> initPlayer() async {

    // load video
    videoPlayerController = flutter_video_player.VideoPlayerController.file(widget.videoFile);
    
    await videoPlayerController.initialize();

    await videoPlayerController.play();
    
    
    /*
    subtitleBuilder: (context, subtitle) {
      
      if(subtitle != currentSubtitle){
        currentSubtitle = subtitle;
        final res = processText(currentSubtitle,
          GetIt.I<Mecab>(), GetIt.I<KanaKit>());
          WidgetsBinding.instance.addPostFrameCallback(
            (timeStamp) => mecabSurfaces.value = res.item2,
          );
        mecabReadings = res.item1;
        mecabPOS      = res.item3;
      }
      return Container();

    },
    */

    // load subtitles
    /*
    var subtitleController = SubtitleController.string(
      widget.subsFile.readAsStringSync(),
      format: SubtitleFormat.srt);

    chewieController.setSubtitle(
      subtitleController.subtitles.map((e) => Subtitle(
        index: e.number,
        start: Duration(milliseconds: e.start),
        end: Duration(milliseconds: e.end),
        text: e.text
      )).toList()
    );
    */

    return true;

  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return FutureBuilder<bool>(
      future: initPlayer(),
      builder: (context, snapshot) {

        if(snapshot.data != true) return const DaKanjiLoadingIndicator();

        return Stack(
          alignment: Alignment.topCenter,
          children: [
            Positioned(
              left: 0,
              right: 0,
              top: 0,
              child: AspectRatio(
                aspectRatio: videoPlayerController.value.aspectRatio,
                child: flutter_video_player.VideoPlayer(videoPlayerController)
              )
            )
          ],
        );
      }
    );
  
  }
}
