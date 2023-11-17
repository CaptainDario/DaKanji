import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';



class YoutubeBrowser extends StatefulWidget {
  const YoutubeBrowser({super.key});

  @override
  State<YoutubeBrowser> createState() => _YoutubeBrowserState();
}

class _YoutubeBrowserState extends State<YoutubeBrowser> {

  late final PlatformWebViewControllerCreationParams params;

  late final WebViewController _webViewController;


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

    _webViewController.loadRequest(Uri.parse("https://www.youtube.com/watch?v=mwKJfNYwvm8"))
      .then((value) => setState(() {}));

  }

  @override
  void dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        WebViewWidget(
          controller: _webViewController,
        ),
        Positioned(
          bottom: 16,
          right: 16,
          child: FloatingActionButton(
            onPressed: () {},
            child: const Icon(Icons.fullscreen),
          ),
        )
      ],
    );
  }
}