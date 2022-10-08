import 'package:flutter/material.dart';

import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:keybinder/keybinder.dart';

import 'package:da_kanji_mobile/show_cases/tutorials.dart';
import 'package:da_kanji_mobile/provider/drawing/strokes.dart';
import 'package:da_kanji_mobile/provider/settings.dart';
import 'package:da_kanji_mobile/model/DrawScreen/draw_screen_state.dart';



class DrawScreenUndoButton extends StatelessWidget {
  
  DrawScreenUndoButton(
    this.canvasSize,
    this.includeTutorial,
    {Key? key}
  ) : super(key: key) {
    Keybinder.bind(
      Keybinding.from(GetIt.I<Settings>().settingsDrawing.kbUndoStroke),
      () => undo(GetIt.I<DrawScreenState>().strokes)
    );
  }

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