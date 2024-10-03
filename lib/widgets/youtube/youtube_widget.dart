import 'package:da_kanji_mobile/entities/show_cases/tutorials.dart';
import 'package:da_kanji_mobile/entities/user_data/user_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as html_parser;
import 'dart:convert';

import 'package:onboarding_overlay/onboarding_overlay.dart';

String youtubeVideoUrl = "https://www.youtube.com/watch?v=XnkQKn67qzM&t=74s";


class YoutubeWidget extends StatefulWidget {

  /// was this page opened by clicking on the tab in the drawer
  final bool openedByDrawer;
  /// should the focus nodes for the tutorial be included
  final bool includeTutorial;


  const YoutubeWidget(
    this.openedByDrawer,
    this.includeTutorial,
    {
      super.key
    }
  );

  @override
  State<YoutubeWidget> createState() => _YoutubeWidgetState();
}

class _YoutubeWidgetState extends State<YoutubeWidget> {

  InAppWebViewController? webViewController;

  @override
  void initState() {
    super.initState();
    showTutorialCallback();
  }


  void showTutorialCallback() {
    // after first frame
    WidgetsBinding.instance.addPostFrameCallback((Duration timeStamp) {

      if(widget.includeTutorial){
        // init tutorial
        final OnboardingState? onboarding = Onboarding.of(context);
        if(onboarding != null && 
          GetIt.I<UserData>().showTutorialYoutube) {
          onboarding.showWithSteps(
            GetIt.I<Tutorials>().youtubeScreenTutorial.indexes![0],
            GetIt.I<Tutorials>().youtubeScreenTutorial.indexes!
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('YouTube Video & Subtitles'),
        ),
        body: InAppWebView(
          initialUrlRequest: URLRequest(url: WebUri.uri(Uri.parse(youtubeVideoUrl))),
          onWebViewCreated: (controller) {
            webViewController = controller;
          },
          onLoadStop: (controller, url) async {
            String? htmlContent = await controller.evaluateJavascript(
                source: "document.documentElement.outerHTML;");
            if (htmlContent != null) {
              _fetchSubtitles(htmlContent);
            }
          },
        ),
      ),
    );
  }

  void _fetchSubtitles(String htmlContent) async {
    final document = html_parser.parse(htmlContent);

    // Find script tags in the HTML content
    final scripts = document.getElementsByTagName('script');
    String? captionUrl;

    for (var script in scripts) {
      if (script.text.contains('captions')) {
        // Captions data is embedded in JSON format within a script
        final regExp = RegExp(r'"captions":({.*?}),"videoDetails"');
        final match = regExp.firstMatch(script.text);
        if (match != null) {
          // Extract JSON that contains the captions info
          final captionsJson = jsonDecode(match.group(1)!);

          // Navigate through the JSON to find subtitle URL
          final captionTracks = captionsJson['playerCaptionsTracklistRenderer']
              ['captionTracks'];
          if (captionTracks != null && captionTracks.isNotEmpty) {
            captionUrl = captionTracks[0]['baseUrl'];
            break;
          }
        }
      }
    }

    if (captionUrl != null) {
      // Fetch and print subtitles from the URL
      print("Subtitle URL found: $captionUrl");
      await _printSubtitles(captionUrl);
    } else {
      print("No subtitles available for this video.");
    }
  }

  Future<void> _printSubtitles(String subtitleUrl) async {
    final response = await http.get(Uri.parse(subtitleUrl));
    if (response.statusCode == 200) {
      final subtitleContent = utf8.decode(response.bodyBytes);
      print("Subtitles:\n$subtitleContent");
    } else {
      print("Failed to fetch subtitles.");
    }
  }
}
