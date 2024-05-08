// Dart imports:
import 'dart:typed_data';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:da_kanji_mobile/entities/drawing/drawing_interpreter.dart';
import 'package:da_kanji_mobile/entities/drawing/strokes.dart';
import 'package:da_kanji_mobile/entities/show_cases/tutorials.dart';
import 'package:da_kanji_mobile/widgets/drawing/drawing_canvas.dart';

class DrawScreenDrawingCanvas extends StatelessWidget {
  const DrawScreenDrawingCanvas(
    this.canvasSize,
    this.drawingInterpreter,
    this.includeTutorial,
    {super.key}
  );

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
              await drawingInterpreter.runInference(image);
            },
            onDeletedLastStroke: (Uint8List image) async {
              if(strokes.strokeCount > 0) {
                await drawingInterpreter.runInference(image);
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
