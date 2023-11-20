// Dart imports:
import 'dart:ui';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_svg/flutter_svg.dart';
import 'package:xml/xml.dart';

// Project imports:
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
      Key? key
    }
  ) : super(key: key);

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
  late AnimationController switchAnimation;


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
    switchAnimation = AnimationController(
      value: widget.playKanjiAnimationWhenOpened 
        ? 0.0
        : 1.0,
      duration: const Duration(milliseconds: 250),
      vsync: this
    );
    colorizedKanjiVG = colorizeKanjiVG(widget.kanjiVGString);
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
          switchAnimation.reverse();
          startDrawingAnimation();
        }
        // restart animation if stopped at the end
        else if(kanjiVGAnimationController!.isCompleted){
          switchAnimation.reverse();
          startDrawingAnimation(reverseSwitch: true, startFrom: 0);
        }
      },
      behavior: HitTestBehavior.translucent,
      onHorizontalDragStart: (details) {
        if(kanjiVGAnimationController == null) return;

        switchAnimation.reverse();
      },
      onHorizontalDragUpdate: (details) {
        if(kanjiVGAnimationController == null) {
          return;
        }

        double progress = clampDouble(details.localPosition.dx / widget.width, 0, 0.99999);
        if(progress == 0.99999 || switchAnimation.value != 0){
          switchAnimation.value = clampDouble(((details.localPosition.dx / widget.width)-1)*4, 0, 1);
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
        height: widget.height,
        width: widget.width,
        decoration: widget.borderAround
          ? BoxDecoration(
            border: Border.all(width: 2, color: Colors.grey.withOpacity(0.5))
          )
          : null,
        child: AnimatedBuilder(
          animation: switchAnimation,
          child: SvgPicture.string(
              widget.colorize ? colorizedKanjiVG : widget.kanjiVGString
            ),
          builder: (context, child) {
            return Stack(
              children: [
                // finished colorized svg
                Positioned.fill(
                  child: Opacity(
                    opacity: switchAnimation.value,
                    child: child
                  ),
                ),
                // drawing animation
                Positioned.fill(
                  child: Opacity(
                    opacity: 1 - switchAnimation.value,
                    child: AnimatedKanji(
                      colorizedKanjiVG,
                      widget.strokesPerSecond,
                      (AnimationController controller) {
                        kanjiVGAnimationController = controller;
                        if(widget.playKanjiAnimationWhenOpened){
                          startDrawingAnimation(startFrom: 0, reverseSwitch: true);
                        }
                      }
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
      switchAnimation.reverse();
    }
    kanjiVGAnimationController!.forward(from: startFrom)
      .then((value) {
        switchAnimation.forward();
        setState(() {});
      });

  }

  /// Changes the colors of the strokes and text of the given `kanjiVGEntry`
  /// and returns it.
  String colorizeKanjiVG (String kanjiVGEntry) {

    // convert the KanjiVG entry to a Xml doc
    final document = XmlDocument.parse(kanjiVGEntry);

    //iterate over the strokes
    int cnt = 0, cntInc = 13;
    for (var element in document.findAllElements("path")) {
      element.setAttribute("stroke", "hsl($cnt, 100%, 50%)");
      element.setAttribute("stroke-width", "2");

      cnt += cntInc;
      if(cnt > 360) cnt = 0;
    }

    // iterate over the texts
    cnt = 0;
    for (var element in document.findAllElements("text")) {
      element.setAttribute("stroke", "hsl($cnt, 100%, 50%)");
      element.setAttribute("fill", "hsl($cnt, 100%, 50%)");
      element.setAttribute("stroke-width", "0.5");

      cnt += cntInc;
      if(cnt > 360) cnt = 0;
    }

    return document.toString();
  }
}
