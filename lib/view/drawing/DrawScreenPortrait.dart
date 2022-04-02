import 'package:flutter/material.dart';

import 'package:sizer/sizer.dart';



/// The DrawScreen in portrait mode 
class DrawScreenPortrait extends StatelessWidget {

  final Widget drawingCanvas;
  final Widget predictionButtons;
  final Widget multiCharSearch;
  final Widget undoButton;
  final Widget clearButton;
  final double canvasSize;

  const DrawScreenPortrait(
    this.drawingCanvas,
    this.predictionButtons,
    this.multiCharSearch,
    this.undoButton,
    this.clearButton,
    this.canvasSize,
    { Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
  Widget layout = Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        SizedBox(height: 2.h,),
        drawingCanvas,
        SizedBox(height: 2.h,),
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
        SizedBox(height: 4.h,),
        predictionButtons
      ]
    ),
  );

  return layout;
  }
}