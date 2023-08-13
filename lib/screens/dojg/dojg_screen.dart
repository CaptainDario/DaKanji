import 'package:get_it/get_it.dart';
import 'package:onboarding_overlay/onboarding_overlay.dart';
import 'package:flutter/material.dart';

import 'package:da_kanji_mobile/data/screens.dart';
import 'package:da_kanji_mobile/widgets/drawer/drawer.dart';
import 'package:da_kanji_mobile/widgets/dojg/dojg_widget.dart';
import 'package:da_kanji_mobile/application/dojg/dojg.dart';
import 'package:da_kanji_mobile/data/show_cases/tutorials.dart';
import 'package:da_kanji_mobile/domain/user_data/user_data.dart';



class DoJGScreen extends StatefulWidget {
  /// should the tutorial for this scren be included
  final bool includeTutorial;


  const DoJGScreen(
    {
      required this.includeTutorial,
      super.key
    }
  );

  @override
  State<DoJGScreen> createState() => _DoJGScreenState();
}

class _DoJGScreenState extends State<DoJGScreen> {


  @override
  void initState() {
     
    super.initState();

    // after first frame
    WidgetsBinding.instance.addPostFrameCallback((Duration timeStamp) {

      // init tutorial
      final OnboardingState? onboarding = Onboarding.of(context);
      if(widget.includeTutorial && onboarding != null && 
        GetIt.I<UserData>().showTutorialDojg) {
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
      currentScreen: Screens.dojg,
      child: dojgImported
        ? DoJGWidget()
        : GestureDetector(
          onTap: () {
            setState(() {
              dojgImported = true;
            });
          },
          child: Container(
            constraints: BoxConstraints.expand(),
            //color: Colors.amber,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.add_circle_outline),
                SizedBox(width: 10.0),
                Text("Tap to import DoJG Deck")
              ],
            ),
          ),
        ),
    );
  }
}