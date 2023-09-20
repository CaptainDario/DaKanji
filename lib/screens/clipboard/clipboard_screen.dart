import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:onboarding_overlay/onboarding_overlay.dart';
import 'package:window_manager/window_manager.dart';
import 'package:clipboard_watcher/clipboard_watcher.dart';

import 'package:da_kanji_mobile/widgets/helper/conditional_parent_widget.dart';
import 'package:da_kanji_mobile/globals.dart';
import 'package:da_kanji_mobile/data/show_cases/tutorials.dart';
import 'package:da_kanji_mobile/domain/settings/settings.dart';
import 'package:da_kanji_mobile/domain/user_data/user_data.dart';
import 'package:da_kanji_mobile/data/screens.dart';
import 'package:da_kanji_mobile/widgets/drawer/drawer.dart';
import 'package:da_kanji_mobile/widgets/text_analysis/text_analysis_popup.dart';



/// Screen that listens to clipboard changes and displays them in a
/// [TextAnalysisPopup]
class ClipboardScreen extends StatefulWidget {

  /// was this page opened by clicking on the tab in the drawer
  final bool openedByDrawer;
  /// should the focus nodes for the tutorial be included
  final bool includeTutorial;

  const ClipboardScreen(
    this.openedByDrawer,
    this.includeTutorial,
    {
      super.key
    }
  );

  @override
  State<ClipboardScreen> createState() => _ClipboardScreenState();
}

class _ClipboardScreenState extends State<ClipboardScreen> with ClipboardListener, WidgetsBindingObserver {

  /// Current state of the OS clipboard
  ClipboardData currentClipboard = const ClipboardData(text: "");
  /// Timer that refreshes the UI every 1s (android only)
  Timer? refreshClipboardTimer;
  /// Is the app currently set to be always on top
  bool isAlwaysOnTop = false;
  /// has the screen been initialized
  bool initialized = false;
  /// Should the tutorial be shown
  bool showTutorial = false;
  /// Keeps track if the window has been minimized at least once
  bool hasBeenMinimized = false;


  /// when app comes back to foregorund update dict
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    setState(() {});
  }

  @override
  void initState() {

    // android / iOS do not allow for continous clipboard reading
    //   -> periodically read clipboard till there is new value
    if(Platform.isAndroid || Platform.isIOS){
      refreshClipboardTimer = Timer.periodic(const 
        Duration(milliseconds: 500), (timer) async { 

          String data = (await Clipboard.getData('text/plain'))?.text ?? "";

          if(data != "" && data != currentClipboard.text){
            setState(() {
              currentClipboard = ClipboardData(text: data);
            });
          }
        }
      );
    }
    // on other platforms always listen to clipboard
    else{
      clipboardWatcher.addListener(this);
      // start watch
      clipboardWatcher.start();
    }

    // after first frame
    WidgetsBinding.instance.addPostFrameCallback((Duration timeStamp) async {

      // init tutorial
      final OnboardingState? onboarding = Onboarding.of(context);
      if (onboarding != null && widget.includeTutorial && 
        GetIt.I<UserData>().showTutorialClipboard) {
        showTutorial = true;
        onboarding.showWithSteps(
          GetIt.I<Tutorials>().clipboardScreenTutorial.indexes![0],
          GetIt.I<Tutorials>().clipboardScreenTutorial.indexes!
        );
      }

      // get current always on top state
      if(g_desktopPlatform)
        isAlwaysOnTop = await WindowManager.instance.isAlwaysOnTop();

    });
    
    super.initState();

  }

  @override
  void dispose() {
    if(refreshClipboardTimer != null){
      refreshClipboardTimer!.cancel();
    }
    else{
      clipboardWatcher.removeListener(this);
      // stop watch
      clipboardWatcher.stop();
    }

    // reset the state of the always on top option
    if(g_desktopPlatform)
      WindowManager.instance.setAlwaysOnTop(GetIt.I<Settings>().misc.alwaysOnTop);

    super.dispose();
  }

  @override
  void onClipboardChanged() async {
    currentClipboard = await Clipboard.getData(Clipboard.kTextPlain) ?? ClipboardData(text: "");
    setState(() { });
  }
  

  @override
  Widget build(BuildContext context) {

    return ConditionalParentWidget(
      condition: !isAlwaysOnTop,
      conditionalBuilder: (child) {
        return Scaffold(
          body: DaKanjiDrawer(
            currentScreen: Screens.clipboard,
            drawerClosed: !(!widget.openedByDrawer || !hasBeenMinimized),
            child: child
          ),
        );
      },
      child: Stack(
        children: [
          TextAnalysisPopup(
            text: currentClipboard.text!,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Focus(
                focusNode: widget.includeTutorial
                  ? GetIt.I<Tutorials>().clipboardScreenTutorial.focusNodes![3]
                  : null,
                child: IconButton(
                  icon: Icon(isAlwaysOnTop ? Icons.push_pin : Icons.push_pin_outlined),
                  onPressed: pinButtonPressed
                ),
              ),
            ],
          )
        ],
      )
    );
  }

  /// Callback that is executed when the pin-button is pressed
  Future<void> pinButtonPressed() async {
    isAlwaysOnTop = !isAlwaysOnTop;
    hasBeenMinimized = true;

    if(Platform.isMacOS || Platform.isLinux || Platform.isWindows) {
        await windowManager.setAlwaysOnTop(isAlwaysOnTop);

      if(isAlwaysOnTop){
        await windowManager.setSize(Size(300, 300));
        await windowManager.setMinimumSize(Size(300, 300));
        await windowManager.setAsFrameless();
      }
      else {
        await windowManager.setSize(Size(
          GetIt.I<Settings>().misc.windowWidth.toDouble(),
          GetIt.I<Settings>().misc.windowHeight.toDouble()
        ));
        await windowManager.setMinimumSize(g_minDesktopWindowSize);

        await windowManager.setTitleBarStyle(TitleBarStyle.normal, windowButtonVisibility: true);
        await windowManager.setTitle(g_AppTitle);
      }
    }
    setState(() {});
  }

}