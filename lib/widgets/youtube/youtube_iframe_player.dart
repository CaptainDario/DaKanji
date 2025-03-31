

import 'dart:async';

import 'package:da_kanji_mobile/globals.dart';
import 'package:da_kanji_mobile/widgets/video/subtitle_selection_button.dart';
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

  late final YoutubePlayerController _controller = YoutubePlayerController(
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
  /// the minimum subtitle width
  static const double minSubtitleWidth = 100;
  /// The width of the subtitle widget
  double subtitlesWidth = minSubtitleWidth;
  /// the minimum subtitle height
  static const double minSubtitleHeight = 50;
  /// The height of the subtitle widget
  double subtitlesHeight = minSubtitleHeight;
  /// The subtitles that are currently being shown
  String? currentSubtitle;
  /// x position of the subtitle
  late double subtitlePosX = MediaQuery.of(context).size.width / 2 - (subtitlesWidth/2);
  /// y position of the subtitle
  double subtitlePosY = 8;
  /// The details where the user started dragging
  TapDownDetails? subtitleDragStartDetails;
  

  /// The animation controller to handle smoothly fading in and out the controls
  late AnimationController fadeControlsAnimationController;
  /// Timer to hide controls after timeout
  Timer? hideControlsTimer;

  /// Is the player muted
  bool isMuted = false;

  /// Is the user currently skipping
  int isSkipping = 0;

  


  @override
  void initState() {
    super.initState();
    fadeControlsAnimationController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this
    );

    fadeControlsAnimationController.value = 1.0;
    startHideControlsTimer();
  }

  @override
  void dispose() {
    _controller.removeListener(setCurrentCaptions);
    _controller.dispose();
    fadeControlsAnimationController.dispose();
    hideControlsTimer?.cancel();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {


    return Stack(
      fit: StackFit.expand,
      children: [
    
        Align(
          alignment: Alignment.topCenter,
          child: AnimatedBuilder(
            animation: fadeControlsAnimationController,
            builder: (context, child) {
              return Stack(
                fit: StackFit.loose,
                children: [
                  YoutubePlayer(
                    controller: _controller,
                    
                    showVideoProgressIndicator: true,
                    progressIndicatorColor: g_Dakanji_red,
                    progressColors: const ProgressBarColors(
                      playedColor: g_Dakanji_red,
                      handleColor: g_Dakanji_red,
                    ),
                    onReady: () async {
                      try {
                        captionTracks = await captionScraper.getCaptionTracks(widget.videoUrl);
                      } catch (e) {
                        captionTracks = [];
                      }
                        
                      _controller.addListener(setCurrentCaptions);
                    },
                  ),
          
                  // vignette
                  Positioned.fill(
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onDoubleTapDown: onDoubleTapVideo,
                      onTap: () {
                        setState(() {
                          fadeControlsAnimationController.isDismissed
                            ? fadeControlsAnimationController.forward().then(
                              (value) => startHideControlsTimer(),
                            )
                            : fadeControlsAnimationController.reverse();
                        });
                      },
                      child: Container(
                        color: !fadeControlsAnimationController.isDismissed
                          ? Colors.black.withAlpha((fadeControlsAnimationController.value * 150).toInt())
                          : Colors.grey.withAlpha(1),
                      ),
                    )
                  ),
              
                  // rewind | play/pause | skip
                  if(!fadeControlsAnimationController.isDismissed || isSkipping != 0)
                    Positioned.fill(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Expanded(child: SizedBox()),
                          Visibility(
                            visible: !fadeControlsAnimationController.isDismissed ||
                                      isSkipping < 0,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                IconButton(
                                  onPressed: () => seekBy(-5),
                                  icon: const Icon(Icons.fast_rewind, size: 40,)
                                ),
                                if(isSkipping < 0)
                                  Positioned(
                                    bottom: 0,
                                    child: Text(
                                      style: const TextStyle(fontSize: 10),
                                      "${isSkipping}s"
                                    )
                                  )
                              ],
                            ),
                          ),
                          const Expanded(child: SizedBox()),
                          // Play pause button
                          Visibility(
                            visible: !fadeControlsAnimationController.isDismissed,
                            child: AnimatedSwitcher(
                              duration: const Duration(milliseconds: 150),
                              child: IconButton(
                                key: ValueKey(_controller.value.isPlaying),
                                onPressed: () => _controller.value.isPlaying
                                  ? _controller.play()
                                  : _controller.pause(),
                                icon: Icon(_controller.value.isPlaying
                                  ? Icons.pause
                                  : Icons.play_arrow,
                                size: 48,)
                              ),
                            ),
                          ),
                          const Expanded(child: SizedBox()),
                          Visibility(
                            visible: !fadeControlsAnimationController.isDismissed ||
                                      isSkipping > 0,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                IconButton(
                                  onPressed: () => seekBy(5),
                                  icon: const Icon(Icons.fast_forward, size: 40,)
                                ),
                                if(isSkipping > 0)
                                Positioned(
                                  bottom: 0,
                                  child: Text(
                                    style: const TextStyle(fontSize: 10),
                                    "${isSkipping}s"
                                  )
                                )
                              ],
                            ),
                          ),
                          const Expanded(child: SizedBox()),
                        ],
                      ),
                    ),
              
                  if(!fadeControlsAnimationController.isDismissed)
                    Positioned(
                      left: 8,
                      bottom: 8,
                      width: MediaQuery.sizeOf(context).width,
                      child: Column(
                        children: [
                          // progress bar
                          Row(
                            children: [
                              Expanded(child: ProgressBar(controller: _controller,)),
                              const SizedBox(width: 16,)
                            ],
                          ),
                          Row(
                            children: [
                              CurrentPosition(controller: _controller,),
                              Text(
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12.0,
                                ),
                                " / ${_controller.value.metaData.duration.toString().split(".")[0]}"
                              ),
                              const SizedBox(width: 8,),
                              AnimatedSwitcher(
                                duration: const Duration(milliseconds: 150),
                                key: ValueKey(isMuted),
                                child: IconButton(
                                  icon: Icon(isMuted
                                    ? Icons.volume_off
                                    : Icons.volume_up),
                                  onPressed: () {
                                    if(isMuted){
                                      _controller.unMute();
                                      isMuted = false;
                                    }
                                    else {
                                      _controller.mute();
                                      isMuted = true;
                                    }
                                  },
                                ),
                              ),
                              const Expanded(child: SizedBox()),
                              SubtitleSelectionButton(
                                languages: captionTracks.map((e) => e.name,).toList(),
                                onChanged: onSubtitleChanged,
                              ),
                              PlaybackSpeedButton(controller: _controller,),
                              const SizedBox(width: 8,),
                              FullScreenButton(controller: _controller),
                              const SizedBox(width: 16,),
                            ]
                          ),
                        ]
                      )
                    ),
                
                  
                  if(!fadeControlsAnimationController.isDismissed)
                    Positioned(
                      left: 8,
                      top: 8,
                      child: IconButton(
                        onPressed: () {
                          widget.onClosePressed?.call();
                        },
                        icon: const Icon(Icons.close, size: 32,)
                      )
                    ),
                ],
              );
            }
          ),
        ),
        
        // subtitles
        if(currentSubtitle != null)
          Positioned(
            left: subtitlePosX,
            bottom: subtitlePosY,
            child: GestureDetector(
              onPanUpdate: (details) {
                if(!(subtitlePosX < 0 && details.delta.dx < 0) &&
                  !(subtitlePosX+subtitlesWidth > MediaQuery.sizeOf(context).width && details.delta.dx > 0)){
                  setState(() {
                    subtitlePosX += details.delta.dx;
                  });
                }
                if(!(subtitlePosY < 0 && details.delta.dy > 0) &&
                  !(subtitlePosY+subtitlesHeight > MediaQuery.sizeOf(context).height-kToolbarHeight && details.delta.dy < 0)){
                    setState(() {
                      subtitlePosY -= details.delta.dy;
                    });
                  }
              },
            
              child: Stack(
                children: [
                  Container(
                    width: subtitlesWidth,
                    height: subtitlesHeight,
                    color: Colors.black.withAlpha(150),
                    child: FittedBox(
                      child: Text(
                        currentSubtitle!,
                      ),
                    ),
                  ),
                  // resizing corner
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: GestureDetector(
                      onPanUpdate: (details) {
                        if(!(subtitlesHeight < minSubtitleHeight && details.delta.dy < 0) &&
                          !(subtitlePosY < 0 && details.delta.dy > 0)){
                          setState(() {  
                            subtitlesHeight += details.delta.dy;
                            subtitlePosY -= details.delta.dy;
                          });
                        }
                        if(!(subtitlesWidth < minSubtitleWidth && details.delta.dx < 0) &&
                          !(details.globalPosition.dx > MediaQuery.sizeOf(context).width)){
                          setState(() {
                            subtitlesWidth += details.delta.dx;
                          });
                        }
                      },
                      child: SvgPicture.asset(
                        "assets/icons/corner_resize.svg",
                        colorFilter: const ColorFilter.mode(Colors.grey, BlendMode.srcIn)
                      ),
                    ),
                  )
                ]
              ),
            )
          ),
      ],
    );
  }


  /// Starts a timer to hide the contorls after 3 seconds
  void startHideControlsTimer(){

    if(hideControlsTimer != null) hideControlsTimer!.cancel();

    hideControlsTimer = Timer(const Duration(seconds: 3), () {
      setState(() {
        fadeControlsAnimationController.reverse();
        isSkipping = 0;
        hideControlsTimer = null;
      });
    });
  }

  /// callback that is executed when the user doubles taps on the video
  void onDoubleTapVideo(TapDownDetails details){
    if(details.localPosition.dx < MediaQuery.sizeOf(context).width/2){
      seekBy(-5);
    }
    else {
      seekBy(5);
    }
  }

  void seekBy(int seconds){
    _controller.seekTo(_controller.value.position + Duration(seconds: seconds));
    
    isSkipping += seconds;
    startHideControlsTimer();
  }

  void onSubtitleChanged(String subtitleName) async {

    if(!captionTracks.map((e) => e.name).toList().contains(subtitleName)){
      currentSubtitle = null;
    }
    else{
      subtitles = await captionScraper.getSubtitles(
        captionTracks.where((e) => e.name == subtitleName).first
      );
    }

    setState(() { });
  }

  /// Sets the captions for the *current* moment of the video
  void setCurrentCaptions(){

    Duration currentPlaybackPos = _controller.value.position;

    for (var i = 0; i < subtitles.length-1; i++) {
      if(subtitles[i].start < currentPlaybackPos &&
        currentPlaybackPos < subtitles[i+1].start){
          setState(() {
            currentSubtitle = subtitles[i].text;
          });
        }
    }

  }

}