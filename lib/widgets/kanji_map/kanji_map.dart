// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get_it/get_it.dart';
import 'package:onboarding_overlay/onboarding_overlay.dart';

// Project imports:
import 'package:da_kanji_mobile/entities/show_cases/tutorials.dart';
import 'package:da_kanji_mobile/entities/user_data/user_data.dart';

class KanjiMap extends StatefulWidget {

  /// was this page opened by clicking on the tab in the drawer
  final bool openedByDrawer;
  /// should the focus nodes for the tutorial be included
  final bool includeTutorial;
  /// A search term that should be the initial search
  final String? initialSearch;
  /// Should the first result of the initial search be openend (if one exists)
  final bool openFirstResult;


  const KanjiMap(
    this.openedByDrawer,
    this.includeTutorial,
    {
      this.initialSearch,
      this.openFirstResult = false,
      super.key
    }
  );

  @override
  State<KanjiMap> createState() => _KanjiMapState();
}

class _KanjiMapState extends State<KanjiMap> {


  @override
  void initState() {
     
    super.initState();

    showTutorialCallback();
  }

  @override
  void didUpdateWidget(covariant KanjiMap oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  void showTutorialCallback() {
    // after first frame
    WidgetsBinding.instance.addPostFrameCallback((Duration timeStamp) {

      if(widget.includeTutorial){
        // init tutorial
        final OnboardingState? onboarding = Onboarding.of(context);
        if(onboarding != null && GetIt.I<UserData>().showTutorialKanjiMap) {
          onboarding.showWithSteps(
            GetIt.I<Tutorials>().kanjiMapScreenTutorial.indexes![0],
            GetIt.I<Tutorials>().kanjiMapScreenTutorial.indexes!
          );
        }
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("KanjiMap"),
    );
  }



}
