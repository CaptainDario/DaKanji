// Dart imports:
import 'dart:math';
import 'dart:ui';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_svg/flutter_svg.dart';

// Project imports:
import 'package:da_kanji_mobile/application/dictionary/kanji_vg.dart';
import 'package:da_kanji_mobile/widgets/dictionary/animated_kanji.dart';

 /// Widget that shows an animated KanjiVG entry. After the animation finished,
 /// a static kanji is shown with stroke numbers.
 /// If `colorize == true` the static kanji will have different colors for each 
 /// stroke, otherwise it will be black / white depending of the current theme. 
class KanjiVGWidget extends StatefulWidget {

  /// String containing a KanjiVG entry
  final String kanjiVGString;
  /// height of this widget
  final double height;
  /// width of this widget
  final double width;
  /// should the strokes and text of the KanjiVG be colorized
  final bool colorize;
  /// Should the animation automatically play when instantiating this widget
  final bool playKanjiAnimationWhenOpened;
  /// Amount of strokes that should be shown per second
  final double strokesPerSecond;
  /// When user stops swiping should the animation automatically continue
  final bool resumeAnimationAfterStopSwipe;
  ///Should a border be drawn around the kanjiVG entry
  final bool borderAround;


  const KanjiVGWidget(
    this.kanjiVGString,
    this.height,
    this.width,
    this.playKanjiAnimationWhenOpened,
    this.strokesPerSecond,
    this.resumeAnimationAfterStopSwipe,
    {
      this.borderAround = true,
      this.colorize = false,
      super.key
    }
  );

  @override
  State<KanjiVGWidget> createState() => _KanjiVGWidgetState();
}

class _KanjiVGWidgetState extends State<KanjiVGWidget> with TickerProviderStateMixin{

  /// String that contains the color coded kanji vg string
  late String colorizedKanjiVG;
  /// `AnimationController` to control the KanjiVG animation
  AnimationController? kanjiVGAnimationController;
  /// [AnimationController] that handles switching between the animation and
  /// the colored result 
  AnimationController? switchAnimation;


  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant KanjiVGWidget oldWidget) {
    init();
    super.didUpdateWidget(oldWidget);
  }

  /// Initializes the variales of this widget
  void init(){
    switchAnimation ??= AnimationController(
      value: widget.playKanjiAnimationWhenOpened 
        ? 0.0
        : 1.0,
      duration: const Duration(milliseconds: 250),
      vsync: this
    );
    colorizedKanjiVG = colorizeKanjiVG(widget.kanjiVGString);

  }

  @override
  void dispose() {
    switchAnimation?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onDoubleTap: () {
        // stop animation if it is running
        if(kanjiVGAnimationController!.isAnimating){
          kanjiVGAnimationController!.stop();
        }
        // continue animation if it is stopped somwhere
        else if(!kanjiVGAnimationController!.isCompleted){
          switchAnimation?.reverse();
          startDrawingAnimation();
        }
        // restart animation if stopped at the end
        else if(kanjiVGAnimationController!.isCompleted){
          kanjiVGAnimationController!.value = 0;
          switchAnimation?.reverse().then((value) {
            startDrawingAnimation(reverseSwitch: true, startFrom: 0);
          }); 
        }
      },
      behavior: HitTestBehavior.translucent,
      onHorizontalDragStart: (details) {
        if(kanjiVGAnimationController == null) return;

        switchAnimation?.reverse();
      },
      onHorizontalDragUpdate: (details) {
        if(kanjiVGAnimationController == null) {
          return;
        }

        double progress = clampDouble(details.localPosition.dx / widget.width, 0, 0.99999);
        if(progress == 0.99999 || switchAnimation?.value != 0){
          switchAnimation?.value = clampDouble(((details.localPosition.dx / widget.width)-1)*4, 0, 1);
        }

        setState(() {
          kanjiVGAnimationController!.value = progress;
        });
      },
      onHorizontalDragEnd: (details) {
        if(widget.resumeAnimationAfterStopSwipe){
          startDrawingAnimation(reverseSwitch: false);
        }
      },
      child: Container(
        height: min(widget.height, widget.width),
        width: min(widget.height, widget.width),
        decoration: widget.borderAround
          ? BoxDecoration(
            border: Border.all(width: 2, color: Colors.grey.withValues(alpha: 0.5))
          )
          : null,
        child: AnimatedBuilder(
          animation: switchAnimation!,
          child: Stack(
            children: [
              if(widget.colorize && Theme.of(context).brightness == Brightness.light)
                Positioned.fill(
                  child: SvgPicture.string(
                    changeTextWidthAndColor(
                      changeStrokeWidthAndColor(widget.kanjiVGString, 2.2, "grey"),
                      0.7, "grey"
                    )
                  ),
                ),
              Positioned.fill(
                child: SvgPicture.string(
                  widget.colorize
                    ? colorizedKanjiVG
                    : widget.kanjiVGString
                ),
              ),
            ]
          ),
          builder: (context, child) {
            return Stack(
              children: [
                // finished colorized svg
                Positioned(
                  height: min(widget.height, widget.width),
                  width: min(widget.height, widget.width),
                  child: Opacity(
                    opacity: switchAnimation!.value,
                    child: child
                  ),
                ),
                // drawing animation
                Positioned(
                  height: min(widget.height, widget.width),
                  width: min(widget.height, widget.width),
                  child: Opacity(
                    opacity: 1 - switchAnimation!.value,
                    child: AnimatedKanji(
                      colorizedKanjiVG,
                      widget.strokesPerSecond,
                      (AnimationController controller) {
                        kanjiVGAnimationController = controller;

                        if(widget.playKanjiAnimationWhenOpened){
                          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                            if(mounted){
                              startDrawingAnimation(startFrom: 0, reverseSwitch: true);
                            }
                          },);
                        }
                      },
                      // rebuild the animation widget when 
                      key: Key(widget.playKanjiAnimationWhenOpened.toString()),
                    ),
                  ),
                ),
              ],
            );
          }
        )
      ),
    );
  }

  void startDrawingAnimation({double? startFrom, bool reverseSwitch = false}) {

    if(reverseSwitch) {
      switchAnimation?.reverse();
    }
    kanjiVGAnimationController!.forward(from: startFrom)
      .then((value) {
        switchAnimation?.forward();
        setState(() {});
      });

  }

}
