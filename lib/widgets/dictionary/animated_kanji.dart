import 'package:collection/collection.dart';
import 'package:da_kanji_mobile/application/dictionary/path_modifier.dart';
import 'package:da_kanji_mobile/widgets/dictionary/animated_kanji_painter.dart';
import 'package:flutter/material.dart';
import 'package:path_parsing/path_parsing.dart';



class AnimatedKanji extends StatefulWidget {
  
  /// The kanji VG that should be shown and animated in this widget
  final String kanjiVGString;

  final Function(AnimationController controller) init;
  

  const AnimatedKanji(
    this.kanjiVGString,
    this.init,
    {
      super.key
    }
  );

  @override
  State<AnimatedKanji> createState() => _AnimatedKanjiState();
}

class _AnimatedKanjiState extends State<AnimatedKanji> with TickerProviderStateMixin{


  List<Path> paths = [];

  List<Paint> paints = [];

  late AnimationController kanjiVGAnimationController;


  @override
  void initState() {

    // parse kanjiVG entry for paths
    RegExp pathsRegex = RegExp(r' d="(.+?)" stroke="hsl\((\d+).+?(\d+).+?(\d+).*\)" stroke-width="(.+?)');
    List<RegExpMatch> svgPathMatches = pathsRegex.allMatches(widget.kanjiVGString)
      .whereNotNull()
      .toList();

    for (RegExpMatch svgPathMatch in svgPathMatches) {
      // get stroke
      String svgPath = svgPathMatch.group(1)!;
      PathModifier pM = PathModifier(Path());
      writeSvgPathDataToPath(svgPath, pM);
      paths.add(pM.path);

      // get color and width
      /*Color strokeColor = HSLColor.fromAHSL(
        1.0,
        double.parse(svgPathMatch.group(2)!),
        double.parse(svgPathMatch.group(3)!)/100,
        double.parse(svgPathMatch.group(4)!)/100
      ).toColor();*/
      double strokeWidth = double.parse(svgPathMatch.group(5)!);
      paints.add(Paint()
        ..color = Theme.of(context).brightness == Brightness.light
          ? Colors.black
          : Colors.white//strokeColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round
      );
    }

    kanjiVGAnimationController = AnimationController(
        duration: Duration(seconds: paths.length~/4),
        vsync: this,
        upperBound: paths.length.toDouble(),
      );

    widget.init(kanjiVGAnimationController);

    super.initState();
  }

  @override
  void dispose() {
    kanjiVGAnimationController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: kanjiVGAnimationController,
      builder: (context, widget) {
        return CustomPaint(
          painter: AnimatedKanjiPainter(
            paths,
            paints,
            kanjiVGAnimationController,
          ),
        );
      }
    );
  }
}