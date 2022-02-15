import 'dart:typed_data';
import 'package:flutter/material.dart';

import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'package:da_kanji_mobile/model/core/Screens.dart';
import 'package:da_kanji_mobile/model/core/DrawingInterpreter.dart';
import 'package:da_kanji_mobile/view/drawing/DrawScreenShowcase.dart';
import 'package:da_kanji_mobile/provider/drawing/KanjiBuffer.dart';
import 'package:da_kanji_mobile/provider/drawing/Strokes.dart';
import 'package:da_kanji_mobile/provider/drawing/DrawScreenState.dart';
import 'package:da_kanji_mobile/provider/drawing/DrawScreenLayout.dart';
import 'package:da_kanji_mobile/view/DaKanjiDrawer.dart';
import 'package:da_kanji_mobile/view/drawing/PredictionButton.dart';
import 'package:da_kanji_mobile/view/drawing/KanjiBufferWidget.dart';
import 'package:da_kanji_mobile/view/drawing/DrawingCanvas.dart';
import 'package:da_kanji_mobile/view/drawing/DrawScreenResponsive.dart';
import 'package:da_kanji_mobile/globals.dart';
import 'package:da_kanji_mobile/model/helper/HandlePredictions.dart';



/// The "draw"-screen.
/// 
/// Lets the user draw a kanji and than shows the most likely predictions.
/// Those can than be copied / opened in dictionaries by buttons.
class DrawScreen extends StatefulWidget {

  // init the tutorial of the draw screen
  final showcase = DrawScreenShowcase();
  /// was this page opened by clicking on the tab in the drawer
  final bool openedByDrawer;
  // should the hero widgets for animating to the webview be included
  final bool includeHeroes;

  DrawScreen(this.openedByDrawer, this.includeHeroes);

  @override
  _DrawScreenState createState() => _DrawScreenState();
}

class _DrawScreenState extends State<DrawScreen> with TickerProviderStateMixin {
  /// the size of the canvas widget
  late double _canvasSize;
  /// The controller of the webview which is used to show a dict in landscape
  WebViewController? landscapeWebViewController;
  /// in which layout the DrawScreen is being built
  DrawScreenLayout drawScreenLayout = GetIt.I<DrawScreenState>().drawScreenLayout;


  @override
  void initState() {
    super.initState();

    GetIt.I<DrawScreenState>().drawingLookup.addListener(() {
      if(GetIt.I<DrawScreenState>().drawScreenLayout == DrawScreenLayout.LandscapeWithWebview)
        landscapeWebViewController?.loadUrl(
          openWithSelectedDictionary(GetIt.I<DrawScreenState>().drawingLookup.chars)
        );
    });

    if(!GetIt.I<DrawingInterpreter>().wasInitialized){
      // initialize the drawing interpreter
      GetIt.I<DrawingInterpreter>().init();
    }
  }

  @override
  void dispose() {
    super.dispose();
    GetIt.I<DrawScreenState>().drawingLookup.removeListener(() {
      if(GetIt.I<DrawScreenState>().drawScreenLayout == DrawScreenLayout.LandscapeWithWebview)
        landscapeWebViewController?.loadUrl(
          openWithSelectedDictionary(GetIt.I<DrawScreenState>().drawingLookup.chars)
        );
    });
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
        value: GetIt.I<DrawScreenState>().strokes,
        child: LayoutBuilder(
          builder: (context, constraints){

            var t = GetDrawScreenLayout(constraints);
            GetIt.I<DrawScreenState>().drawScreenLayout = t.item1;
            bool runningInLandscape = 
              t.item1 == DrawScreenLayout.Landscape || 
              t.item1 == DrawScreenLayout.LandscapeWithWebview;
              _canvasSize = t.item2;
            GetIt.I<DrawScreenState>().canvasSize = _canvasSize;
            
            
            // the canvas to draw on
            Widget drawingCanvas = Consumer<Strokes>(
              builder: (context, strokes, __){
                return DrawingCanvas(
                  _canvasSize, _canvasSize,
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
              value: GetIt.I<DrawScreenState>().kanjiBuffer,
              child: Consumer<KanjiBuffer>(
                builder: (context, kanjiBuffer, child){
                  Widget widget = Center(
                    key: SHOW_SHOWCASE_DRAWING ? SHOWCASE_DRAWING[6].key : GlobalKey(),
                    child: KanjiBufferWidget(
                      _canvasSize,
                      runningInLandscape ? 1.0 : 0.7,
                    )
                  );
                  if (this.widget.includeHeroes)
                    widget = Hero(
                      tag: "webviewHero_b_" + (kanjiBuffer.kanjiBuffer == "" 
                        ? "Buffer" 
                        : kanjiBuffer.kanjiBuffer),
                      child: widget
                    );
                  return widget;
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
              //use canvas height in runningInLandscape
              width :  runningInLandscape ? (_canvasSize * 0.4) : _canvasSize,
              height: !runningInLandscape ? (_canvasSize * 0.4) : _canvasSize, 
              child: ChangeNotifierProvider.value(
                value: GetIt.I<DrawingInterpreter>(),
                child: Consumer<DrawingInterpreter>(
                  builder: (context, interpreter, child){
                    return GridView.count(
                      //padding: EdgeInsets.all(2),
                      physics: new NeverScrollableScrollPhysics(),
                      scrollDirection: runningInLandscape ? Axis.horizontal : Axis.vertical,
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
                        if(this.widget.includeHeroes)
                          widget = Hero(
                            tag: "webviewHero_" + (interpreter.predictions[i] == " " 
                              ? i.toString() 
                              : interpreter.predictions[i]),
                            child: widget,
                          );

                        return widget;
                      },
                      )
                    );
                  }
                ),
              )
            ); 

            WebView? wV;
            if(GetIt.I<DrawScreenState>().drawScreenLayout == DrawScreenLayout.LandscapeWithWebview){
              wV = WebView(
                initialUrl: openWithSelectedDictionary(""),
                onWebViewCreated: (controller) => landscapeWebViewController = controller,
              );
            }

            return DrawScreenResponsiveLayout(drawingCanvas, predictionButtons, 
              multiCharSearch, undoButton, clearButton, _canvasSize, runningInLandscape, wV
            );
          }
        ),
      ),
    );
  }
}
