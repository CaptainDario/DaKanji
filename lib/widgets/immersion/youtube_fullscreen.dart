import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';



class YoutubeFullscreen extends StatefulWidget {


  /// ID of the video that should be shown
  final String videoID;

  const YoutubeFullscreen(
    this.videoID,
    {
      super.key
    }
  );

  @override
  State<YoutubeFullscreen> createState() => _YoutubeFullscreenState();
}

class _YoutubeFullscreenState extends State<YoutubeFullscreen> {

  /// Webview params to create the webview controller
  late final PlatformWebViewControllerCreationParams params;
  /// Webviewcontroller to manage the webview that shows youtube
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

  @override
  void dispose() {
    super.dispose();
  }

  void init(){
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
      ..setBackgroundColor(Colors.black)
      ..setNavigationDelegate(
        NavigationDelegate(
          onUrlChange: (change) {
            
          },
        )
      );

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      loadFullScreenVideo();
    });
  }

  double _scale = 1.0;

  void loadFullScreenVideo(){
    _webViewController.loadHtmlString(
      """
      <!DOCTYPE html>
      <html>
      <body style="margin:0px;padding:0px;overflow:hidden">
        <iframe
          style="overflow:hidden;overflow-x:hidden;overflow-y:hidden;height:100%;width:100%;position:absolute;top:0px;left:0px;right:0px;bottom:0px;border:none;" height="100%" width="100%"
          scrolling="no"
          src="https://www.youtube.com/embed/${widget.videoID}">
        </iframe>
      </body>
      </html>
      """
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onScaleUpdate: (scaleDetails) {
        _scale = scaleDetails.scale;
      },
      onScaleEnd: (details) {
        if(_scale < 0.5){
          _webViewController.loadRequest(Uri.parse('about:blank'));
          Navigator.pop(context);
        }
      },
      child: WebViewWidget(
        controller: _webViewController
      ),
    );
  }

}