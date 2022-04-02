import 'package:flutter/material.dart';

import 'package:flutter_layout_grid/flutter_layout_grid.dart';



class DrawScreenLandscape extends StatelessWidget {
  
  final Widget drawingCanvas;
  final Widget predictionButtons;
  final Widget multiCharSearch;
  final Widget undoButton;
  final Widget clearButton;
  final double canvasSize;
  
  const DrawScreenLandscape(
    this.drawingCanvas,
    this.predictionButtons,
    this.multiCharSearch,
    this.undoButton,
    this.clearButton,
    this.canvasSize,
    {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Widget layout = LayoutGrid(
      columnSizes: [
        FixedTrackSize(canvasSize),
        FixedTrackSize((MediaQuery.of(context).size.width*0.2).clamp(0, 10)),
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
}