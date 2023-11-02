// Flutter imports:
import 'package:da_kanji_mobile/widgets/dictionary/animated_kanji.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_svg/flutter_svg.dart';
import 'package:xml/xml.dart';



 /// Widget that shows an animated KanjiVG entry. After the animation finished,
 /// a static kanji is shown with stroke numbers.
 /// If `colorize == true` the static kanji will have different colors for each 
 /// stroke, otherwise it will be black / white depending of the current theme. 
class KanjiVGWidget extends StatefulWidget {
  const KanjiVGWidget(
    this.kanjiVGString,
    this.height,
    this.width,
    {
      this.colorize = false,
      Key? key
    }
  ) : super(key: key);

  /// String containing a KanjiVG entry
  final String kanjiVGString;
  /// height of this widget
  final double height;
  /// width of this widget
  final double width;
  /// should the strokes and text of the KanjiVG be colorized
  final bool colorize;

  @override
  State<KanjiVGWidget> createState() => _KanjiVGWidgetState();
}

class _KanjiVGWidgetState extends State<KanjiVGWidget> {

  /// String that contains the color coded kanji vg string
  late String colorizedKanjiVG;
  /// `AnimationController` to control the KanjiVG animation
  AnimationController? kanjiVGAnimationController;


  @override
  void initState() {
    
    colorizedKanjiVG = colorizeKanjiVG(widget.kanjiVGString);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant KanjiVGWidget oldWidget) {
    colorizedKanjiVG = colorizeKanjiVG(widget.kanjiVGString);
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      transitionBuilder: (child, animation) {
        return FadeTransition(opacity: animation, child: child);
      },
      child: Container(
        key: ValueKey<bool>(kanjiVGAnimationController == null ||
          (kanjiVGAnimationController != null && !kanjiVGAnimationController!.isCompleted)),
        height: widget.height,
        width: widget.width,
        decoration: BoxDecoration(
          border: Border.all(width: 2, color: Colors.grey.withOpacity(0.5))
        ),
        child: kanjiVGAnimationController == null ||
          (kanjiVGAnimationController != null && !kanjiVGAnimationController!.isCompleted)
          ? AnimatedKanji(
            colorizedKanjiVG,
            (AnimationController controller) {
              kanjiVGAnimationController = controller;
              controller.repeat();//.forward().then((value) => setState((){}));
            }
          )
          : SvgPicture.string(
            widget.colorize ? colorizedKanjiVG : widget.kanjiVGString
          ),
      ),
    );
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
