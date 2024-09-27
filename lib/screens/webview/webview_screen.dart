// Dart imports:
import 'dart:math';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get_it/get_it.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

// Project imports:
import 'package:da_kanji_mobile/application/drawing/handle_predictions.dart';
import 'package:da_kanji_mobile/entities/drawing/draw_screen_state.dart';

/// This screen opens the given [url]
/// and shows [char] fullscreen while loading.
class WebviewScreen extends StatefulWidget {

  const WebviewScreen({super.key});

  @override
  State<WebviewScreen> createState() => _WebviewScreenState();
}

class _WebviewScreenState extends State<WebviewScreen>
  with TickerProviderStateMixin{

  /// should the webview be loaded 
  late InAppWebViewController inAppWebViewController;
  /// should the loading screen be shown (hides webview)
  bool showLoading = false;
  /// the screen's width 
  late double width;
  /// the AnimationController to rotate the loading / webview
  late AnimationController _controller;
  /// the animation to rotate the loading / webview
  late Animation _rotationAnimation;
  /// the controller to animate the DaKanji icon while the webview is loading
  late AnimationController _loadingController;
  /// the animation to rotate the DaKanji icon while the webview is loading
  late Animation<double> _loadingAnimation;


  @override
  void initState() { 
    super.initState();
    
    _loadingController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat(reverse: true);
    _loadingAnimation = CurvedAnimation(
      parent: _loadingController,
      curve: Curves.elasticOut,
    );
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _rotationAnimation = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(
        0.0, 1.00,
        curve: Curves.linear
      ),
    ));
    _controller.addListener(() {setState(() {});});
    
  }

  @override
  void dispose() { 
    _controller.dispose();
    _loadingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){

    width = MediaQuery.of(context).size.width;

    // add a listener to when the screen change animation finished
    var route = ModalRoute.of(context);
    void handler(status) {
      if (status == AnimationStatus.completed) {
        route!.animation!.removeStatusListener(handler);

        inAppWebViewController.loadUrl(
          urlRequest: URLRequest(
            url: WebUri.uri(Uri.parse(
              openWithSelectedDictionary(GetIt.I<DrawScreenState>().drawingLookup.chars)
            ))
          )
        ).then((value) => 
            _controller.forward(from: 0.0)
          );
        setState(() {});
      }
    }
    route?.animation?.addStatusListener(handler);
    
    return Scaffold(
      appBar: AppBar(title: Text(GetIt.I<DrawScreenState>().drawingLookup.chars)),
      body: 
      
      PopScope(
        // when leaving this screen hide the webview  
        onPopInvokedWithResult: (didPop, result) {
          setState(() {
            showLoading = false;
            _controller.reverse();
          });
          //return Future.delayed(const Duration(milliseconds: 500), () => true);
        },
        child: Stack(
          children: [
            // webview
            Transform.translate(
              offset: Offset(
                (width) * (1 - _rotationAnimation.value), 
                0
              ),
              child: Transform(
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..multiply(Matrix4.rotationY(
                    (_rotationAnimation.value - 1) * (pi/2))
                  ),
                alignment: Alignment.centerLeft,
                child: InAppWebView(
                  initialUrlRequest: URLRequest(
                    url: WebUri(
                      openWithSelectedDictionary(GetIt.I<DrawScreenState>().drawingLookup.chars)
                    )
                  ),
                  onLoadStop: (controller, uri) {
                    _controller.forward(from: 0.0);
                  }
                )
              )
            ),
            
            // show DaKanji icon while the webview is loading
            Transform.translate(
              offset: Offset(
                (width) * (1 - _rotationAnimation.value) - width,
                0
              ),
              child: Transform(
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..multiply(Matrix4.rotationY(
                    _rotationAnimation.value * pi/2
                  )),
                alignment: Alignment.centerRight,
                child: Hero(
                  tag: "webviewHero_${GetIt.I<DrawScreenState>().drawingLookup.buffer ? "b_" : ""}${GetIt.I<DrawScreenState>().drawingLookup.chars}",
                  child: Container(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    child: Center(
                      child: () {
                        return DefaultTextStyle(
                          style: TextStyle(
                            color: Theme.of(context).textTheme.labelLarge?.color,
                            decoration: TextDecoration.none,
                            fontSize: 50,
                            fontWeight: FontWeight.normal,
                          ),
                          child: RotationTransition(
                            turns: _loadingAnimation,
                            child: const Image(
                              image: AssetImage('assets/images/dakanji/icon.png'),
                              width: 150,
                            ),
                          ),
                        );
                      } (),
                    )
                  )
                )
              )
            )
          ]
        ),
      )
    );
  }
}




