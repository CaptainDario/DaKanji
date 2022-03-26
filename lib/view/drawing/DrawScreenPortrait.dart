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
    { Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
  Widget layout = Center(
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
}