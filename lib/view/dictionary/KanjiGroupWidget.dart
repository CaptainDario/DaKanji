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

    canvas.drawRect(
      Rect.fromLTRB(0, 0, size.width, size.height),
      Paint()..color = Colors.blue
    );

    // circle radius
    double cR = 50;
    // circle offset
    Offset cO = Offset(100, 50);

    // text side length
    double tS = cR * sqrt(2);
    // text offset (x and y)
    double tO = (2*cR - tS) / 2;

    drawCircle(cO, cR, canvas);

    TextStyle textStyle = TextStyle(color: Colors.black, fontSize: 1);
    TextPainter textPainter;
    
    // iterate over font sizes until a font size fills the circle either in x or y
    while (true){
      textStyle = TextStyle(
        color: Colors.black,
        fontSize: textStyle.fontSize!+1
      );
      final textSpan = TextSpan(text: '鬱', style: textStyle,);
      textPainter = TextPainter(text: textSpan, textDirection: TextDirection.ltr);
      textPainter.layout();

      if(textPainter.size.width > tS || textPainter.size.height > tS) break;
    }

    double h = textPainter.size.height;
    double w = textPainter.size.width;
    final offset = Offset(
      // rectangle offset + offset if the character is taller than wide 
      tO + cO.dx - cR + (h > w ? ((h - w) / 2) : 0),
      // rectangle offset + offset if the character is wider than tall
      tO + cO.dy - cR + (w > h ? ((w - h) / 2) : 0),
    );
    textPainter.paint(canvas, offset);
    
  }

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

  // Since this Sky painter has no fields, it always paints
  // the same thing and semantics information is the same.
  // Therefore we return false here. If we had fields (set
  // from the constructor) then we would return true if any
  // of them differed from the same fields on the oldDelegate.
  @override
  bool shouldRepaint(KanjiGroupsPainter oldDelegate) => false;
  @override
  bool shouldRebuildSemantics(KanjiGroupsPainter oldDelegate) => false;
}