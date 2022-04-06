import 'package:flutter/material.dart';



final List<Offset> kuchiStrokes = [
  Offset( 0.75,  0.75),
  Offset(-0.75,  0.75),
  Offset(-0.75, -0.75),
  Offset( 0.75, -0.75),
  Offset( 0.75,  0.75),
];

final List<Offset> nichiStroke = [
  Offset( 0.75,  0.0),
  Offset(-0.75,  0.0),
];

final List<Offset> meStroke1 = [
  Offset( 0.75,  0.25),
  Offset(-0.75,  0.25),
];
final List<Offset> meStroke2 = [
  Offset( 0.75, -0.25),
  Offset(-0.75, -0.25),
];


String kuchiPrediction = "囗";
String nichiPrediction = "日";
String mePrediction    = '目';

String kanjiBuffer_1 = "目";
String kanjiBuffer_2 = "目日";
String kanjiBuffer_3 = "目日囗";
