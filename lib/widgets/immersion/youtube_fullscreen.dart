import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';



class YoutubeFullscreen extends StatefulWidget {
  const YoutubeFullscreen({super.key});

  @override
  State<YoutubeFullscreen> createState() => _YoutubeFullscreenState();
}

class _YoutubeFullscreenState extends State<YoutubeFullscreen> {

  late final PlatformWebViewControllerCreationParams params;

  late final WebViewController _webViewController;

  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant YoutubeFullscreen oldWidget) {
    init();
    super.didUpdateWidget(oldWidget);
  }

  void init(){
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    _webViewController = WebViewController.fromPlatformCreationParams(params)
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (url) {
          },
        )
      );

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _webViewController.loadHtmlString(
        """
          <iframe width=${MediaQuery.sizeOf(context).width}
            src="https://www.youtube.com/embed/mwKJfNYwvm8">
          </iframe>
        """
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return WebViewWidget(
      controller: _webViewController
    );
  }
}