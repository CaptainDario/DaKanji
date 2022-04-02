import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:da_kanji_mobile/provider/drawing/Strokes.dart';
import 'package:da_kanji_mobile/show_cases/DrawScreenTutorial.dart';



class DrawScreenClearButton extends StatelessWidget {
  const DrawScreenClearButton(
    this.canvasSize,
    {Key? key}
  ) : super(key: key);

  final double canvasSize;



  @override
  Widget build(BuildContext context) {
    return Consumer<Strokes>(
      builder: (contxt, strokes, _) {
        return Focus(
          focusNode: drawScreenTutorialFocusNodes[3],
          child: Center(
            child: Container(
              width: canvasSize * 0.1,
              child: FittedBox(
                child: IconButton(
                  icon: Icon(Icons.clear),
                  iconSize: 100,
                  color: Theme.of(context).highlightColor,
                  onPressed: () {
                    strokes.playDeleteAllStrokesAnimation = true;
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