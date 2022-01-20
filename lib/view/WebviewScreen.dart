import 'dart:math';
import 'package:flutter/material.dart';

import 'package:webviewx/webviewx.dart';
import 'package:get_it/get_it.dart';

import 'package:da_kanji_mobile/provider/Lookup.dart';



/// This screen opens the given [url]
/// and shows [char] fullscreen while loading.
class WebviewScreen extends StatefulWidget {

  WebviewScreen();

  @override
  _WebviewScreenState createState() => _WebviewScreenState();
}

class _WebviewScreenState extends State<WebviewScreen>
  with TickerProviderStateMixin{

  /// should the webview be loaded 
  bool loadWebview = false;
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
    _rotationAnimation = new Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(new CurvedAnimation(
      parent: _controller,
      curve: Interval(
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
        setState(() {
          loadWebview = true;
        });
      }
    }
    route?.animation?.addStatusListener(handler);
    
    return Scaffold(
      appBar: AppBar(title: Text(GetIt.I<Lookup>().chars)),
      body: 
      
      WillPopScope(
        // when leaving this screen hide the webview  
        onWillPop: () {
          setState(() {
            showLoading = false;
            _controller.reverse();
          });
          return Future.delayed(Duration(milliseconds: 500), () => true);
        },
        child: Container(
          child: 
            Stack(
              children: [
                // webview
                Transform.translate(
                  offset: Offset(
                    (width) * (1 - _rotationAnimation.value), 
                    0
                  ),
                  child: Transform(
                    transform: new Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..multiply(Matrix4.rotationY(
                        (_rotationAnimation.value - 1) * (pi/2))
                      ),
                    alignment: Alignment.centerLeft,
                    child: () {
                        if(loadWebview){
                          return WebViewX(
                            initialContent:  GetIt.I<Lookup>().url,
                            height: MediaQuery.of(context).size.height,
                            width: width,
                            onPageFinished: (s) {
                              _controller.forward(from: 0.0);
                            }
                          );
                        }
                        else
                          return Container(color: Colors.green,);
                    } ()
                  )
                ),
                
                // show DaKanji icon while the webview is loading
                Transform.translate(
                  offset: Offset(
                    (width) * (1 - _rotationAnimation.value) - width,
                    0
                  ),
                  child: Transform(
                    transform: new Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..multiply(Matrix4.rotationY(
                        _rotationAnimation.value * pi/2
                      )),
                    alignment: Alignment.centerRight,
                    child: Hero(
                      tag: "webviewHero_" 
                        + (GetIt.I<Lookup>().buffer ? "b_" : "")
                        + GetIt.I<Lookup>().chars,
                      child: Container(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        child: Center(
                          child: () {
                            return DefaultTextStyle(
                              style: TextStyle(
                                color: Theme.of(context).textTheme.button?.color,
                                decoration: TextDecoration.none,
                                fontSize: 50,
                                fontWeight: FontWeight.normal,
                              ),
                              child: RotationTransition(
                                turns: _loadingAnimation,
                                child: Image(
                                  image: AssetImage('media/icon.png'),
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
        )
    );
  }
}




