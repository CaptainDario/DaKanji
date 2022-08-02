import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:kagome_dart/kagome_dart.dart';
import 'package:tuple/tuple.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:da_kanji_mobile/model/Screens.dart';
import 'package:da_kanji_mobile/model/DrawScreen/DrawScreenState.dart';
import 'package:da_kanji_mobile/view/text/CustomSelectableText.dart';
import 'package:da_kanji_mobile/view/drawer/Drawer.dart';
import 'package:da_kanji_mobile/view/text/CustomTextPopup.dart';



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
  Tuple2<List<String>, List<List<String>>> analyzedWords = Tuple2([], []);


  /// the padding used between all widges
  final double padding = 8.0;

  /// if the option to make the analyzed text fullscreen
  bool fullScreen = false;  
  /// if the option for showing furigana above words is enabled
  bool showRubys = false;
  /// if the option for showing spaces between words is enabled
  bool addSpaces = false;

  /// should this screen be shown in portrait or not
  bool runningInPortrait = false;

  /// the animation controller for animating maximizing the processed text widget
  late final AnimationController _controller;
  /// the animation for animating maximizing the processed text widget
  late Animation _animation;

  /// the distance to the left window border of the popup
  double popupPositionLeft = 0.0;
  /// the distance to the top window border of the popup
  double popupPositionTop = 0.0;
  /// the width of the popup
  double popupSizeWidth = 300;
  /// the height of the popup
  double popupSizeHeight = 200;
  /// the minimal width the popup can be
  double popupSizeWidthMin = 300;
  /// the minimal height the popup can be
  double popupSizeHeightMin = 200;
  /// the animation controller for scaling in the popup window
  late AnimationController popupAnimationController;
  /// the animation for scaling in the popup window
  late final Animation<double> popupAnimation;
  /// the currently selected text
  String selectedText = "";


  //var sharedText = "";
  void _onSelectionChange(String textSelection) {
    setState(() {
      selectedText = textSelection;
    });
  }

  /// the text style used for styling the 
  TextStyle sharedTextStyle = const TextStyle(
    fontSize: 20,
    height: 2.0,
  );

  


  @override
  void initState() {

    super.initState();

    initTokenizer();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      value: 0.0,
      vsync: this,
    );
    _animation = _controller.drive(
      CurveTween(curve: Curves.easeInOut)
    );

    popupAnimationController = AnimationController(
      duration: const Duration(milliseconds: 250),
      value: 0.0,
      vsync: this,
    );
    popupAnimation = popupAnimationController.drive(
      CurveTween(curve: Curves.easeInOut)
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
                        Focus(
                          onFocusChange: (value) {
                            if(value && popupAnimationController.isCompleted){
                              popupAnimationController.reverse();
                            }
                          },
                          child: Container(
                            width: runningInPortrait ?
                              constraints.maxWidth - padding: 
                                (constraints.maxWidth/2-padding) 
                                * (1-_animation.value),
                              height: runningInPortrait ?
                                (constraints.maxHeight/2-padding) 
                                * (1-_animation.value) :
                                constraints.maxHeight - padding,
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
                                    hintText: "Input text here...",
                                  ),
                                  inputFormatters: [
                                    FilteringTextInputFormatter.deny(
                                      RegExp(r"\u000d"),
                                      //replacementString: "\r"
                                    ),
                                    FilteringTextInputFormatter.deny(
                                      RegExp(r"\u000a"),
                                      replacementString: "\n"
                                    )
                                  ],
                                  controller: widget.inputController,
                                  maxLines: null,
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                  onChanged: ((value) {
                                    setState(() {
                                      analyzedWords = runAnalyzer(value, AnalyzeModes.normal);
                                    });
                                  }),
                                ),
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
                              (constraints.maxWidth/2-padding) 
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
                                      child: Center(
                                        child: CustomSelectableText(
                                          words: analyzedWords.item1,
                                          rubys: analyzedWords.item2.map(
                                            (e) => (e.length == 9 ? e[7] : "")
                                          ).toList(),
                                          width: runningInPortrait ?
                                            constraints.maxWidth - padding: 
                                            (constraints.maxWidth/2-padding) 
                                            * (_animation.value+1.0),
                                          height: runningInPortrait ?
                                            (constraints.maxHeight/2-padding) 
                                            * (_animation.value+1.0) :
                                            constraints.maxHeight - 2*padding,
                                          style: sharedTextStyle,
                                          showRubys: showRubys,
                                          addSpaces: addSpaces,
                                          selectionColor: Theme.of(context).colorScheme.primary.withOpacity(0.40),
                                          onSelectionChange: (selection) {
                                            if(selection != TextSelection.collapsed(offset: 0))
                                              popupAnimationController.forward();
                                            _onSelectionChange(selection);
                                          },
                                        ),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Material(
                                          color: Theme.of(context).cardColor,
                                          child: IconButton(
                                            icon: SvgPicture.asset(
                                              !addSpaces ?
                                              "assets/fonts/icons/space_bar_off.svg" :
                                              "assets/fonts/icons/space_bar_on.svg",
                                              color: Colors.white,
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                addSpaces = !addSpaces;
                                              });
                                            },
                                          ),
                                        ),
                                        Material(
                                          color: Theme.of(context).cardColor,
                                          child: IconButton(
                                            key: GlobalKey(),
                                            icon: SvgPicture.asset(
                                              showRubys ?
                                              "assets/fonts/icons/furigana_off.svg" :
                                              "assets/fonts/icons/furigana_on.svg",
                                              color: Colors.white,
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                showRubys = !showRubys;
                                              });
                                            },
                                          ),
                                        ),
                                        Material(
                                          color: Theme.of(context).cardColor,
                                          child: IconButton(
                                            icon: Icon(!fullScreen ? 
                                              Icons.open_in_full : 
                                              Icons.close_fullscreen
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
                        ),
                        /// Popup window to show text selection in dict / DeepL
                        Positioned(
                          width: popupSizeWidth,
                          height: popupSizeHeight,
                          left: popupPositionLeft,
                          top: popupPositionTop,
                          child: Listener(
                            child: ScaleTransition(
                              scale: popupAnimation,
                              child: CustomTextPopup(
                                selectedText: selectedText,
                                onMovedViaHeader: (event) {
                                  setState(() {
                                    // assure that the popup is not moved out of view
                                    if(popupPositionLeft + event.delta.dx > 0 &&
                                      popupPositionLeft + popupSizeWidth + 
                                      2*padding + event.delta.dx < constraints.maxWidth)
                                      popupPositionLeft += event.delta.dx;
                                                    
                                    // assure that the popup is not moved out of view
                                    if(popupPositionTop + event.delta.dy > 0 &&
                                      popupPositionTop + popupSizeHeight + 
                                      2*padding + event.delta.dy < constraints.maxHeight)
                                                    
                                      popupPositionTop  += event.delta.dy;
                                  });
                                },
                                onResizedViaCorner: (event) {
                                  setState(() {
                                    // don't allow resizing the popup over the 
                                    // window or smaller than the threshold 
                                    if(popupSizeWidth + event.delta.dx > popupSizeWidthMin &&
                                      popupSizeWidth + event.delta.dx + 2*padding < constraints.maxWidth)
                                      popupSizeWidth += event.delta.dx;
                                                    
                                    // don't allow resizing the popup over the 
                                    // window or smaller than the threshold 
                                    if(popupSizeHeight + event.delta.dy > popupSizeHeightMin &&
                                      popupSizeHeight + event.delta.dy + 2*padding < constraints.maxHeight)
                                      popupSizeHeight += event.delta.dy;
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                        
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