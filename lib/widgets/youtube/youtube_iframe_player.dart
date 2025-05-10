

import 'dart:async';

import 'package:da_kanji_mobile/globals.dart';
import 'package:da_kanji_mobile/widgets/selectable_subtitle_video/selectable_subtitle_video.dart';
import 'package:da_kanji_mobile/widgets/selectable_subtitle_video/selectable_subtitle_video_controller.dart';
import 'package:da_kanji_mobile/widgets/selectable_subtitle_video/subtitle_selection_button.dart';
import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:youtube_caption_scraper/youtube_caption_scraper.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';



class YoutubeIframePlayer extends StatefulWidget {

  /// The video url to use
  final String videoUrl;
  /// What should happen when the close button is pressed
  final Function? onClosePressed;

  const YoutubeIframePlayer(
    this.videoUrl,
    {
      this.onClosePressed,
      super.key
    }
  );

  @override
  State<YoutubeIframePlayer> createState() => _YoutubeIframePlayerState();
}

class _YoutubeIframePlayerState extends State<YoutubeIframePlayer>
  with TickerProviderStateMixin{

  late SelectableSubtitleVideoController _controller;

  late final YoutubePlayerController _ytController = YoutubePlayerController(
    initialVideoId: YoutubePlayer.convertUrlToId(widget.videoUrl)!,
    flags: const YoutubePlayerFlags(
        //autoPlay: true,
        controlsVisibleAtStart: false,

        hideControls: true,
        disableDragSeek: true,
        enableCaption: false,
    ),
  );
  /// Scraper object to fetch the subtitles
  final captionScraper = YouTubeCaptionScraper();
  /// All subtitles tracks that have been fetched
  List<CaptionTrack> captionTracks = [];
  /// The actual subtitles that have been fetched
  List<SubtitleLine> subtitles = [];
  

  @override
  void initState() {
    super.initState();
    _controller = SelectableSubtitleVideoController(
      isPlaying: false,
      play: () => _ytController.play(),
      pause: () => _ytController.pause(),

      playbackRate: 1.0,
      setPlaybackRate: _ytController.setPlaybackRate,

      isMuted: false,
      unMute: () => _ytController.unMute(),
      mute: () => _ytController.mute(),

      seekBy: (int n) => _ytController.seekTo(
        _ytController.value.position + Duration(seconds: n))
    );
  }


  @override
  Widget build(BuildContext context) {


    return SelectableSubtitleVideo(
      videoWidget: YoutubePlayer(
        controller: _ytController,
        
        showVideoProgressIndicator: true,
        progressIndicatorColor: g_Dakanji_red,
        progressColors: const ProgressBarColors(
          playedColor: g_Dakanji_red,
          handleColor: g_Dakanji_red,
        ),
      ),
      controller: _controller,
      onClosePressed: widget.onClosePressed
    );
  }

}