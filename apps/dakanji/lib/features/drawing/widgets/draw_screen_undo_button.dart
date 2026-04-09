// Flutter imports:
// Project imports:
import 'package:da_kanji_mobile/features/drawing/model/strokes.dart';
import 'package:da_kanji_mobile/features/tutorial/model/tutorials.dart';
import 'package:flutter/material.dart';
// Package imports:
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class DrawScreenUndoButton extends StatelessWidget {
  
  const DrawScreenUndoButton(
    this.canvasSize,
    this.includeTutorial,
    {super.key}
  );

  /// the size of the DrawingCanvas
  final double canvasSize;
  /// should the tutorial Focus be included
  final bool includeTutorial;

  @override
  Widget build(BuildContext context) {
    return Consumer<Strokes>(
      builder: (context, strokes, _) {
        return Focus(
          focusNode: includeTutorial ? 
            GetIt.I<Tutorials>().drawScreenTutorial.undoButtonSteps : null,
          child: Center(
            child: SizedBox(
              width:  canvasSize * 0.1,
              child: FittedBox(
                child: IconButton(
                  icon: const Icon(Icons.undo),
                  iconSize: 100,
                  color: Theme.of(context).highlightColor,
                  onPressed: () => undo(strokes)
                ),
              ),
            ),
          ),
        );
      }
    );
  }

  void undo(Strokes strokes){
    strokes.playDeleteLastStrokeAnimation = true;
  }
}
