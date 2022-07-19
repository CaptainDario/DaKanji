
import 'package:da_kanji_mobile/view/text/TextWidget.dart';
import 'package:flutter/material.dart';

import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:kagome_dart/kagome_dart.dart';
import 'package:tuple/tuple.dart';

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
  
  final TextEditingController inputController = TextEditingController();

  TextScreen(this.openedByDrawer, this.includeHeroes, this.includeTutorial);

  @override
  _TextScreenState createState() => _TextScreenState();
}

class _TextScreenState extends State<TextScreen> with TickerProviderStateMixin {


  Tuple2<List<String>, List<List<String>>> analyzed = Tuple2([], []);

  final double padding = 8.0;


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
              
            return Padding(
              padding: EdgeInsets.all(padding),
              child: Column(
                children: [
                  Card(
                    child: Container(
                      width: constraints.maxWidth,
                      height: constraints.maxHeight/2-2*padding,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: widget.inputController,
                          maxLines: null,
                          style: TextStyle(
                            fontSize: 20,
                          ),
                          onChanged: ((value) {
                            analyzed = runAnalyzer(value, AnalyzeModes.search);
                            print(analyzed);
                            setState(() {
                              
                            });
                          }),
                        ),
                      )
                    ),
                  ),
                  TextWidget(
                    texts: analyzed.item1,
                    rubys: analyzed.item2.map(
                      (e) => (e.length == 9 ? e[7] : "")
                    ).toList(),
                    width: constraints.maxWidth,
                    height: constraints.maxHeight/2-2*padding,
                  )
                ]
              ),
            );
          }
        ),
      ),
    );
  }
}