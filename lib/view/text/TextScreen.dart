
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

  /// the output of the analyzer
  Tuple2<List<String>, List<List<String>>> analyzed = Tuple2([], []);

  /// the padding used between all widges
  final double padding = 8.0;

  /// if the option to make the analyzed text fullscreen
  bool fullScreen = false;  
  /// if the option for showing furigana above words is enabled
  bool showFurigana = false;
  /// if the option for showing spaces between words is enabled
  bool showSpaces = false;

  /// should this screen be shown in portrait or not
  bool runningInPortrait = false;

  /// the animation controller for animating maximizing the processed text widget
  late final AnimationController _controller;
  /// the animation for animating maximizing the processed text widget
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

            // set if the app should be layed out in portrait or landscape
            runningInPortrait = constraints.maxHeight > constraints.maxWidth;
              
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
                          width: runningInPortrait ?  
                            constraints.maxWidth - 2*padding: 
                            constraints.maxWidth / 2 - padding,
                          height: runningInPortrait ? 
                            constraints.maxHeight / 2 - 2*padding :
                            constraints.maxHeight - 2*padding,
                          child: Card(
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(
                                2*padding, padding, 2*padding, padding
                              ),
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
                            ),
                          ),
                        ),
                        // processed text
                        Positioned(
                          bottom: 0,
                          right: runningInPortrait ? null : 0,
                          child: Container(
                            width: runningInPortrait ?
                              constraints.maxWidth - 2*padding: 
                              (constraints.maxWidth/2-2*padding) 
                              * (_animation.value+1.0),
                            height: runningInPortrait ?
                              (constraints.maxHeight/2-padding) 
                              * (_animation.value+1.0) :
                              constraints.maxHeight - 2*padding,
                            child: Card(
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(
                                  2*padding, 2*padding, 2*padding, padding/2
                                ),
                                child: Column(
                                  children: [
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
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Material(
                                          color: Theme.of(context).cardColor,
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
                                          color: Theme.of(context).cardColor,
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
                                          color: Theme.of(context).cardColor,
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