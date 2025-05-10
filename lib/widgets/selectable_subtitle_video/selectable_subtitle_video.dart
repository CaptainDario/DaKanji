

import 'dart:async';

import 'package:da_kanji_mobile/widgets/selectable_subtitle_video/playback_speed_button.dart';
import 'package:da_kanji_mobile/widgets/selectable_subtitle_video/selectable_subtitle_video_controller.dart';
import 'package:da_kanji_mobile/widgets/selectable_subtitle_video/subtitle.dart';
import 'package:da_kanji_mobile/widgets/selectable_subtitle_video/subtitle_selection_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';




class SelectableSubtitleVideo extends StatefulWidget {

  /// The video widget to use
  final Widget videoWidget;
  /// Controller to manage the subtitles and the video
  final SelectableSubtitleVideoController controller;
  /// What should happen when the close button is pressed
  final Function? onClosePressed;


  const SelectableSubtitleVideo(
    {
      required this.videoWidget,
      required this.controller,
      required this.onClosePressed,
      super.key
    }
  );

  @override
  State<SelectableSubtitleVideo> createState() => _SelectableSubtitleVideoState();
}

class _SelectableSubtitleVideoState extends State<SelectableSubtitleVideo>
  with TickerProviderStateMixin{

  late final SelectableSubtitleVideoController _controller = widget.controller;

  /// The actual subtitles that have been fetched
  List<SubtitleLine> subtitles = [];
  /// The subtitles that are currently being shown
  String? currentSubtitle;
  /// the minimum subtitle width
  static const double minSubtitleWidth = 100;
  /// The width of the subtitle widget
  double subtitlesWidth = minSubtitleWidth;
  /// the minimum subtitle height
  static const double minSubtitleHeight = 50;
  /// The height of the subtitle widget
  double subtitlesHeight = minSubtitleHeight;
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


  


  @override
  void initState() {
    super.initState();
    fadeControlsAnimationController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this
    );

    fadeControlsAnimationController.value = 1.0;
    startHideControlsTimer();
    _controller.positionChangeNotifier.addListener(setCurrentCaptions);
  }

  @override
  void dispose() {
    // TODO
    //_controller.removeListener(setCurrentCaptions);
    //_controller.dispose();
    fadeControlsAnimationController.dispose();
    hideControlsTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {


    return ChangeNotifierProvider<SelectableSubtitleVideoController>.value(
      value: _controller,
      builder: (context, child) {

        SelectableSubtitleVideoController watchCon = context.watch<SelectableSubtitleVideoController>();

        SelectableSubtitleVideoController readCon  = context.read<SelectableSubtitleVideoController>();

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
                      widget.videoWidget,
              
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
                      if(!fadeControlsAnimationController.isDismissed || readCon.isSeeking != 0)
                        Positioned.fill(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Expanded(child: SizedBox()),
                              Visibility(
                                visible: !fadeControlsAnimationController.isDismissed ||
                                          readCon.isSeeking < 0,
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    IconButton(
                                      onPressed: () => seekBy(-5),
                                      icon: const Icon(Icons.fast_rewind, size: 40,)
                                    ),
                                    if(readCon.isSeeking < 0)
                                      Positioned(
                                        bottom: 0,
                                        child: Text(
                                          style: const TextStyle(fontSize: 10),
                                          "${watchCon.isSeeking}s"
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
                                    key: ValueKey(watchCon.isPlaying),
                                    onPressed: () => readCon.togglePlayPause(),
                                    icon: Icon(watchCon.isPlaying
                                      ? Icons.pause
                                      : Icons.play_arrow,
                                    size: 48,)
                                  ),
                                ),
                              ),
                              const Expanded(child: SizedBox()),
                              Visibility(
                                visible: !fadeControlsAnimationController.isDismissed ||
                                          readCon.isSeeking > 0,
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    IconButton(
                                      onPressed: () => seekBy(5),
                                      icon: const Icon(Icons.fast_forward, size: 40,)
                                    ),
                                    if(readCon.isSeeking > 0)
                                    Positioned(
                                      bottom: 0,
                                      child: Text(
                                        style: const TextStyle(fontSize: 10),
                                        "${readCon.isSeeking}s"
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
                              // TODO progress bar
                              /*Row(
                                children: [
                                  Expanded(child: ProgressBar(controller: _controller,)),
                                  const SizedBox(width: 16,)
                                ],
                              ),*/
                              Row(
                                children: [
                                  // TODO
                                  //CurrentPosition(controller: _controller,),
                                  // TODO
                                  /*
                                  Text(
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12.0,
                                    ),
                                    " / ${_controller.value.metaData.duration.toString().split(".")[0]}"
                                  ),*/
                                  const SizedBox(width: 8,),
                                  // MUTE
                                  AnimatedSwitcher(
                                    duration: const Duration(milliseconds: 150),
                                    key: ValueKey(watchCon.isMuted),
                                    child: IconButton(
                                      icon: Icon(watchCon.isMuted
                                        ? Icons.volume_off
                                        : Icons.volume_up),
                                      onPressed: () => readCon.toggleMute(),
                                    ),
                                  ),
                                  const Expanded(child: SizedBox()),
                                  // SUBTITLES
                                  SubtitleSelectionButton(
                                    languages: watchCon.subtitleNames,
                                    onChanged: onSubtitleChanged,
                                  ),
                                  
                                  PlaybackSpeedButton(controller: watchCon,),
                                  const SizedBox(width: 8,),
                                  // TODO
                                  //FullScreenButton(controller: _controller),
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
    );
  }


  /// Starts a timer to hide the contorls after 3 seconds
  void startHideControlsTimer(){

    if(hideControlsTimer != null) hideControlsTimer!.cancel();

    hideControlsTimer = Timer(const Duration(seconds: 3), () {
      setState(() {
        fadeControlsAnimationController.reverse();
        _controller.isSeeking = 0;
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
    
    _controller.seekBy(seconds);
    
    _controller.isSeeking += seconds;
    startHideControlsTimer();
  }

  void onSubtitleChanged(String subtitleName) async {

    subtitles = await _controller.getSubtitlesFromSubtitleName(subtitleName);
    setCurrentCaptions();

    setState(() { });
  }

  /// Sets the captions for the *current* moment of the video
  void setCurrentCaptions(){

    print(_controller.getCurrentPosition());

    Duration currentPlaybackPos = _controller.getCurrentPosition();

    for (var i = 0; i < subtitles.length-1; i++) {
      if(subtitles[i].start < currentPlaybackPos &&
        currentPlaybackPos < subtitles[i+1].start){
          setState(() {
            currentSubtitle = subtitles[i].text;
          });
          break;
        }
    }

  }

}