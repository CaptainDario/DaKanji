// Dart imports:
import 'dart:convert';

// Flutter imports:
import 'package:da_kanji_mobile/widgets/youtube/youtube_iframe_player.dart';
import 'package:da_kanji_mobile/widgets/youtube/youtube_js_scripts.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get_it/get_it.dart';
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
            mediaPlaybackRequiresUserGesture: true
          ),
          onWebViewCreated: (controller) {
            webViewController = controller;
          },
          onAjaxProgress: (controller, ajaxRequest) async {

            await controller.evaluateJavascript(source: """
              document.querySelectorAll('video').forEach(video => video.pause());
            """);
            
            if(isYouTubeVideoUrl(await controller.getUrl()))
              print('aksuflkasbgflkabjsf');

            return AjaxRequestAction.PROCEED;
          },
          onTitleChanged: (controller, title) async {
            
            WebUri? url = await controller.getUrl();
            print(url);
        
            if (isYouTubeVideoUrl(url)) {

              
              return;
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return Scaffold(
                  body: YoutubeIframePlayer(
                    url.toString(),
                    onClosePressed: (){
                      Navigator.pop(context);
                    }
                  )
                );
              }));
            }
            else {

            }
        
          },
          
        ),

      ],
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
