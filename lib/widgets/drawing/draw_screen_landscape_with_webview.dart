import 'package:flutter/material.dart';

import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import 'package:da_kanji_mobile/widgets/drawing/draw_screen_landscape.dart';
import 'package:webview_flutter/webview_flutter.dart';



class DrawScreenLandscapeWithWebview extends StatelessWidget {
  
  final Widget drawingCanvas;
  final Widget predictionButtons;
  final Widget multiCharSearch;
  final Widget undoButton;
  final Widget clearButton;
  final double canvasSize;
  final WebViewWidget? webView;
  
  const DrawScreenLandscapeWithWebview(
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