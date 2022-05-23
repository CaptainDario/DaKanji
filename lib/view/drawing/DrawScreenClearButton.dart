import 'package:da_kanji_mobile/model/DrawScreen/DrawScreenState.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:get_it/get_it.dart';

import 'package:da_kanji_mobile/provider/Settings.dart';
import 'package:da_kanji_mobile/show_cases/Tutorials.dart';
import 'package:da_kanji_mobile/provider/drawing/Strokes.dart';
import 'package:da_kanji_mobile/view/drawing/DrawingPainter.dart';



class DrawScreenClearButton extends StatelessWidget {
  const DrawScreenClearButton(
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
      builder: (contxt, strokes, _) {
        return Focus(
          focusNode: includeTutorial ?
            GetIt.I<Tutorials>().drawScreenTutorial.clearButtonSteps : null,
          child: Center(
            child: Container(
              width: canvasSize * 0.1,
              child: FittedBox(
                child: IconButton(
                  icon: Icon(Icons.clear),
                  iconSize: 100,
                  color: Theme.of(context).highlightColor,
                  onPressed: () async {
                    if(!GetIt.I<Settings>().useThanosSnap)
                      strokes.playDeleteAllStrokesAnimation = true;
                    else{
                      GetIt.I<DrawScreenState>().snappableKey.currentState?.snap(
                        await DrawingPainter(
                          GetIt.I<DrawScreenState>().strokes.path, 
                          false, 
                          Size(
                            GetIt.I<DrawScreenState>().canvasSize,
                            GetIt.I<DrawScreenState>().canvasSize
                          ),
                          1.0
                        ).getRGBAListFromCanvas(),
                        GetIt.I<DrawScreenState>().canvasSize.floor(),
                        GetIt.I<DrawScreenState>().canvasSize.floor() 
                      );
                    }
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