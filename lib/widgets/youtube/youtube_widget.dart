// Dart imports:
import 'dart:convert';

// Flutter imports:
import 'package:da_kanji_mobile/widgets/youtube/youtube_iframe_player.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get_it/get_it.dart';
import 'package:html/parser.dart' as html_parser;
import 'package:http/http.dart' as http;
import 'package:onboarding_overlay/onboarding_overlay.dart';

// Project imports:
import 'package:da_kanji_mobile/entities/show_cases/tutorials.dart';
import 'package:da_kanji_mobile/entities/user_data/user_data.dart';
import 'package:youtube_caption_scraper/youtube_caption_scraper.dart';



class YoutubeWidget extends StatefulWidget {

  /// was this page opened by clicking on the tab in the drawer
  final bool openedByDrawer;
  /// should the focus nodes for the tutorial be included
  final bool includeTutorial;


  const YoutubeWidget(
    this.openedByDrawer,
    this.includeTutorial,
    {
      super.key
    }
  );

  @override
  State<YoutubeWidget> createState() => _YoutubeWidgetState();
}

class _YoutubeWidgetState extends State<YoutubeWidget> {

  /// Controller of the webview for youtube
  InAppWebViewController? webViewController;

  bool isOnVideoPage = false;

  double _currentPosition = 0.0;

  String youtubeVideoUrl = "https://www.youtube.com/";
  


  @override
  void initState() {
    super.initState();
    showTutorialCallback();
  }

  @override
  void dispose() {
    webViewController?.dispose();
    super.dispose();
  }

  void showTutorialCallback() {
    // after first frame
    WidgetsBinding.instance.addPostFrameCallback((Duration timeStamp) {

      if(widget.includeTutorial){
        // init tutorial
        final OnboardingState? onboarding = Onboarding.of(context);
        if(onboarding != null && 
          GetIt.I<UserData>().showTutorialYoutube) {
          onboarding.showWithSteps(
            GetIt.I<Tutorials>().youtubeScreenTutorial.indexes![0],
            GetIt.I<Tutorials>().youtubeScreenTutorial.indexes!
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    return Stack(
      children: [
        InAppWebView(
          initialUrlRequest: URLRequest(url: WebUri.uri(Uri.parse(youtubeVideoUrl))),
          initialSettings: InAppWebViewSettings(
            javaScriptEnabled: true,
            
          ),
          onWebViewCreated: (controller) {
            webViewController = controller;

            // Add JavaScript handler to receive current time
            getCurrentTime();
          },
          onLoadStop: (controller, url) async {
            injectJS();
          },
          onTitleChanged: (controller, title) async {
            
            WebUri? url = await controller.getUrl();
        
            if (isYouTubeVideoUrl(url)) {

              setState(() {
                isOnVideoPage = true;
              });
            }
            else {
              setState(() { isOnVideoPage = false; });
            }
        
          },
          
        ),

        if(isOnVideoPage)
          Positioned(
            right: 50,
            left: 50,
            bottom: 100,
            child: GestureDetector(
              onTap: getCurrentTime,
              child: Container(
                height: 50,
                width: 50,
                color: Colors.blueGrey.withAlpha(200),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Test"
                  ),
                ),
              ),
            )
          )
      ],
    );

    
  }

  /// Call YouTube API to get the current video time
  void getCurrentTime() async {
    print(_currentPosition);
  }

  void injectJS() async {

    webViewController?.evaluateJavascript(source: """
      function getCurrentVideoPosition() {
        if (typeof player !== 'undefined' && player && typeof player.getCurrentTime === 'function') {
          return player.getCurrentTime();
        } else {
          return null;
        }
      }

      setInterval(function() {
        const position = getCurrentVideoPosition();
        if (position !== null) {
          window.flutter_inappwebview.callHandler('videoPosition', position);
        }
      }, 100); // Check every 100 milliseconds
    """);

    webViewController?.addJavaScriptHandler(
      handlerName: 'videoPosition',
      callback: (args) {
        setState(() {
          _currentPosition = args[0];
        });
      },
    );

  }

  bool isYouTubeVideoUrl(WebUri? uri) {
    if (uri == null) return false;

    final host = uri.host.toLowerCase();
    final path = uri.path;
    final queryParameters = uri.queryParameters;

    // Check for standard YouTube watch URLs
    if ((host.contains("youtube.com") && path == "/watch" && queryParameters.containsKey("v")) ||
        (host.contains("youtu.be") && path.isNotEmpty)) {
      return true;
    }
    return false;
  }

  Future youtubeSubtitleToWebVTT() async {

  }

}
