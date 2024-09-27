// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

// Project imports:
import 'package:da_kanji_mobile/widgets/drawing/draw_screen_portrait.dart';

// Package imports:


// Drawscreen in portrait layout with a webview side by side
class DrawScreenPortraitWithWebview extends StatelessWidget {
  
  final Widget drawingCanvas;
  final Widget predictionButtons;
  final Widget multiCharSearch;
  final Widget undoButton;
  final Widget clearButton;
  final double canvasSize;
  final InAppWebView? webView;
  
  const DrawScreenPortraitWithWebview(
    this.drawingCanvas,
    this.predictionButtons,
    this.multiCharSearch,
    this.undoButton, 
    this.clearButton,
    this.canvasSize,
    this.webView,
    {super.key});

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
          const SizedBox(width: 5,),
          Expanded(
            child: Center(child: 
              drawScreen
            )
          ),
          const SizedBox(width: 5,),
          Expanded(
            child: webView!,
          ),
          const SizedBox(width: 5,),
        ],
      );
    }

    return drawScreen;
  }
}
