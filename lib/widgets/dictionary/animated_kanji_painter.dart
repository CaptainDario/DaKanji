import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'dart:ui' as ui;


/// A custom painter that can draw animated kanjiVG kanjis
class AnimatedKanjiPainter extends CustomPainter {

  /// List of all kanji strokes that should be rendered
  final List<Path> strokes;
  /// List of all `Paint` that should be usde when drawing `strokes`
  final List<Paint> paints;
  /// The animation controller to draw `strokes` animated on this canvas
  final AnimationController animationController;


  const AnimatedKanjiPainter(
    this.strokes,
    this.paints,
    this.animationController,
  );

  @override
  void paint(Canvas canvas, Size size) {

    canvas.scale(size.width/109, size.height/109);

    for (int i = 0; i < strokes.length; i++) {
      
      Path path = strokes[i];
      Paint paint = paints[i];

      if(animationController.value >= i+1) {
        canvas.drawPath(path, paint);
      }
      else if (animationController.value.truncate() == i){
        ui.PathMetrics metrics = path.computeMetrics();
        int metricsAmount = path.computeMetrics().length;
        int metricsCount = 0;
        for (ui.PathMetric metric in metrics){
          double percentage;

          // draw all paths except the last one at full length
          if(metricsAmount > metricsCount+1) {
            percentage = metric.length;
          } else {
            percentage = metric.length *
              (animationController.value - animationController.value.truncate());
          }
          Path extractPath = metric.extractPath(0.0, percentage);
          canvas.drawPath(
            extractPath,
            paint
          );
          metricsCount += 1;
        }
      }
    }
  
  }

  @override
  bool shouldRepaint(AnimatedKanjiPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(AnimatedKanjiPainter oldDelegate) => false;
}

