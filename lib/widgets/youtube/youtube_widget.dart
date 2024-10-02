// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get_it/get_it.dart';
import 'package:onboarding_overlay/onboarding_overlay.dart';

// Project imports:
import 'package:da_kanji_mobile/entities/show_cases/tutorials.dart';
import 'package:da_kanji_mobile/entities/user_data/user_data.dart';

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
    return Text("Youtube");
  }
}
