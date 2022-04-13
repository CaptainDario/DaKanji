import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'package:provider/provider.dart';

import 'package:da_kanji_mobile/show_cases/Tutorials.dart';
import 'package:da_kanji_mobile/provider/drawing/Strokes.dart';



class DrawScreenUndoButton extends StatelessWidget {
  const DrawScreenUndoButton(
  this.canvasSize,
  this.includeTutorial,
  {Key? key}
  ) : super(key: key);

  /// the size of the DrawingCanvas
  final double canvasSize;
  /// should the tutorial Focus be included
  final bool includeTutorial;

  @override
  Widget build(BuildContext context) {
    return Consumer<Strokes>(
      builder: (context, strokes, __) {
        return Focus(
          focusNode: includeTutorial ? 
            GetIt.I<Tutorials>().drawScreenTutorial.undoButtonSteps : null,
          child: Center(
            child: Container(
              width:  canvasSize * 0.1,
              child: FittedBox(
                child: IconButton(
                  icon: Icon(Icons.undo),
                  iconSize: 100,
                  color: Theme.of(context).highlightColor,
                  onPressed: () {
                    strokes.playDeleteLastStrokeAnimation = true;
                  }
                ),
              ),
            ),
          ),
        );
      }
    );
  }
}