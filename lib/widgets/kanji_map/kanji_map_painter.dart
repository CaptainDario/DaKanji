import 'package:flutter/material.dart';



class KanjiMapPainter extends CustomPainter {

  /// the kanji characters that should be shown in this map
  List<String> kanjis = const [];
  /// the cooridnates of `kanjis`
  List<List<double>> coors = const [];

  double leftLimit = double.infinity;

  double rightLimit = double.negativeInfinity;

  double bottomLimit = double.infinity;

  double topLimit = double.negativeInfinity;

  KanjiMapPainter(
    {
      required this.kanjis,
      required this.coors,
      required this.leftLimit,
      required this.rightLimit,
      required this.bottomLimit,
      required this.topLimit,
    }
  );

  @override
  void paint(Canvas canvas, Size size){

    const textStyle = TextStyle(
      color: Colors.black,
      fontSize: 1,
    );

    for (int i = 0; i < kanjis.length; i++){
      
      TextSpan textSpan = TextSpan(
        text: kanjis[i],
        style: textStyle,
      );
      final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout(
        minWidth: 0,
        maxWidth: size.width,
      );
      final offset = Offset(
        (coors[i][0]*4 + size.width/2),
        (coors[i][1]*4 + size.height/2)
      );
      textPainter.paint(canvas, offset);
    }
  }

  @override
  bool shouldRepaint(KanjiMapPainter oldDelegate) => false;


}