// Dart imports:
import 'dart:math';
import 'dart:ui' as ui;

// Flutter imports:
import 'package:flutter/material.dart';

/// A custom painter that can draw animated kanjiVG kanjis
class AnimatedKanjiPainter extends CustomPainter {

  /// List of all kanji strokes that should be rendered
  final List<Path> strokes;
  /// List of all `Paint` that should be usde when drawing `strokes`
  final List<Paint> paints;
  /// The animation controller to draw animated `strokes` on this canvas
  final AnimationController animationController;
  /// Length of each individual stroke
  late final List<double> strokeLengths;
  /// The total length of all strokes combined
  double totalLength = 0;


  AnimatedKanjiPainter(
    this.strokes,
    this.paints,
    this.animationController,
  ){
    // calculate how long each path should be depending on their length
    strokeLengths = List.generate(strokes.length, (index) => 0.0);
    for (var i = 0; i < strokes.length; i++) {
      ui.PathMetrics metrics = strokes[i].computeMetrics();
      for (var metric in metrics) {
        strokeLengths[i] += metric.length + (i > 0 ? strokeLengths[i-1] : 0);
        totalLength += metric.length;
      }
    }
  }

  @override
  void paint(Canvas canvas, Size size) {

    if(animationController.value == 0) return;

    // scale kanjivg canvas size (109) to current canvas size
    double minSize = min(size.width, size.height);
    canvas.scale(minSize/109, minSize/109);

    for (int i = 0; i < strokes.length; i++) {
      
      ui.PathMetrics metrics = strokes[i].computeMetrics();
      for (ui.PathMetric metric in metrics){

        double currentValue = animationController.value*totalLength;

        double percentage = (currentValue - strokeLengths[i]) + metric.length;

        canvas.drawPath(
          metric.extractPath(0.0, percentage),
          paints[i]
        );
      }
      
    }
  
  }

  @override
  bool shouldRepaint(AnimatedKanjiPainter oldDelegate)
    => true;

  @override
  bool shouldRebuildSemantics(AnimatedKanjiPainter oldDelegate)
    => false;
}

