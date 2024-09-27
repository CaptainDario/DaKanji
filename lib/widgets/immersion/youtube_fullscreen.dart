// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

// Package imports:

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

  /// Webviewcontroller to manage the webview that shows youtube
  late final InAppWebViewController _inAppWebViewController;
  

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
  }

  double _scale = 1.0;

  void loadFullScreenVideo(){
    /*_inAppWebViewController.loadHtmlString(
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
    );*/
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onScaleUpdate: (scaleDetails) {
        _scale = scaleDetails.scale;
      },
      onScaleEnd: (details) {
        if(_scale < 0.5){
          //_inAppWebViewController.loadRequest(Uri.parse('about:blank'));
          Navigator.pop(context);
        }
      },
      child: Text("redo")
    );
  }

}
