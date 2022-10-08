import "package:flutter/material.dart";

import 'package:tuple/tuple.dart';
import 'package:get_it/get_it.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'package:da_kanji_mobile/provider/Settings.dart';
import 'package:da_kanji_mobile/model/DrawScreen/DrawScreenLayout.dart';
import 'package:da_kanji_mobile/view/drawing/DrawScreenPortrait.dart';
import 'package:da_kanji_mobile/view/drawing/DrawScreenLandscape.dart';
import 'package:da_kanji_mobile/view/drawing/DrawScreenPortraitWithWebview.dart';
import 'package:da_kanji_mobile/view/drawing/DrawScreenLandscapeWithWebview.dart';



// Widget which builds the DrawScreen matching the current screen orientation
class DrawScreenResponsiveLayout extends StatelessWidget {

  final Widget drawingCanvas;
  final Widget predictionButtons;
  final Widget multiCharSearch;
  final Widget undoButton;
  final Widget clearButton;
  final double canvasSize;
  final DrawScreenLayout layout;
  final WebView? webView;

  const DrawScreenResponsiveLayout(
    this.drawingCanvas,
    this.predictionButtons,
    this.multiCharSearch,
    this.undoButton, 
    this.clearButton,
    this.canvasSize,
    this.layout,
    this.webView,
    {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget drawScreen;

    if (layout == DrawScreenLayout.Portrait) {
      drawScreen = DrawScreenPortrait(drawingCanvas, predictionButtons, multiCharSearch,
        undoButton, clearButton, canvasSize
      );
    } else if (layout == DrawScreenLayout.Landscape) {
      drawScreen = DrawScreenLandscape(drawingCanvas, predictionButtons, multiCharSearch, 
        undoButton, clearButton, canvasSize
      );
    } else if (layout == DrawScreenLayout.PortraitWithWebview) {
      drawScreen = DrawScreenPortraitWithWebview(drawingCanvas, predictionButtons, multiCharSearch, 
        undoButton, clearButton, canvasSize, webView);
    } else {
      drawScreen = DrawScreenLandscapeWithWebview(drawingCanvas, predictionButtons, multiCharSearch, 
        undoButton, clearButton, canvasSize, webView);
    }

    return Center(
      child: drawScreen
    );
  }
}

/// Checks if the app should be lay out in landscape or portrait mode.
/// By using the `constraints` of the available space the app runs in.
/// Returns a tuple of which the first element is a bool. It is true when
/// the app is running in landscape mode and false otherwise.
/// The second element is the size of the drawing canvas
Tuple2<DrawScreenLayout, double> GetDrawScreenLayout(BoxConstraints constraints){

  DrawScreenLayout layout = DrawScreenLayout.Portrait;

  // init size of canvas
  //landscape
  double cBHeight = constraints.biggest.height;
  double cBWidth = constraints.biggest.width;

  double canvasSize = 0;

  // webview is enabled
  if(GetIt.I<Settings>().settingsDrawing.useWebview){
    // LANDSCAPE + WEBVIEW
    if(cBWidth / 2 > cBHeight){
      layout = DrawScreenLayout.LandscapeWithWebview;
      canvasSize = cBHeight * 0.7;
    }
    // PORTRAIT + WEBVIEW
    else if(cBWidth > cBHeight){
      layout = DrawScreenLayout.PortraitWithWebview;
      canvasSize = cBHeight * 0.55 > cBWidth/2 - 10 ?
        cBWidth/2 - 10 : cBHeight * 0.55;
    }
    //portrait
    else if(cBWidth < cBHeight){
      layout = DrawScreenLayout.Portrait;
      canvasSize = cBHeight * 0.55 > cBWidth - 10 ?
        cBWidth - 10 : cBHeight * 0.55;
    }
  }
  // webview is disabled
  else {
    // portrait
    if(cBWidth < cBHeight){
      layout = DrawScreenLayout.Portrait;
      canvasSize = cBHeight * 0.55 > cBWidth - 10 ?
        cBWidth - 10 : cBHeight * 0.55;
    }
    //landscape
    else{
      layout = DrawScreenLayout.Landscape;
      canvasSize = cBHeight * 0.7;
    }
  }

  return Tuple2<DrawScreenLayout, double>(layout, canvasSize);
}
