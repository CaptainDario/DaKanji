import 'dart:typed_data';
import 'package:da_kanji_mobile/show_cases/DrawScreenShowcase.dart';
import 'package:da_kanji_mobile/view/DaKanjiShowCaseElement.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:da_kanji_mobile/model/DrawScreen/DrawingInterpreter.dart';
import 'package:da_kanji_mobile/provider/drawing/Strokes.dart';
import 'package:da_kanji_mobile/view/drawing/DrawingCanvas.dart';



class DrawScreenDrawingCanvas extends StatelessWidget {
  const DrawScreenDrawingCanvas(
    this.canvasSize,
    this.drawingInterpreter,
    {Key? key}
  ) : super(key: key);

  final double canvasSize;
  final DrawingInterpreter drawingInterpreter;

  @override
  Widget build(BuildContext context) {
    return Consumer<Strokes>(
      builder: (context, strokes, __){
        return DrawingCanvas(
          canvasSize, canvasSize,
          strokes,
          EdgeInsets.all(0),
          onFinishedDrawing: (Uint8List image) async {
            drawingInterpreter.runInference(image);
          },
          onDeletedLastStroke: (Uint8List image) {
            if(strokes.strokeCount > 0)
              drawingInterpreter.runInference(image);
            else
              drawingInterpreter.clearPredictions();
          },
          onDeletedAllStrokes: () {
            drawingInterpreter.clearPredictions();
          },
        );
      },
    );
  }
}