import 'package:flutter/material.dart';

import 'package:webview_flutter/webview_flutter.dart';

import 'package:da_kanji_mobile/view/drawing/DrawScreenPortrait.dart';



// Drawscreen in portrait layout with a webview side by side
class DrawScreenPortraitWithWebview extends StatelessWidget {
  
  final Widget drawingCanvas;
  final Widget predictionButtons;
  final Widget multiCharSearch;
  final Widget undoButton;
  final Widget clearButton;
  final double canvasSize;
  final WebView? webView;
  
  const DrawScreenPortraitWithWebview(
    this.drawingCanvas,
    this.predictionButtons,
    this.multiCharSearch,
    this.undoButton, 
    this.clearButton,
    this.canvasSize,
    this.webView,
    {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    Widget drawScreen = DrawScreenPortrait(
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
            child: this.webView!,
          ),
          SizedBox(width: 5,),
        ],
      );
    }

    return drawScreen;
  }
}