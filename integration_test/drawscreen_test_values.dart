import 'package:flutter/material.dart';



final List<Offset> kuchiStrokes = [
  Offset( 0.5,  0.5),
  Offset(-0.5,  0.5),
  Offset(-0.5, -0.5),
  Offset( 0.5, -0.5),
  Offset( 0.5,  0.5),
];

final List<Offset> nichiStroke = [
  Offset( 0.5,  0.0),
  Offset(-0.5,  0.0),
];

final List<Offset> meStroke1 = [
  Offset( 0.5,  0.25),
  Offset(-0.5,  0.25),
];
final List<Offset> meStroke2 = [
  Offset( 0.5, -0.25),
  Offset(-0.5, -0.25),
];


List<String> kuchiPredictions = ["囗", "冂", "凵", "ロ", "口", "間", "匸", "匚", "屆", "頤",];
List<String> nichiPredictions = ["日", "囗", "曰", "巳", "冂", "凵", "旧", "臼", "ロ", "間",];
List<String> mePredictions    = ['目', '日', '曰', '囗', '旦', '且', '旧', '巳', '臼', 'ロ',];
