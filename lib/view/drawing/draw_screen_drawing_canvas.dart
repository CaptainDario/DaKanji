import 'dart:typed_data';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:get_it/get_it.dart';

import 'package:da_kanji_mobile/show_cases/tutorials.dart';
import 'package:da_kanji_mobile/model/DrawScreen/drawing_interpreter.dart';
import 'package:da_kanji_mobile/provider/drawing/strokes.dart';
import 'package:da_kanji_mobile/view/drawing/drawing_canvas.dart';



class DrawScreenDrawingCanvas extends StatelessWidget {
  const DrawScreenDrawingCanvas(
    this.canvasSize,
    this.drawingInterpreter,
    this.includeTutorial,
    {Key? key}
  ) : super(key: key);

  final double canvasSize;
  final DrawingInterpreter drawingInterpreter;
  final bool includeTutorial;

  @override
  Widget build(BuildContext context) {
    return Consumer<Strokes>(
      builder: (context, strokes, __){
        return Focus(
          focusNode: includeTutorial ? 
            GetIt.I<Tutorials>().drawScreenTutorial.canvasSteps : null,
          child: DrawingCanvas(
            canvasSize, canvasSize,
            strokes,
            const EdgeInsets.all(0),
            onFinishedDrawing: (Uint8List image) async {
              drawingInterpreter.runInference(image);
            },
            onDeletedLastStroke: (Uint8List image) {
              if(strokes.strokeCount > 0) {
                drawingInterpreter.runInference(image);
              } else {
                drawingInterpreter.clearPredictions();
              }
            },
            onDeletedAllStrokes: () {
              drawingInterpreter.clearPredictions();
            },
          ),
        );
      },
    );
  }
}