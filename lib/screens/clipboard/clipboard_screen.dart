import 'dart:async';
import 'dart:io';

import 'package:da_kanji_mobile/data/show_cases/tutorials.dart';
import 'package:da_kanji_mobile/domain/user_data/user_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:clipboard_watcher/clipboard_watcher.dart';

import 'package:da_kanji_mobile/data/screens.dart';
import 'package:da_kanji_mobile/widgets/drawer/drawer.dart';
import 'package:da_kanji_mobile/widgets/text_analysis/text_analysis_popup.dart';
import 'package:get_it/get_it.dart';
import 'package:onboarding_overlay/onboarding_overlay.dart';



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
  ClipboardData currentClipboard = ClipboardData(text: "");
  /// Timer that refreshes the UI every 1s (android only)
  late Timer refreshClipboardAndroid;


  /// when app comes back to foregorund update dict
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    setState(() {});
  }

  @override
  void initState() {

    // android does not allow for continous clipboard reading -> periodically
    // read clipboard till there is new value
    if(Platform.isAndroid){
      refreshClipboardAndroid = Timer.periodic(Duration(seconds: 1), (timer) async { 

        String data = (await Clipboard.getData('text/plain'))?.text ?? "";

        if(data != "" && data != currentClipboard)
          setState(() {
            currentClipboard = ClipboardData(text: data);
          }
      ); });
    }
    // on other platforms always listen to clipboard
    else{
      clipboardWatcher.addListener(this);
      // start watch
      clipboardWatcher.start();
    }

    // after first frame
    WidgetsBinding.instance.addPostFrameCallback((Duration timeStamp) {
      final OnboardingState? onboarding = Onboarding.of(context);
      // init tutorial
      if (onboarding != null && widget.includeTutorial && 
        GetIt.I<UserData>().showTutorialClipboard) {
        onboarding.showWithSteps(
          GetIt.I<Tutorials>().clipboardScreenTutorial.indexes![0],
          GetIt.I<Tutorials>().clipboardScreenTutorial.indexes!
        );
      }
    });
    
    super.initState();

  }

  @override
  void dispose() {
    if(Platform.isAndroid){
      refreshClipboardAndroid.cancel();
    }
    else{
      clipboardWatcher.removeListener(this);
      // stop watch
      clipboardWatcher.stop();
    }
    super.dispose();
  }

  @override
  void onClipboardChanged() async {
    currentClipboard = await Clipboard.getData(Clipboard.kTextPlain) ?? ClipboardData(text: "");
    setState(() { });
  }

  void onClipboardChangedString(String clipboard){
    print(clipboard);
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DaKanjiDrawer(
        currentScreen: Screens.clipboard,
        animationAtStart: !widget.openedByDrawer,
        child: TextAnalysisPopup(
          text: currentClipboard.text!,
        )
      ),
    );
  }

}