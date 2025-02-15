// Dart imports:
import 'dart:io';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:chewie/chewie.dart';
import 'package:flutter_subtitle/flutter_subtitle.dart' hide Subtitle;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:kana_kit/kana_kit.dart';
import 'package:mecab_for_flutter/mecab_for_flutter.dart';
import 'package:video_player/video_player.dart';

// Project imports:
import 'package:da_kanji_mobile/application/text/custom_selectable_text_controller.dart';
import 'package:da_kanji_mobile/application/text/custom_selectable_text_processing.dart';
import 'package:da_kanji_mobile/widgets/text/custom_selectable_text.dart';
import 'package:da_kanji_mobile/widgets/text_analysis/text_analysis_stack.dart';
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

  /// The controller of the chewie video player
  late ChewieController chewieController;
  /// The flutter video player controller
  late VideoPlayerController videoPlayerController;

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
  List<String> mecabPOS = const [];
  /// the output readings of mecab
  List<String> mecabReadings = const [];
  /// the controller to manipulate the CustomSelectableText
  CustomSelectableTextController? customSelectableTextController;

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
    videoPlayerController = VideoPlayerController.file(widget.videoFile);
    
    await videoPlayerController.initialize();

    chewieController = ChewieController(
      fullScreenByDefault: true,
      allowFullScreen: false,
      videoPlayerController: videoPlayerController,
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
    );

    // load subtitles
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

    return true;

  }

  @override
  void dispose() {
    chewieController.dispose();
    videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return FutureBuilder<bool>(
      future: initPlayer(),
      builder: (context, snapshot) {

        if(snapshot.data != true) return const DaKanjiLoadingIndicator();

        return ValueListenableBuilder(
          valueListenable: currentSelection,
          child: Chewie(controller: chewieController),
          builder: (context, value, child) {
            return TextAnalysisStack(
              textToAnalyze: value,
              poupAnimationController: popupAnimationController,
              onPopupInitialized: (tabController) {
                popupTabController = tabController;
              },
              constraints: const BoxConstraints.expand(),
              children: [
                Stack(
                  children: [
                    child!,
                    Positioned(
                      bottom: 75 - subtitleOffset.dy,
                      left: MediaQuery.of(context).size.width / 4 + subtitleOffset.dx,
                      width: MediaQuery.of(context).size.width / 2,
                      child: ValueListenableBuilder<List<String>>(
                        valueListenable: mecabSurfaces,
                        builder: (BuildContext context, List<String> value, Widget? child) {
                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20), // Rounded corners
                            ),
                            child: Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CustomSelectableText(
                                    words: value,
                                    rubys: mecabReadings,
                                    showRubys: true,
                                    init: (controller) => customSelectableTextController = controller,
                                    textColor: Colors.black,
                                    onSelectionChange: (p0) {
                                      currentSelection.value = currentSubtitle
                                        .replaceAll(" ", "")
                                        .substring(p0.baseOffset, p0.extentOffset);
                                      popupAnimationController.forward();
                                    },
                                  ),
                                ),
                                // move handle
                                Positioned(
                                  left: 0,
                                  top: 0,
                                  child: Listener(
                                    onPointerMove: (event) {
                                      subtitleOffset += event.delta;
                                      setState(() {});
                                    },
                                    child: SvgPicture.asset(
                                      "assets/icons/corner_resize.svg",
                                      colorFilter: const ColorFilter.mode(Colors.grey, BlendMode.srcIn)
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    Positioned(
                      child: Visibility(
                        visible: true,
                        child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.close)
                        ),
                      )
                    ),
                  ]
                ),
              ]
            );
          }
        );
      }
    );
  
  }
}
