

import 'dart:async';

import 'package:da_kanji_mobile/globals.dart';
import 'package:da_kanji_mobile/widgets/selectable_subtitle_video/selectable_subtitle_video.dart';
import 'package:da_kanji_mobile/widgets/selectable_subtitle_video/selectable_subtitle_video_controller.dart';
import 'package:da_kanji_mobile/widgets/selectable_subtitle_video/subtitle.dart';
import 'package:flutter/material.dart';
import 'package:youtube_caption_scraper/youtube_caption_scraper.dart' as ytc;
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
        mute: true,
        hideControls: true,
        disableDragSeek: true,
        enableCaption: false,
    ),
  );
  /// Scraper object to fetch the subtitles
  final captionScraper = ytc.YouTubeCaptionScraper();
  /// All subtitles tracks that have been fetched
  List<ytc.CaptionTrack> captionTracks = [];
  

  Future<bool> init() async {

    await fetchSubtitleNames();

    _controller = SelectableSubtitleVideoController(
      position: Duration.zero,
      positionChangeNotifier: _ytController,
      getCurrentPosition: () => _ytController.value.position,
      getVideoDuration: () => _ytController.value.metaData.duration,

      isPlaying: true,
      play: () => _ytController.play(),
      pause: () => _ytController.pause(),

      playbackRate: 1.0,
      setPlaybackRate: _ytController.setPlaybackRate,

      isMuted: true,
      unMute: () => _ytController.unMute(),
      mute: () => _ytController.mute(),

      subtitleNames: captionTracks.map((e) => e.name,).toList(),
      getSubtitlesFromSubtitleName: getSubtitlesFromSubtitleName,

      seekTo: _ytController.seekTo
    );

    return true;

  }

  /// Gets all available subtitles from youtube
  Future<void> fetchSubtitleNames() async {
  
    try {
      captionTracks = await captionScraper.getCaptionTracks(widget.videoUrl);
    } catch (e) {
      captionTracks = [];
    }

  }

  Future<List<SubtitleLine>> getSubtitlesFromSubtitleName(String subtitleName) async {

    return captionScraper.getSubtitles(
      captionTracks.where((e) => e.name == subtitleName).first
    )
    .then((value) =>
      value.map((e) => SubtitleLine.fromYoutubeCaptions(e),).toList(),
    );

  }

  @override
  Widget build(BuildContext context) {


    return FutureBuilder(
      future: init(),
      builder: (context, snapshot) {

        // if the initialization did not finish yet
        if (!snapshot.hasData) return const SizedBox();

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
    );
  }

}