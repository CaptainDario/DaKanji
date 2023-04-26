import "package:flutter/material.dart";

import 'package:tuple/tuple.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import 'package:da_kanji_mobile/domain/settings/settings.dart';
import 'package:da_kanji_mobile/domain/drawing/draw_screen_layout.dart';
import 'package:da_kanji_mobile/widgets/drawing/draw_screen_portrait.dart';
import 'package:da_kanji_mobile/widgets/drawing/draw_screen_landscape.dart';
import 'package:da_kanji_mobile/widgets/drawing/draw_screen_portrait_with_webview.dart';
import 'package:da_kanji_mobile/widgets/drawing/draw_screen_landscape_with_webview.dart';



// Widget which builds the DrawScreen matching the current screen orientation
class DrawScreenResponsiveLayout extends StatelessWidget {

  final Widget drawingCanvas;
  final Widget predictionButtons;
  final Widget multiCharSearch;
  final Widget undoButton;
  final Widget clearButton;
  final double canvasSize;
  final DrawScreenLayout layout;
  final InAppWebView? webView;

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

    if (layout == DrawScreenLayout.portrait) {
      drawScreen = DrawScreenPortrait(drawingCanvas, predictionButtons, multiCharSearch,
        undoButton, clearButton, canvasSize
      );
    } else if (layout == DrawScreenLayout.landscape) {
      drawScreen = DrawScreenLandscape(drawingCanvas, predictionButtons, multiCharSearch, 
        undoButton, clearButton, canvasSize
      );
    } else if (layout == DrawScreenLayout.portraitWithWebview) {
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
Tuple2<DrawScreenLayout, double> getDrawScreenLayout(BoxConstraints constraints){

  DrawScreenLayout layout = DrawScreenLayout.portrait;

  // init size of canvas
  //landscape
  double cBHeight = constraints.biggest.height;
  double cBWidth = constraints.biggest.width;

  double canvasSize = 0;

  // webview is enabled
  if(GetIt.I<Settings>().drawing.useWebview){
    // LANDSCAPE + WEBVIEW
    if(cBWidth / 2 > cBHeight){
      layout = DrawScreenLayout.landscapeWithWebview;
      canvasSize = cBHeight * 0.7;
    }
    // PORTRAIT + WEBVIEW
    else if(cBWidth > cBHeight){
      layout = DrawScreenLayout.portraitWithWebview;
      canvasSize = cBHeight * 0.55 > cBWidth/2 - 10 ?
        cBWidth/2 - 10 : cBHeight * 0.55;
    }
    //portrait
    else if(cBWidth < cBHeight){
      layout = DrawScreenLayout.portrait;
      canvasSize = cBHeight * 0.55 > cBWidth - 10 ?
        cBWidth - 10 : cBHeight * 0.55;
    }
  }
  // webview is disabled
  else {
    // portrait
    if(cBWidth < cBHeight){
      layout = DrawScreenLayout.portrait;
      canvasSize = cBHeight * 0.55 > cBWidth - 10 ?
        cBWidth - 10 : cBHeight * 0.55;
    }
    //landscape
    else{
      layout = DrawScreenLayout.landscape;
      canvasSize = cBHeight * 0.7;
    }
  }

  return Tuple2<DrawScreenLayout, double>(layout, canvasSize);
}
