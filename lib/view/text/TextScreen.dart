
import 'package:da_kanji_mobile/view/text/TextWidget.dart';
import 'package:flutter/material.dart';

import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import 'package:da_kanji_mobile/model/Screens.dart';
import 'package:da_kanji_mobile/model/DrawScreen/DrawingInterpreter.dart';
import 'package:da_kanji_mobile/model/DrawScreen/DrawScreenState.dart';
import 'package:da_kanji_mobile/view/drawer/Drawer.dart';



/// The "draw"-screen.
/// 
/// Lets the user draw a kanji and than shows the most likely predictions.
/// Those can than be copied / opened in dictionaries by buttons.
class TextScreen extends StatefulWidget {

  /// was this page opened by clicking on the tab in the drawer
  final bool openedByDrawer;
  /// should the hero widgets for animating to the webview be included
  final bool includeHeroes;
  /// should the focus nodes for the tutorial be included
  final bool includeTutorial;

  TextScreen(this.openedByDrawer, this.includeHeroes, this.includeTutorial);

  @override
  _TextScreenState createState() => _TextScreenState();
}

class _TextScreenState extends State<TextScreen> with TickerProviderStateMixin {


  @override
  void initState() {
    super.initState();

    // initialize the drawing interpreter if it has not been already
    if(!GetIt.I<DrawingInterpreter>().wasInitialized){
      GetIt.I<DrawingInterpreter>().init();
    }

    /*WidgetsBinding.instance.addPostFrameCallback((Duration timeStamp) {
      final OnboardingState? onboarding = Onboarding.of(context);
      if (onboarding != null && 
        GetIt.I<UserData>().showShowcaseDrawing && widget.includeTutorial) {

        onboarding.showWithSteps(
          GetIt.I<Tutorials>().drawScreenTutorial.drawScreenTutorialIndexes[0],
          GetIt.I<Tutorials>().drawScreenTutorial.drawScreenTutorialIndexes
        );
      }
    });*/
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return DaKanjiDrawer(
      currentScreen: Screens.drawing,
      animationAtStart: !widget.openedByDrawer,
      child: ChangeNotifierProvider.value(
        value: GetIt.I<DrawScreenState>().strokes,
        child: LayoutBuilder(
          builder: (context, constraints){
              
            return TextWidget();
              
          }
        ),
      ),
    );
  }
}