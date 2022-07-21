
import 'package:da_kanji_mobile/view/text/TextWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:kagome_dart/kagome_dart.dart';
import 'package:tuple/tuple.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:da_kanji_mobile/model/Screens.dart';
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

  bool fullScreen = false;

  bool showFurigana = false;

  bool showSpaces = false;


  late final AnimationController _controller;
  late Animation _animation;


  @override
  void initState() {

    super.initState();

    initTokenizer();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      value: 0.0,
      vsync: this,
    );


    // initialize the drawing interpreter if it has not been already
    //if(!GetIt.I<DrawingInterpreter>().wasInitialized){
    //  GetIt.I<DrawingInterpreter>().init();
    //}

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
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    _animation = new Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(new CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut
    ));
    

    return DaKanjiDrawer(
      currentScreen: Screens.drawing,
      animationAtStart: !widget.openedByDrawer,
      child: ChangeNotifierProvider.value(
        value: GetIt.I<DrawScreenState>().strokes,
        child: LayoutBuilder(
          builder: (context, constraints){
              
            return AnimatedBuilder(
              animation: _controller,
              builder: (context, builder) {
                return Container(
                  height: constraints.maxHeight,
                  width: constraints.maxWidth,
                  child: Padding(
                    padding: EdgeInsets.all(padding),
                    child: Stack(
                      children: [
                        // Text input
                        Container(
                          width: constraints.maxWidth,
                          height: constraints.maxHeight/2-2*padding,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              decoration: new InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                                hintText: "Input text here..."
                              ),
                              controller: widget.inputController,
                              maxLines: null,
                              style: TextStyle(
                                fontSize: 20,
                              ),
                              onChanged: ((value) {
                                setState(() {
                                  analyzed = runAnalyzer(value, AnalyzeModes.normal);
                                });
                              }),
                            ),
                          )
                        ),
                        // processed
                        Positioned(
                          bottom: 0,
                          child: Container(
                            width: constraints.maxWidth-3*padding,
                            height: (constraints.maxHeight/2-(fullScreen ? 1.5 : 2)*padding) 
                                * (_animation.value+1.0),
                            decoration: BoxDecoration(
                              color: Theme.of(context).canvasColor,
                              borderRadius: BorderRadius.circular(5.0)
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(padding),
                              child: Column(
                                children: [
                                  SizedBox(
                                    child: Divider(
                                      color: Theme.of(context).hintColor,
                                    ),
                                    width: 50,
                                    height: 1,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Expanded(
                                    child: TextWidget(
                                      texts: analyzed.item1,
                                      rubys: analyzed.item2.map(
                                        (e) => (e.length == 9 ? e[7] : "")
                                      ).toList(),
                                      showFurigana: showFurigana,
                                      addSpaces: showSpaces,
                                    ),
                                  ),
                                  Divider(),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Material(
                                        child: IconButton(
                                          icon: SvgPicture.asset(
                                            !showSpaces ?
                                            "assets/fonts/icons/space_bar_off.svg" :
                                            "assets/fonts/icons/space_bar_on.svg",
                                            color: Colors.white,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              showSpaces = !showSpaces;
                                            });
                                          },
                                        ),
                                      ),
                                      Material(
                                        child: IconButton(
                                          key: GlobalKey(),
                                          icon: SvgPicture.asset(
                                            showFurigana ?
                                            "assets/fonts/icons/furigana_off.svg" :
                                            "assets/fonts/icons/furigana_on.svg",
                                            color: Colors.white,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              showFurigana = !showFurigana;
                                            });
                                          },
                                        ),
                                      ),
                                      Material(
                                        child: IconButton(
                                          icon: Icon(!fullScreen ? 
                                            Icons.fullscreen : 
                                            Icons.fullscreen_exit
                                          ),
                                          onPressed: () {
                                            // do not allow change while animation is running
                                            if (_controller.isAnimating)
                                              return;
                                      
                                            if(_controller.isCompleted)
                                              _controller.reverse();
                                            else if(_controller.isDismissed)
                                              _controller.forward();

                                            setState(() {
                                              fullScreen = !fullScreen;
                                            });
                                            
                                          },
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      ]
                    ),
                  ),
                );
              }
            );
          }
        ),
      ),
    );
  }
}