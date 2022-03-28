import 'package:da_kanji_mobile/show_cases/DrawScreenShowCaseElement.dart';
import 'package:feature_discovery/feature_discovery.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:da_kanji_mobile/show_cases/DrawScreenShowcase.dart';
import 'package:da_kanji_mobile/provider/drawing/Strokes.dart';



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
        return DrawScreenShowCaseElement(
          [drawScreenShowcaseIDs[2]],
          [Text(drawScreenShowcaseTexts[2])],
          [ContentLocation.trivial],
          Center(
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