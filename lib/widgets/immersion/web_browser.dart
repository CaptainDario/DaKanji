// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:webview_flutter/webview_flutter.dart';

class WebBrowser extends StatefulWidget {
  const WebBrowser({super.key});

  @override
  State<WebBrowser> createState() => _WebBrowserState();
}

class _WebBrowserState extends State<WebBrowser> {

  /// Webviewcontroller to manage the webview that shows youtube
  late final WebViewController _webViewController;

  final String startUrl = "https://www.google.com";

  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant WebBrowser oldWidget) {
    init();
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    super.dispose();
  }

  void init(){

    setupController();
    _webViewController.loadRequest(Uri.parse(startUrl));
  }

  void setupController(){
    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onUrlChange: (change) {
            
          },
          onPageFinished: (url) {
            _setUpJavascriptChannel();
          },
        )
      )
      ..setOnConsoleMessage((message) {
        //print("testtest: ${message.message}");
      });
  }

  void _setUpJavascriptChannel() {
    _webViewController.runJavaScript('''
document.addEventListener("selectionchange", () => {
  console.log(document.getSelection().toString());
});
    ''');

    /*_webViewController.addJavaScriptChannel(
      'onSelectionChange',
      onMessageReceived: (JavaScriptMessage message) {
        setState(() {
          var selectedText = message.message;
          print('Selected text: $selectedText');
        });
      },
    );*/
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      
      children: [
        const Text("Test"),
        Expanded(
          child: WebViewWidget(
            controller: _webViewController,
          ),
        ),
      ],
    );
  }

}
