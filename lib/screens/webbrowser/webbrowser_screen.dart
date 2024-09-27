// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_browser/browser.dart';
import 'package:flutter_browser/main.dart';
import 'package:flutter_browser/models/browser_model.dart';
import 'package:flutter_browser/models/webview_model.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';


class WebBrowserScreen extends StatefulWidget {

  /// was this page opened by clicking on the tab in the drawer
  final bool openedByDrawer;
  /// should the focus nodes for the tutorial be included
  final bool includeTutorial;

  const WebBrowserScreen(
    this.openedByDrawer,
    this.includeTutorial,
    {
      super.key
    }
  );

  @override
  State<WebBrowserScreen> createState() => _WebBrowserScreenState();
}

class _WebBrowserScreenState extends State<WebBrowserScreen> {

  bool initialized = false;

  @override
  void initState() {

    initAsync();

    super.initState();

  }

  Future<bool> initAsync() async {
   
    if(initialized) return true;

    WEB_ARCHIVE_DIR = (await getApplicationSupportDirectory()).path;

    TAB_VIEWER_BOTTOM_OFFSET_1 = 130.0;
    TAB_VIEWER_BOTTOM_OFFSET_2 = 140.0;
    TAB_VIEWER_BOTTOM_OFFSET_3 = 150.0;

    if (!kIsWeb && defaultTargetPlatform == TargetPlatform.windows) {
      final availableVersion = await WebViewEnvironment.getAvailableVersion();
      assert(availableVersion != null,
      'Failed to find an installed WebView2 Runtime or non-stable Microsoft Edge installation.');

      webViewEnvironment = await WebViewEnvironment.create(
          settings: WebViewEnvironmentSettings(userDataFolder: 'flutter_browser_app'));
    }

    initialized = true;
    return true;

  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: initAsync(),
      builder: (context, snapshot) {

        if(!initialized) return const SizedBox();

        return MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (context) => WebViewModel(),
            ),
            ChangeNotifierProxyProvider<WebViewModel, BrowserModel>(
              update: (context, webViewModel, browserModel) {
                browserModel!.setCurrentWebViewModel(webViewModel);
                return browserModel;
              },
              create: (BuildContext context) => BrowserModel(),
            ),
          ],
          child: const Browser(),
        );
      }
    );
  }

}
