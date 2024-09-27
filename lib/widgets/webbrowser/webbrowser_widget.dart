import 'package:da_kanji_mobile/entities/show_cases/tutorials.dart';
import 'package:da_kanji_mobile/entities/user_data/user_data.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:onboarding_overlay/onboarding_overlay.dart';



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
    return Text("Webbrowser");
  }
}