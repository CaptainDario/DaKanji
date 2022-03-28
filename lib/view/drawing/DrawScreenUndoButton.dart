import 'package:da_kanji_mobile/show_cases/DrawScreenShowcase.dart';
import 'package:da_kanji_mobile/view/DaKanjiShowCaseElement.dart';
import 'package:feature_discovery/feature_discovery.dart';
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
        return DaKanjiShowCaseElement(
          [drawScreenShowcaseIDs[1]],
          [Text(drawScreenShowcaseTexts[1])],
          [ContentLocation.trivial],
          Center(
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