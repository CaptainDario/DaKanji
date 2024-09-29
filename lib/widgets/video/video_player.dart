import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:da_kanji_mobile/widgets/widgets/da_kanji_loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_subtitle/flutter_subtitle.dart' hide Subtitle;
import 'package:video_player/video_player.dart';



class VideoPlayer extends StatefulWidget {
  const VideoPlayer({super.key});

  @override
  State<VideoPlayer> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {

  late ChewieController chewieController;

  late VideoPlayerController videoPlayerController;


  @override
  void initState() {
    super.initState();
  }

  Future<bool> initPlayer() async {

    // load video
    //FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.video);
    //File videoFile = File(result!.files.first.path!);
    File videoFile = File("/Users/darioklepoch/Downloads/aot_s4_e1.mp4");
    videoPlayerController = VideoPlayerController.file(videoFile);
    
    await videoPlayerController.initialize();

    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      subtitleBuilder: (context, subtitle) {
        return Container(
          color: Colors.black,
          padding: EdgeInsets.all(16),
          child: SelectableText(
            subtitle,
            style: TextStyle(fontSize: 24),
          ),
        );
      },
    );

    // load subtitles
    var subsFile = File('/Users/darioklepoch/Downloads/aot_s4_e1.srt');
    //FilePickerResult? result = await FilePicker.platform.pickFiles();
    //File subsFile = File(result!.files.first.path!);
    var subtitleController = SubtitleController.string(
      subsFile.readAsStringSync(),
      format: SubtitleFormat.srt);

    chewieController.setSubtitle(
      subtitleController.subtitles.map((e) => Subtitle(
        index: e.number,
        start: Duration(milliseconds: e.start),
        end: Duration(milliseconds: e.end),
        text: e.text
      )).toList()
    );

    return true;

  }

  @override
  Widget build(BuildContext context) {

    return FutureBuilder<bool>(
      future: initPlayer(),
      builder: (context, snapshot) {

        if(snapshot.data != true) return const DaKanjiLoadingIndicator();

        return Chewie(
          controller: chewieController
        );
      }
    );
  
  }
}