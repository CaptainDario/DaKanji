import 'package:collection/collection.dart';
import 'package:da_kanji_mobile/application/dictionary/path_modifier.dart';
import 'package:da_kanji_mobile/widgets/dictionary/animated_kanji_painter.dart';
import 'package:flutter/material.dart';
import 'package:path_parsing/path_parsing.dart';



/// Widget that shows an animated version of a kanjiVG entry
class AnimatedKanji extends StatefulWidget {
  
  /// The kanji VG that should be shown and animated in this widget
  final String kanjiVGString;
  /// Amount of strokes that should be rendered per stroke
  final double strokesPerSecond;
  /// Callback that is invoked after this widget has been initialized
  /// Provides the [AnimationController] that controls the animated kanji as
  /// parameter
  final Function(AnimationController controller) init;
  

  const AnimatedKanji(
    this.kanjiVGString,
    this.strokesPerSecond,
    this.init,
    {
      super.key
    }
  );

  @override
  State<AnimatedKanji> createState() => _AnimatedKanjiState();
}

class _AnimatedKanjiState extends State<AnimatedKanji> with TickerProviderStateMixin{

  /// List of paths that are the kanji strokes that will be animated
  List<Path> paths = [];
  /// List of paints that are used to draw the paths in `paths`
  List<Paint> paints = [];
  /// [AnimationController] used to control the kanji animation
  late AnimationController kanjiVGAnimationController;


  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  void didUpdateWidget(covariant AnimatedKanji oldWidget) {
    if(oldWidget.kanjiVGString != widget.kanjiVGString){
      init();
    }
    super.didUpdateWidget(oldWidget);
  }

  void init() {
    paths.clear(); paints.clear();

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

      // get stroke color and width
      /*Color strokeColor = HSLColor.fromAHSL(
        1.0,
        double.parse(svgPathMatch.group(2)!),
        double.parse(svgPathMatch.group(3)!)/100,
        double.parse(svgPathMatch.group(4)!)/100
      ).toColor();*/
      double strokeWidth = double.parse(svgPathMatch.group(5)!);
      paints.add(Paint()
        ..color = Colors.white //strokeColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round
      );
    }

    kanjiVGAnimationController = AnimationController(
        duration: Duration(
          milliseconds: ((paths.length/widget.strokesPerSecond)*1000).toInt()
        ),
        vsync: this,
      );

    widget.init(kanjiVGAnimationController);

    // set the stroke color after the first frame matching the current theme
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      for (var paint in paints) {
        paint.color = Theme.of(context).brightness == Brightness.light
          ? Colors.black
          : Colors.white;
      }
    });
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