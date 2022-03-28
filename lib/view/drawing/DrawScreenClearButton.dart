import 'package:da_kanji_mobile/view/DaKanjiShowCaseElement.dart';
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
        return DescribedFeatureOverlay(
          tapTarget: Icon(Icons.add),
          featureId: "draw_screen_01",
          backgroundColor: Color.fromARGB(0, 0, 0, 0),
          backgroundOpacity: 0,
          targetColor: Color.fromARGB(148, 255, 255, 255),
          title: Text("hello"),
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