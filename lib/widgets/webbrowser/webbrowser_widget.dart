import 'package:da_kanji_mobile/entities/show_cases/tutorials.dart';
import 'package:da_kanji_mobile/entities/user_data/user_data.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:onboarding_overlay/onboarding_overlay.dart';
import 'package:flutter_browser/browser.dart';
import 'package:flutter_browser/main.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/foundation.dart';


/// Have the webview variables be initialized
bool g_WEBBROWSER_INITIALIZED = false;


class WebbrowserWidget extends StatefulWidget {

  /// was this page opened by clicking on the tab in the drawer
  final bool openedByDrawer;
  /// should the focus nodes for the tutorial be included
  final bool includeTutorial;


  const WebbrowserWidget(
    this.openedByDrawer,
    this.includeTutorial,
    {
      super.key
    }
  );

  @override
  State<WebbrowserWidget> createState() => _WebbrowserWidgetState();
}

class _WebbrowserWidgetState extends State<WebbrowserWidget> {

  @override
  void initState() {
    
    super.initState();

    showTutorialCallback();
    initAsync();

  }

  Future<bool> initAsync() async {
   
    if(g_WEBBROWSER_INITIALIZED) return true;

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

    g_WEBBROWSER_INITIALIZED = true;
    return true;

  }


  void showTutorialCallback() {
    // after first frame
    WidgetsBinding.instance.addPostFrameCallback((Duration timeStamp) {

      if(widget.includeTutorial){
        // init tutorial
        final OnboardingState? onboarding = Onboarding.of(context);
        if(onboarding != null && 
          GetIt.I<UserData>().showTutorialWebbrowser) {
          onboarding.showWithSteps(
            GetIt.I<Tutorials>().webbrowserScreenTutorial.indexes![0],
            GetIt.I<Tutorials>().webbrowserScreenTutorial.indexes!
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: initAsync(),
      builder: (context, snapshot) {

        if(!g_WEBBROWSER_INITIALIZED) return const SizedBox();

        return const Browser();
      }
    );
  }
}