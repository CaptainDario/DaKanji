// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get_it/get_it.dart';
import 'package:onboarding_overlay/onboarding_overlay.dart';

// Project imports:
import 'package:da_kanji_mobile/data/show_cases/tutorials.dart';
import 'package:da_kanji_mobile/domain/dojg/dojg_entry.dart';
import 'package:da_kanji_mobile/domain/user_data/user_data.dart';
import 'package:da_kanji_mobile/widgets/dojg/dojg_entry_list.dart';
import 'package:da_kanji_mobile/widgets/dojg/dojg_entry_page.dart';

class DoJG extends StatefulWidget {

  /// was this page opened by clicking on the tab in the drawer
  final bool openedByDrawer;
  /// should the focus nodes for the tutorial be included
  final bool includeTutorial;
  /// A search term that should be the initial search
  final String? initialSearch;
  /// Should the first result of the initial search be openend (if one exists)
  final bool openFirstResult;
  /// should the filters for the volumes be included
  final bool includeVolumeTags;


  const DoJG(
    this.openedByDrawer,
    this.includeTutorial,
    {
      this.initialSearch,
      this.openFirstResult = false,
      this.includeVolumeTags = true,
      super.key
    }
  );

  @override
  State<DoJG> createState() => _DoJGState();
}

class _DoJGState extends State<DoJG> {

  /// The currently selected DoJG entry
  DojgEntry? currentSelection;


  @override
  void initState() {
     
    super.initState();

    showTutorialCallback();
  }

  @override
  void didUpdateWidget(covariant DoJG oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  void showTutorialCallback() {
    // after first frame
    WidgetsBinding.instance.addPostFrameCallback((Duration timeStamp) {

      if(widget.includeTutorial){
        // init tutorial
        final OnboardingState? onboarding = Onboarding.of(context);
        if(onboarding != null && 
          GetIt.I<UserData>().showTutorialDojg &&
          GetIt.I<UserData>().dojgImported) {
          onboarding.showWithSteps(
            GetIt.I<Tutorials>().dojgScreenTutorial.indexes![0],
            GetIt.I<Tutorials>().dojgScreenTutorial.indexes!
          );
        }
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: [
            DojgEntryList(
              initialSearch: widget.initialSearch,
              openFirstResult: widget.openFirstResult,
              includeTutorial: widget.includeTutorial,
              includeVolumeTags: widget.includeVolumeTags,
              onTap: (DojgEntry dojgEntry) {
                setState(() {
                  currentSelection = dojgEntry;  
                });
              },
            ),
            if(currentSelection != null)
              DojgEntryPage(currentSelection!, false)
          ],
        );
      },
    );
  }



}
