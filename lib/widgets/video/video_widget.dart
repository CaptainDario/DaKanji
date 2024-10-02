// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get_it/get_it.dart';
import 'package:onboarding_overlay/onboarding_overlay.dart';

// Project imports:
import 'package:da_kanji_mobile/entities/show_cases/tutorials.dart';
import 'package:da_kanji_mobile/entities/user_data/user_data.dart';
import 'package:da_kanji_mobile/widgets/video/video_library.dart';

class VideoWidget extends StatefulWidget {

  /// was this page opened by clicking on the tab in the drawer
  final bool openedByDrawer;
  /// should the focus nodes for the tutorial be included
  final bool includeTutorial;


  const VideoWidget(
    this.openedByDrawer,
    this.includeTutorial,
    {
      super.key
    }
  );

  @override
  State<VideoWidget> createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {


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
          GetIt.I<UserData>().showTutorialVideo) {
          onboarding.showWithSteps(
            GetIt.I<Tutorials>().videoScreenTutorial.indexes![0],
            GetIt.I<Tutorials>().videoScreenTutorial.indexes!
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const VideoLibrary();
  }
}
