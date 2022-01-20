import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:tuple/tuple.dart';



/// Checks if the app should be lay out in landscape mode or portrait mode.
/// By using the `constraints` of the available space the app runs in.
/// Returns a tuple of which the first element is a bool. It is true when
/// the app is running in landscape mode and false otherwise.
/// The second element is the size of the drawing canvas
Tuple2<bool, double> DrawScreenRunsInLandscape(BoxConstraints constraints){

  bool landscape;

  // init size of canvas
  //landscape
  double cBHeight = constraints.biggest.height;
  double cBWidth = constraints.biggest.width;

  double canvasSize;

  // set the app in landscape mode if there is space to
  // place the prediction buttons in two rows to the right of the canvas
  if(cBWidth > cBHeight*0.8 + cBHeight*0.8*0.4+10){
    var columnSpacing = 10;
    canvasSize = cBHeight * 0.8 - columnSpacing;
    landscape = true;
  }
  // portrait
  else{
    var predictionButtonheight = cBHeight * 0.35;
    var rowSpacing = 40;
    canvasSize = cBHeight - predictionButtonheight - rowSpacing;
    // assure that the canvas is not wider than the screen
    if(canvasSize > cBWidth)
      canvasSize = cBWidth - 10;

    landscape = false;
  }

  return Tuple2<bool, double>(landscape, canvasSize);
}

/// Builds the DrawScreen in landscape or portrait mode according to the current 
/// device / window it is running on and returns it.
Widget DrawScreenResponsiveLayout(
  Widget drawingCanvas, Widget predictionButtons, Widget multiCharSearch,
  Widget undoButton, Widget clearButton, double canvasSize, bool landscape){

  Widget layout;

  if(landscape)
    layout = DrawScreenLandscapeLayout(drawingCanvas, predictionButtons, multiCharSearch, 
      undoButton, clearButton, canvasSize
    );
  else
    layout = DrawScreenPortraitLayout(drawingCanvas, predictionButtons, multiCharSearch,
      undoButton, clearButton, canvasSize
    );

  return layout;
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
        SizedBox(height: 10,),
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

  layout = Center(
    child: LayoutGrid(
      //rowGap: 5,
      columnGap: 10,
      columnSizes: [
        FixedTrackSize(canvasSize), 
        FixedTrackSize(canvasSize * 0.2), 
        FixedTrackSize(canvasSize * 0.2)
      ], 
      rowSizes: [FixedTrackSize(canvasSize), FixedTrackSize(canvasSize*0.2)],
      children: [
        drawingCanvas.withGridPlacement(columnStart: 0, rowStart: 0),
        predictionButtons.withGridPlacement(
          columnStart: 1, columnSpan: 2, rowStart: 0
        ),
        multiCharSearch.withGridPlacement(columnStart: 0, rowStart: 1),
        Align(alignment: Alignment.topCenter, child: undoButton),
        clearButton
      ],
    ),
  );
  return layout;
}