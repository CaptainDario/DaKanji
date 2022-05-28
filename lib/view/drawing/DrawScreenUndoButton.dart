import 'package:flutter/material.dart';

import 'package:get_it/get_it.dart';
import 'package:keyboard_shortcuts/keyboard_shortcuts.dart';
import 'package:provider/provider.dart';

import 'package:da_kanji_mobile/show_cases/Tutorials.dart';
import 'package:da_kanji_mobile/provider/drawing/Strokes.dart';
import 'package:da_kanji_mobile/provider/Settings.dart';



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
                child: KeyBoardShortcuts(
                  keysToPress: GetIt.I<Settings>().settingsDrawing.kbUndoStroke,
                  onKeysPressed: () => undo(strokes),
                  child: IconButton(
                    icon: Icon(Icons.undo),
                    iconSize: 100,
                    color: Theme.of(context).highlightColor,
                    onPressed: () => undo(strokes)
                  ),
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