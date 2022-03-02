import 'package:da_kanji_mobile/provider/Settings.dart';
import 'package:flutter/material.dart';

import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:tuple/tuple.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:get_it/get_it.dart';

import 'package:da_kanji_mobile/provider/drawing/DrawScreenLayout.dart';



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
  if(GetIt.I<Settings>().useWebview){
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

/// Builds the DrawScreen in landscape or portrait mode according to the current 
/// device / window it is running on and returns it.
Widget DrawScreenResponsiveLayout(
  Widget drawingCanvas, Widget predictionButtons, Widget multiCharSearch,
  Widget undoButton, Widget clearButton, double canvasSize, DrawScreenLayout layout,
  WebView? webView){

  Widget drawScreen;


  if (layout == DrawScreenLayout.Portrait)
    drawScreen = DrawScreenPortraitLayout(drawingCanvas, predictionButtons, multiCharSearch,
      undoButton, clearButton, canvasSize
    );
  else if (layout == DrawScreenLayout.Landscape)
    drawScreen = DrawScreenLandscapeLayout(drawingCanvas, predictionButtons, multiCharSearch, 
      undoButton, clearButton, canvasSize
    );
  // landscape with webview
  else if (layout == DrawScreenLayout.PortraitWithWebview)
    drawScreen = DrawScreenPortraitWithWebview(drawingCanvas, predictionButtons, multiCharSearch, 
      undoButton, clearButton, canvasSize, webView);
  // else if (layout == DrawScreenLayout.LandscapeWithWebview)
  else
    drawScreen = DrawScreenLandscapeWithWebview(drawingCanvas, predictionButtons, multiCharSearch, 
      undoButton, clearButton, canvasSize, webView);

  return Center(
    child: drawScreen
  );
}

/// Builds the DrawScreen in portrait mode and returns it.
Widget DrawScreenPortraitLayout(
  Widget drawingCanvas, Widget predictionButtons, Widget multiCharSearch,
  Widget undoButton, Widget clearButton, double canvasSize){
  
  Widget layout;
  
  layout = Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        drawingCanvas,
        SizedBox(height: 30,),
        Container(
          width: canvasSize,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              undoButton,
              multiCharSearch,
              clearButton
            ],
          ),
        ),
        SizedBox(height: 20,),
        predictionButtons
      ]
    ),
  );

  return layout;
}

/// Builds the DrawScreen in landscape mode and returns it.
Widget DrawScreenLandscapeLayout(
  Widget drawingCanvas, Widget predictionButtons, Widget multiCharSearch,
  Widget undoButton, Widget clearButton, double canvasSize){

  Widget layout;

  layout = LayoutGrid(
    columnSizes: [
      FixedTrackSize(canvasSize),
      FixedTrackSize(10),
      FixedTrackSize(canvasSize * 0.2), 
      FixedTrackSize(canvasSize * 0.2)
    ], 
    rowSizes: [FixedTrackSize(canvasSize), FixedTrackSize(canvasSize*0.2)],
    children: [
      drawingCanvas.withGridPlacement(columnStart: 0, rowStart: 0),
      Container(
        child: predictionButtons
      ).withGridPlacement(
          columnStart: 2, columnSpan: 2, rowStart: 0
        ),
      multiCharSearch.withGridPlacement(columnStart: 0, rowStart: 1),
      Align(
        alignment: Alignment.topCenter,
        child: undoButton
      ).withGridPlacement(columnStart: 2, rowStart: 1),
      Center(
        child: clearButton
      ).withGridPlacement(columnStart: 3, rowStart: 1)
    ],
  );
  
  return layout;
}

Widget DrawScreenPortraitWithWebview(
  Widget drawingCanvas, Widget predictionButtons, Widget multiCharSearch,
  Widget undoButton, Widget clearButton, double canvasSize, WebView? webView){

  Widget drawScreen = DrawScreenPortraitLayout(
    drawingCanvas, predictionButtons, multiCharSearch, 
    undoButton, clearButton, canvasSize
  );

  // if there is enough space for a webview add it to the layout
  if(webView != null){
    drawScreen = Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(width: 5,),
        Expanded(
          child: Center(child: 
            drawScreen
          )
        ),
        SizedBox(width: 5,),
        Expanded(
          child: webView,
        ),
        SizedBox(width: 5,),
      ],
    );
  }

  return drawScreen;

}

Widget DrawScreenLandscapeWithWebview(
  Widget drawingCanvas, Widget predictionButtons, Widget multiCharSearch,
  Widget undoButton, Widget clearButton, double canvasSize, WebView? webView){

    Widget drawScreen = DrawScreenLandscapeLayout(
      drawingCanvas, predictionButtons, multiCharSearch, 
      undoButton, clearButton, canvasSize
    );

  // if there is enough space for a webview add it to the layout
  if(webView != null){
    drawScreen = Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: Center(child: 
            drawScreen
          )
        ),
        Expanded(
          child: webView,
        )
      ],
    );
  }
  
  return drawScreen;

}

