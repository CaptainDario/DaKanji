// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:da_kanji_mobile/widgets/immersion/youtube_fullscreen.dart';
import 'package:da_kanji_mobile/widgets/widgets/da_kanji_loading_indicator.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class YoutubeBrowser extends StatefulWidget {
  const YoutubeBrowser({super.key});

  @override
  State<YoutubeBrowser> createState() => _YoutubeBrowserState();
}

class _YoutubeBrowserState extends State<YoutubeBrowser> {

  /// Webviewcontroller to manage the webview that shows youtube
  late final InAppWebViewController _inAppWebViewController;
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
        ],
      );
  }
}
