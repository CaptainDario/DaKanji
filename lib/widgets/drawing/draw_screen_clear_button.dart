// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:da_kanji_mobile/data/show_cases/tutorials.dart';
import 'package:da_kanji_mobile/domain/drawing/draw_screen_state.dart';
import 'package:da_kanji_mobile/domain/drawing/strokes.dart';
import 'package:da_kanji_mobile/domain/settings/settings.dart';
import 'package:da_kanji_mobile/widgets/drawing/drawing_painter.dart';

class DrawScreenClearButton extends StatelessWidget {
  
  DrawScreenClearButton(
    this.canvasSize,
    this.includeTutorial,
    {Key? key}
  ) : super(key: key){}

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
            child: SizedBox(
              width: canvasSize * 0.1,
              child: FittedBox(
                child: IconButton(
                    icon: const Icon(Icons.clear),
                    iconSize: 100,
                    color: Theme.of(context).highlightColor,
                    onPressed: () => clear(strokes)
                  ),
              ),
            ),
          ),
        );
      }
    );
  }

  void clear (Strokes strokes) async {

    if(!GetIt.I<Settings>().advanced.useThanosSnap) {
      strokes.playDeleteAllStrokesAnimation = true;
    } else{
      GetIt.I<DrawScreenState>().snappableKey.currentState?.snap(
        await DrawingPainter(
          GetIt.I<DrawScreenState>().strokes.path, 
          true, 
          Size(
            GetIt.I<DrawScreenState>().canvasSize,
            GetIt.I<DrawScreenState>().canvasSize
          ),
          1.0
        ).getRGBAListFromCanvas(false),
        GetIt.I<DrawScreenState>().canvasSize.floor(),
        GetIt.I<DrawScreenState>().canvasSize.floor() 
      );
    }
  }

}
