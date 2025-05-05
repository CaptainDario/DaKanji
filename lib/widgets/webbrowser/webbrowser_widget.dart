// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get_it/get_it.dart';
import 'package:onboarding_overlay/onboarding_overlay.dart';

// Project imports:
import 'package:da_kanji_mobile/entities/show_cases/tutorials.dart';
import 'package:da_kanji_mobile/entities/user_data/user_data.dart';

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

        return const SizedBox();
      }
    );
  }
}
