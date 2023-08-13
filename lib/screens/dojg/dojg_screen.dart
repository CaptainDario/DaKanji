import 'package:flutter/material.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:get_it/get_it.dart';
import 'package:onboarding_overlay/onboarding_overlay.dart';

import 'package:da_kanji_mobile/locales_keys.dart';
import 'package:da_kanji_mobile/data/screens.dart';
import 'package:da_kanji_mobile/widgets/drawer/drawer.dart';
import 'package:da_kanji_mobile/widgets/dojg/dojg_widget.dart';
import 'package:da_kanji_mobile/application/dojg/dojg.dart';
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

  /// Is the dojg deck currently being imported
  bool importing = false;


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
      child: GetIt.I<UserData>().dojgImported
        ? DoJGWidget()
        : GestureDetector(
          onTap: () async {
            if (importing) return;

            importing = true;

            await importDoJGDeck();
            
            GetIt.I<UserData>().dojgImported = (await checkDojgImported());
            GetIt.I<UserData>().dojgWithMediaImported = (await checkDojgWithMediaImported());
            await GetIt.I<UserData>().save();
            
            if(GetIt.I<UserData>().showTutorialDojg)
              showTutorialCallback();
            
            setState(() {});

            importing = false;
          },
          child: Container(
            constraints: BoxConstraints.expand(),
            color: Colors.transparent,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.download),
                    SizedBox(width: 10.0),
                    Text(LocaleKeys.DojgScreen_import_dojg.tr()),
                  ],
                ),
                SizedBox(height: 4,),
                Text(
                  LocaleKeys.DojgScreen_refer_to_manual.tr(),
                  textScaleFactor: 0.9,
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                )
              ],
            ),
          ),
        )
    );
  }

}