// Dart imports:
import 'dart:io';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:local_assets_server/local_assets_server.dart';

class Reader extends StatefulWidget {
  const Reader({super.key});

  @override
  State<Reader> createState() => _ReaderState();
}

class _ReaderState extends State<Reader> {

  bool isListening = false;
  
  String? address;

  int? port;

  InAppWebViewController? webViewController;
  
  String initialUrl = "";

  @override
  void initState() {
    
    super.initState();

  }

  Future<bool> _initServer() async {
    final server = LocalAssetsServer(
      address: InternetAddress.loopbackIPv4,
      assetsBasePath: 'assets/web/reader/foliate-js/',
      //rootDir: ,
      logger: const DebugLogger(),
    );

    final address = await server.serve();

    this.address = address.address;
    port = server.boundPort!;
    isListening = true;
    
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initServer(),
      builder: (context, snapshot) {

        if(snapshot.hasData != true) return const SizedBox();

        return InAppWebView(
          initialUrlRequest: URLRequest(url: WebUri('http://$address:$port/reader.html')),
          initialSettings: InAppWebViewSettings(
            javaScriptEnabled: true,
            javaScriptCanOpenWindowsAutomatically: true
          ),
          onWebViewCreated: (controller) {
            webViewController = controller;
          },
          onConsoleMessage: (controller, consoleMessage) {

          },
        );
      }
    );
  }
}
