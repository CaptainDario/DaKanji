import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:da_kanji_mobile/provider/drawing/Strokes.dart';



class DrawScreenUndoButton extends StatelessWidget {
  const DrawScreenUndoButton(
  this.canvasSize,
  {Key? key}
  ) : super(key: key);

  final double canvasSize;

  @override
  Widget build(BuildContext context) {
    return Consumer<Strokes>(
      builder: (context, strokes, __) {
        return Center(
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
        );
      }
    );
  }
}