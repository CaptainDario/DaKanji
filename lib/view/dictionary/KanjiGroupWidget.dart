import 'package:flutter/material.dart';
import 'dart:math';

import 'package:da_kanji_mobile/model/TreeNode.dart';



class KanjiGroupWidget extends StatefulWidget {
  KanjiGroupWidget(
    this.kanjiGroups,
    this.width,
    this.height,
    {Key? key}
  ) : super(key: key);

  /// Tree containing the kanji group hirarchy to be displayed
  final TreeNode<String> kanjiGroups; 
  /// the height of this widget
  final double height;
  /// the width of this widget
  final double width;

  @override
  State<KanjiGroupWidget> createState() => _KanjiGroupWidgetState();
}

class _KanjiGroupWidgetState extends State<KanjiGroupWidget> {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: KanjiGroupsPainter(),
      size: Size(widget.width, widget.height),
    );
  }
}

/// CustomPainter used for drawing a tree of characters
class KanjiGroupsPainter extends CustomPainter {

  @override
  void paint(Canvas canvas, Size size) {

    //canvas.drawRect(
    //  Rect.fromLTRB(0, 0, size.width, size.height),
    //  Paint()..color = Colors.blue
    //);

    drawCircleChar(30, Offset(100, 30), "品", canvas);

    drawCircleChar(30, Offset(30, 100), "口", canvas);
    drawCircleChar(30, Offset(100, 100), "口", canvas);
    drawCircleChar(30, Offset(170, 100), "口", canvas);
    
  }

  /// Draws a hollow circle with `char` in it at `circleOffset`
  void drawCircleChar(double circleRadius, Offset circleOffset, String char, Canvas canvas){

    if(char.length > 1) throw "Only *single* characters are allowed as input";

    // text max side length
    double tS = circleRadius * sqrt(2);
    // text offset (x and y)
    double tO = (2*circleRadius - tS) / 2;

    drawCircle(circleOffset, circleRadius, canvas);

    TextStyle textStyle = TextStyle(color: Colors.black, fontSize: 1);
    TextPainter textPainter;
    
    // iterate over font sizes until a font size fills the circle either in x or y
    while (true){
      textStyle = TextStyle(
        color: Colors.black,
        fontSize: textStyle.fontSize!+1
      );
      final textSpan = TextSpan(text: char, style: textStyle,);
      textPainter = TextPainter(text: textSpan, textDirection: TextDirection.ltr);
      textPainter.layout();

      if(textPainter.size.width > tS || textPainter.size.height > tS) break;
    }

    double h = textPainter.size.height;
    double w = textPainter.size.width;
    final textOffset = Offset(
      // rectangle offset + offset if the character is taller than wide 
      tO + circleOffset.dx - circleRadius + (h > w ? ((h - w) / 2) : 0),
      // rectangle offset + offset if the character is wider than tall
      tO + circleOffset.dy - circleRadius + (w > h ? ((w - h) / 2) : 0),
    );
    textPainter.paint(canvas, textOffset);
  }

  /// Draws a hollow circle at `center` with radius of `radius` on the given
  /// `canvas`
  void drawCircle(Offset center, double radius, Canvas canvas){

    double strokeWidth = 2;
    final paint = Paint()
      ..color = Colors.black
      ..strokeCap = StrokeCap.round
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;
      
    final path = Path()
      ..moveTo(center.dx, center.dy - radius)
      ..arcToPoint(
        Offset(center.dx, center.dy + radius),
        radius: Radius.circular(0.01)
      )
      ..arcToPoint(
        Offset(center.dx, center.dy - radius),
        radius: Radius.circular(0.01)
      );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(KanjiGroupsPainter oldDelegate) => false;
  @override
  bool shouldRebuildSemantics(KanjiGroupsPainter oldDelegate) => false;
}