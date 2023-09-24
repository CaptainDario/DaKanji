import 'package:flutter/material.dart';
import 'dart:ui' as ui;



class CalligraphyPenPainter extends CustomPainter {

  /// The list of points where the user moved the pen - finger
  final List<List<Offset>> paths;
  /// The pressure of the stylus at this frame
  final List<double> penPressures;
  /// The angle of the stylus at this frame
  final List<double> penTilts;

  final ui.Image brush;

  CalligraphyPenPainter(
    {
      required this.brush,
      required this.paths,
      required this.penPressures,
      required this.penTilts,
    }
  );

  @override
  void paint(Canvas canvas, Size size) {
    
    for (List<Offset> path in paths) {
      
      for (var i = 1; i < path.length; i++) {
        canvas.save();
        // translate canvas so that the current point is the origin
        canvas.translate(path[i].dx, path[i].dy);
        // rotate canvas by the angle between the points
        Offset p = path[i-1]- path[i];
        canvas.rotate(p.direction);

        canvas.drawImage(
          brush,
          Offset.zero,
          Paint()..style = PaintingStyle.stroke
        );
        canvas.restore();
      }
    }
    
    
  }

  double calculateStrokeWidth(double penPressure) {
    // Adjust the stroke width based on the pen pressure
    return 2.0 + penPressure * 10.0;
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}