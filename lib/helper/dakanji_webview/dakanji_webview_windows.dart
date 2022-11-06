import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';

import 'package:webview_windows/webview_windows.dart';



class WebViewWindows extends StatefulWidget {

  const WebViewWindows(
    {
      this.initialUrl = "",
      super.key
    }
  );

  @override
  State<WebViewWindows> createState() => _WebViewWindowsState();

  /// The url to initially load
  final String initialUrl;
}

class _WebViewWindowsState extends State<WebViewWindows> {

  final _controller = WebviewController();
  final _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> initPlatformState() async {
    // Optionally initialize the webview environment using
    // a custom user data directory
    // and/or a custom browser executable directory
    // and/or custom chromium command line flags
    //await WebviewController.initializeEnvironment(
    //    additionalArguments: '--show-fps-counter');

    try {
      await _controller.initialize();
      _controller.url.listen((url) {
        _textController.text = url;
      });

      await _controller.setBackgroundColor(Colors.transparent);
      await _controller.setPopupWindowPolicy(WebviewPopupWindowPolicy.deny);
      await _controller.loadUrl(widget.initialUrl);

      if (!mounted) return;
        setState(() {});
      }
      on PlatformException catch (e) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: Text('Error'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Code: ${e.code}'),
                  Text('Message: ${e.message}'),
                ],
              ),
              actions: [
                TextButton(
                  child: Text('Continue'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            )
          );
        });
      }
  }

  Widget compositeView() {
    if (!_controller.value.isInitialized) {
      return const Text(
        'Not Initialized',
        style: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.w900,
        ),
      );
    } else {
      return Stack(
        children: [
          Webview(
            _controller,
          ),
          StreamBuilder<LoadingState>(
            stream: _controller.loadingState,
            builder: (context, snapshot) {
              if (snapshot.hasData &&
                  snapshot.data == LoadingState.loading) {
                return LinearProgressIndicator();
              } else {
                return SizedBox();
              }
            }
          ),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return compositeView();
  }

}