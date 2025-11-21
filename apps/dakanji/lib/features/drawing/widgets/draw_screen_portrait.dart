// Flutter imports:
import 'package:flutter/material.dart';

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
    { super.key,});

  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;

    Widget layout = Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(height: height*0.02,),
          drawingCanvas,
          SizedBox(height: height*0.04,),
          SizedBox(
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
          SizedBox(height: height*0.02,),
          predictionButtons
        ]
      ),
    );

    return layout;
  }
}
