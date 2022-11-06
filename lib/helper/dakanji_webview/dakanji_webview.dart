import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:universal_io/io.dart';

import 'package:da_kanji_mobile/helper/dakanji_webview/dakanji_webview_windows.dart';
import 'package:webview_flutter/webview_flutter.dart' as wv_flutter;



class DaKanjiWebView extends StatefulWidget {
  const DaKanjiWebView(
    {
      this.initialUrl = "",
      this.onLoaded,
      super.key
    }
  );

  @override
  State<DaKanjiWebView> createState() => _DaKanjiWebViewState();

  /// The url to initially load
  final String initialUrl;

  final void Function()? onLoaded;
}

class _DaKanjiWebViewState extends State<DaKanjiWebView> {

  @override
  Widget build(BuildContext context) {
    if (Platform.isWindows) {
      return WebViewWindows(
        initialUrl: widget.initialUrl,
      );
    }
    else if (Platform.isAndroid || Platform.isIOS || kIsWeb) {
      return wv_flutter.WebView(
        initialUrl: widget.initialUrl,
      );
    }
    else {
      return Text("Unsupported platform."
        "Most likely you are not supposed to see this."
        "Please open an issue or send an email if you are not a developer."
      );
    }
  }
}