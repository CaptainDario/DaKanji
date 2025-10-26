// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

// Project imports:
import 'package:da_kanji_mobile/widgets/drawing/draw_screen_landscape.dart';

class DrawScreenLandscapeWithWebview extends StatelessWidget {
  
  final Widget drawingCanvas;
  final Widget predictionButtons;
  final Widget multiCharSearch;
  final Widget undoButton;
  final Widget clearButton;
  final double canvasSize;
  final InAppWebView? webView;
  
  const DrawScreenLandscapeWithWebview(
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
      Widget drawScreen = DrawScreenLandscape(
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
            child: webView!,
          )
        ],
      );
    }
    
    return drawScreen;
  }
}
