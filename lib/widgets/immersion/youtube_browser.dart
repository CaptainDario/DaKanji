// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

// Project imports:
import 'package:da_kanji_mobile/widgets/immersion/youtube_fullscreen.dart';
import 'package:da_kanji_mobile/widgets/widgets/da_kanji_loading_indicator.dart';

class YoutubeBrowser extends StatefulWidget {
  const YoutubeBrowser({super.key});

  @override
  State<YoutubeBrowser> createState() => _YoutubeBrowserState();
}

class _YoutubeBrowserState extends State<YoutubeBrowser> {

  /// Webview params to create the webview controller
  late final PlatformWebViewControllerCreationParams params;
  /// Webviewcontroller to manage the webview that shows youtube
  late final WebViewController _webViewController;
  /// is youtube still loading
  bool youtubeLoading = true;

  String currentUrl = "";

  String? currentVideoID;

  RegExp videoIdRegex = RegExp(r"watch\?v=(.*)");



  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant YoutubeBrowser oldWidget) {
    init();
    super.didUpdateWidget(oldWidget);
  }

  void init(){

    // on iOS explicitly allow inline video playback
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
      );
    }
    else {
      params = const PlatformWebViewControllerCreationParams();
    }

    _webViewController = WebViewController.fromPlatformCreationParams(params)
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(NavigationDelegate(
        onPageFinished: (url) async {
          
        },
        onUrlChange: (change) async {
          if(youtubeLoading) youtubeLoading = false;

          currentUrl = await _webViewController.currentUrl() ?? "";
          currentVideoID = videoIdRegex.firstMatch(currentUrl)?.group(1);

          setState(() {});
        },
        //onNavigationRequest: (request) {
          //if(!["www.youtube.com", "youtube.com",
          //  "youtube.com", "youtube.com"].any((e) => request.url.startsWith(e))){
          //  return NavigationDecision.prevent;
          //}
          //return NavigationDecision.navigate;
        //},
      ));

    _webViewController
      .loadRequest(Uri.parse("https://www.youtube.com/watch?v=mwKJfNYwvm8"));
  }

  @override
  void dispose() {
    //_webViewController.loadRequest(Uri.parse('about:blank'));
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return youtubeLoading
      ? const DaKanjiLoadingIndicator()
      : Stack(
        children: [
          WebViewWidget(
            controller: _webViewController,
          ),
          if(currentVideoID != null)
            Positioned(
              bottom: 16,
              right: 16,
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                    context, 
                    MaterialPageRoute(
                      builder: (BuildContext context) =>
                        YoutubeFullscreen(currentVideoID!)
                    )
                  );
                },
                child: const Icon(Icons.fullscreen),
              ),
            )
        ],
      );
  }
}
