import 'package:flutter/material.dart';

import 'package:get_it/get_it.dart';
import 'package:onboarding_overlay/onboarding_overlay.dart';

import 'package:da_kanji_mobile/domain/dojg/dojg_entry.dart';
import 'package:da_kanji_mobile/widgets/dojg/dojg_entry_page.dart';
import 'package:da_kanji_mobile/widgets/dojg/dojg_import.dart';
import 'package:da_kanji_mobile/data/screens.dart';
import 'package:da_kanji_mobile/widgets/drawer/drawer.dart';
import 'package:da_kanji_mobile/widgets/dojg/dojg_entry_list.dart';
import 'package:da_kanji_mobile/data/show_cases/tutorials.dart';
import 'package:da_kanji_mobile/domain/user_data/user_data.dart';



class DoJGScreen extends StatefulWidget {

  /// was this page opened by clicking on the tab in the drawer
  final bool openedByDrawer;
  /// should the focus nodes for the tutorial be included
  final bool includeTutorial;


  const DoJGScreen(
    this.openedByDrawer,
    this.includeTutorial,
    {
      super.key
    }
  );

  @override
  State<DoJGScreen> createState() => _DoJGScreenState();
}

class _DoJGScreenState extends State<DoJGScreen> {

  DojgEntry? currentSelection;


  @override
  void initState() {
     
    super.initState();

    showTutorialCallback();
  }

  @override
  void didUpdateWidget(covariant DoJGScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  void showTutorialCallback() {
    // after first frame
    WidgetsBinding.instance.addPostFrameCallback((Duration timeStamp) {

      // init tutorial
      final OnboardingState? onboarding = Onboarding.of(context);
      if(widget.includeTutorial && onboarding != null && 
        GetIt.I<UserData>().showTutorialDojg &&
        GetIt.I<UserData>().dojgImported) {
        onboarding.showWithSteps(
          GetIt.I<Tutorials>().dojgScreenTutorial.indexes![0],
          GetIt.I<Tutorials>().dojgScreenTutorial.indexes!
        );
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return DaKanjiDrawer(
      animationAtStart: !widget.openedByDrawer,
      currentScreen: Screens.dojg,
      child: !GetIt.I<UserData>().dojgImported
        // show the import widget if the deck has not been imported
        ? const DojgImport()
        // if it has been imported show the actual dojg data
        : LayoutBuilder(
          builder: (context, constraints) {
            return Row(
              children: [
                Expanded(
                  child: DojgEntryList(
                    onTap: (DojgEntry dojgEntry) {
                      // add new route if screen is small
                      if(constraints.maxWidth < 800){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => DojgEntryPage(dojgEntry),)
                        );
                      }
                      setState(() {
                        currentSelection = dojgEntry;  
                      });
                    },
                  )
                ),
                if(constraints.maxWidth > 800)
                  Expanded(
                    child: currentSelection == null
                      ? const SizedBox()
                      : DojgEntryPage(currentSelection!)
                  ),
              ],
            );
          },
        )
    );
  }



}