import 'dart:typed_data';

import 'package:da_kanji_mobile/view/drawing/DrawScreenResponsive.dart';
import 'package:flutter/material.dart';

import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import 'package:da_kanji_mobile/model/core/Screens.dart';
import 'package:da_kanji_mobile/model/core/DrawingInterpreter.dart';
import 'package:da_kanji_mobile/view/drawing/DrawScreenShowcase.dart';
import 'package:da_kanji_mobile/provider/KanjiBuffer.dart';
import 'package:da_kanji_mobile/provider/Strokes.dart';
import 'package:da_kanji_mobile/view/DaKanjiDrawer.dart';
import 'package:da_kanji_mobile/view/drawing//PredictionButton.dart';
import 'package:da_kanji_mobile/view/drawing/KanjiBufferWidget.dart';
import 'package:da_kanji_mobile/view/drawing/DrawingCanvas.dart';
import 'package:da_kanji_mobile/globals.dart';


/// The "draw"-screen.
/// 
/// Lets the user draw a kanji and than shows the most likely predictions.
/// Those can than be copied / opened in dictionaries by buttons.
class DrawScreen extends StatefulWidget {

  // init the tutorial of the draw screen
  final showcase = DrawScreenShowcase();
  /// was this page opened by clicking on the tab in the drawer
  final bool openedByDrawer;

  DrawScreen(this.openedByDrawer);

  @override
  _DrawScreenState createState() => _DrawScreenState();
}

class _DrawScreenState extends State<DrawScreen> with TickerProviderStateMixin {
  /// the size of the canvas widget
  late double _canvasSize;

  @override
  void initState() {
    super.initState();

    if(!GetIt.I<DrawingInterpreter>().wasInitialized){
      // initialize the drawing interpreter
      GetIt.I<DrawingInterpreter>().init();
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    // add a listener to when the Navigator animation finished
    var route = ModalRoute.of(context);
    void handler(status) {
      if (status == AnimationStatus.completed) {
        route!.animation!.removeStatusListener(handler);
        
        if(SHOW_SHOWCASE_DRAWING){
          widget.showcase.init(context);
          widget.showcase.show();
        }
      }
    }
    route!.animation!.addStatusListener(handler);


    return DaKanjiDrawer(
      currentScreen: Screens.drawing,
      animationAtStart: !widget.openedByDrawer,
      child: ChangeNotifierProvider.value(
        value: GetIt.I<Strokes>(),
        child: LayoutBuilder(
          builder: (context, constraints){

            var t = DrawScreenRunsInLandscape(constraints);
            bool landscape = t.item1;
            _canvasSize = t.item2;
            
            // the canvas to draw on
            Widget drawingCanvas = Consumer<Strokes>(
              builder: (context, strokes, __){
                return DrawingCanvas(
                  _canvasSize, 
                  _canvasSize,
                  strokes,
                  EdgeInsets.all(0),
                  SHOW_SHOWCASE_DRAWING ? SHOWCASE_DRAWING[0].key : GlobalKey(),
                  onFinishedDrawing: (Uint8List image) async {
                    GetIt.I<DrawingInterpreter>().runInference(image);
                  },
                  onDeletedLastStroke: (Uint8List image) {
                    if(strokes.strokeCount > 0)
                      GetIt.I<DrawingInterpreter>().runInference(image);
                    else
                      GetIt.I<DrawingInterpreter>().clearPredictions();
                  },
                  onDeletedAllStrokes: () {
                    GetIt.I<DrawingInterpreter>().clearPredictions();
                  },
                );
              },
            );
            // undo
            Widget undoButton = Consumer<Strokes>(
              builder: (context, strokes, __) {
                return Center(
                  child: Container(
                    width:  _canvasSize * 0.1,
                    child: FittedBox(
                      child: IconButton(
                        key: SHOW_SHOWCASE_DRAWING ? SHOWCASE_DRAWING[1].key : GlobalKey(),
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
            // multi character search input
            Widget multiCharSearch = ChangeNotifierProvider.value(
              value: GetIt.I<KanjiBuffer>(),
              child: Consumer<KanjiBuffer>(
                builder: (context, kanjiBuffer, child){
                  return  /*Hero(
                  tag: "webviewHero_b_" + 
                    (kanjiBuffer.kanjiBuffer == "" 
                      ? "Buffer" : kanjiBuffer.kanjiBuffer),
                    child: */
                    Center(
                      key: SHOW_SHOWCASE_DRAWING ? SHOWCASE_DRAWING[6].key : GlobalKey(),
                      child: KanjiBufferWidget(
                        _canvasSize,
                        landscape ? 1.0 : 0.7,
                      )
                    );
                  //);
                }
              ),
            );
            // clear
            Widget clearButton = Consumer<Strokes>(
              builder: (contxt, strokes, _) {
                return Center(
                  child: Container(
                    width: _canvasSize * 0.1,
                    child: FittedBox(
                      child: IconButton(
                        key: SHOW_SHOWCASE_DRAWING ? SHOWCASE_DRAWING[2].key : GlobalKey(),
                        icon: Icon(Icons.clear),
                        iconSize: 100,
                        color: Theme.of(context).highlightColor,
                        onPressed: () {
                          strokes.playDeleteAllStrokesAnimation = true;
                        }
                      ),
                    ),
                  ),
                );
              }
            );
            // prediction buttons
            Widget predictionButtons = Container(
              key: SHOW_SHOWCASE_DRAWING ? SHOWCASE_DRAWING[3].key : GlobalKey(),
              //use canvas height in landscape
              width :  landscape ? (_canvasSize * 0.4) : _canvasSize,
              height: !landscape ? (_canvasSize * 0.4) : _canvasSize, 
              child: ChangeNotifierProvider.value(
                value: GetIt.I<DrawingInterpreter>(),
                child: Consumer<DrawingInterpreter>(
                  builder: (context, interpreter, child){
                    return GridView.count(
                      //padding: EdgeInsets.all(2),
                      physics: new NeverScrollableScrollPhysics(),
                      scrollDirection: landscape ? Axis.horizontal : Axis.vertical,
                      crossAxisCount: 5,
                      mainAxisSpacing: 5,
                      crossAxisSpacing: 5,
                      
                      children: List.generate(10, (i) {
                        Widget widget = PredictionButton(interpreter.predictions[i]);
                        // instantiate short/long press showcase button
                        if(i == 0){
                          widget = Container(
                            key: SHOW_SHOWCASE_DRAWING ? SHOWCASE_DRAWING[4].key : GlobalKey(),
                            child: widget 
                          );
                        }
                        return Hero(
                          tag: "webviewHero_" + 
                            (interpreter.predictions[i] == " " 
                              ? i.toString() : interpreter.predictions[i]),
                          child: widget,
                        );
                      },
                      )
                    );
                  }
                ),
              )
            ); 

            return DrawScreenResponsiveLayout(drawingCanvas, predictionButtons, 
              multiCharSearch, undoButton, clearButton, _canvasSize, landscape
            );
          }
        ),
      ),
    );
  }
}
