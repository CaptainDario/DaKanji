import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get_it/get_it.dart';
import 'package:kagome_dart/kagome_dart.dart';
import 'package:kagome_dart/pos_unidic.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:onboarding_overlay/onboarding_overlay.dart';
import 'package:kana_kit/kana_kit.dart';

import 'package:da_kanji_mobile/model/screens.dart';
import 'package:da_kanji_mobile/view/text/custom_selectable_text.dart';
import 'package:da_kanji_mobile/model/TextScreen/pos_colors.dart';
import 'package:da_kanji_mobile/view/drawer/drawer.dart';
import 'package:da_kanji_mobile/view/text/custom_text_popup.dart';
import 'package:da_kanji_mobile/show_cases/tutorials.dart';
import 'package:da_kanji_mobile/model/user_data.dart';




/// The "draw"-screen.
/// 
/// Lets the user draw a kanji and than shows the most likely predictions.
/// Those can than be copied / opened in dictionaries by buttons.
class TextScreen extends StatefulWidget {

  TextScreen(
    this.openedByDrawer, 
    this.includeTutorial, 
    {
      Key? key
    }) : super(key: key);

  /// was this page opened by clicking on the tab in the drawer
  final bool openedByDrawer;
  /// should the focus nodes for the tutorial be included
  final bool includeTutorial;
  
  final TextEditingController inputController = TextEditingController();

  @override
  _TextScreenState createState() => _TextScreenState();
}

class _TextScreenState extends State<TextScreen> with TickerProviderStateMixin {

  /// the output of the analyzer
  List<String> kagomeWords = const [];
  List<List<String>> kagomePos = const[[]];

  /// the padding used between all widges
  final double padding = 8.0;

  /// if the option to make the analyzed text fullscreen
  bool fullScreen = false;  
  /// if the option for showing furigana above words is enabled
  bool showRubys = false;
  /// if the option for showing spaces between words is enabled
  bool addSpaces = false;

  bool colorizePos = false;

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
  /// the text that is currently in the input field
  String inputText = "";




  
  @override
  void initState() {

    super.initState();

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

    // init tutorial
    WidgetsBinding.instance.addPostFrameCallback((Duration timeStamp) {
      final OnboardingState? onboarding = Onboarding.of(context);
      if (onboarding != null && 
        GetIt.I<UserData>().showShowcaseText && widget.includeTutorial) {

        onboarding.showWithSteps(
          GetIt.I<Tutorials>().textScreenTutorial.indexes![0],
          GetIt.I<Tutorials>().textScreenTutorial.indexes!
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return DaKanjiDrawer(
      currentScreen: Screens.text,
      animationAtStart: !widget.openedByDrawer,
      child: LayoutBuilder(
        builder: (context, constraints){

          // shrink the popup when making the windower smaller than the popup in ...
          // ... Width
          if(constraints.maxWidth < popupPositionLeft + popupSizeWidth + 2*padding){
            if(popupPositionLeft > 0){
              popupPositionLeft = constraints.maxWidth - popupSizeWidth - 4*padding;
            }
            else{
              popupPositionLeft = 0;
              popupSizeWidth = constraints.maxWidth - 4*padding;
            }
          }
          // ... Height
          if(constraints.maxHeight < popupPositionTop + popupSizeHeight + 2*padding){
            if(popupPositionTop > 0){
              popupPositionTop = constraints.maxHeight - popupSizeHeight - 4*padding;
            }
            else{
              popupPositionTop = 0;
              popupSizeHeight = constraints.maxHeight - 4*padding;
            }
          }
            
      
          // set if the app should be layed out in portrait or landscape
          runningInPortrait = constraints.maxHeight > constraints.maxWidth;
            
          return AnimatedBuilder(
            animation: _controller,
            builder: (context, builder) {
              return SizedBox(
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
                        child: SizedBox(
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
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  hintText: "Add localization here",
                                ),
                                inputFormatters: [
                                  FilteringTextInputFormatter.deny(
                                    RegExp(r"\u000d"),
                                    //replacementString: "\r"
                                  ),
                                  FilteringTextInputFormatter.deny(
                                    RegExp(r"\u000a"),
                                    replacementString: "\n"
                                  ),
                                  FilteringTextInputFormatter.deny(
                                    RegExp(r"█"),
                                    replacementString: ""
                                  )
                                ],
                                controller: widget.inputController,
                                maxLines: null,
                                style: const TextStyle(
                                  fontSize: 20,
                                ),
                                onChanged: ((value) {
                                  setState(() {
                                    inputText = value;
                                    processText(value);
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
                        child: SizedBox(
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
                                        words: kagomeWords,
                                        rubys: kagomePos.map(
                                          (e) => e.length == 17 ? e[9] : " "
                                        ).toList(),
                                        wordColors: List.generate(
                                          kagomeWords.length,
                                          (i) => posToColor[kagomePos[i][0]]
                                        ),
                                        showRubys: showRubys,
                                        addSpaces: addSpaces,
                                        showColors: colorizePos,
                                        paintTextBoxes: false,
                                        selectionColor: Theme.of(context).colorScheme.primary.withOpacity(0.40),
                                        onSelectionChange: (selection) {
                                          if(selection != "" && popupAnimationController.status != AnimationStatus.forward){
                                            popupAnimationController.forward();
                                          }
                                          setState(() {
                                            selectedText = selection;
                                          });
                                        },
                                        onTap: (String selection) {
                                          if(selection == "" &&
                                            popupAnimationController.isCompleted) {
                                            popupAnimationController.reverse(from: 1.0);
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      // spaces toggle
                                      Material(
                                        color: Theme.of(context).cardColor,
                                        child: IconButton(
                                          icon: SvgPicture.asset(
                                            !addSpaces ?
                                            "assets/icons/space_bar_off.svg" :
                                            "assets/icons/space_bar_on.svg",
                                            color: Colors.white,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              addSpaces = !addSpaces;
                                            });
                                          },
                                        ),
                                      ),
                                      // furigana toggle
                                      Material(
                                        color: Theme.of(context).cardColor,
                                        child: IconButton(
                                          key: GlobalKey(),
                                          icon: SvgPicture.asset(
                                            showRubys ?
                                            "assets/icons/furigana_off.svg" :
                                            "assets/icons/furigana_on.svg",
                                            color: Colors.white,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              showRubys = !showRubys;
                                            });
                                          },
                                        ),
                                      ),
                                      // button to open on DeepL website
                                      Material(
                                        color: Theme.of(context).cardColor,
                                        child: IconButton(
                                          icon: SvgPicture.asset(
                                            colorizePos ?
                                            "assets/icons/palette_off.svg" :
                                            "assets/icons/palette_on.svg",
                                            color: Colors.white,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              colorizePos = !colorizePos;
                                            });
                                          },
                                        ),
                                      ),
                                      // full screen toggle
                                      Material(
                                        color: Theme.of(context).cardColor,
                                        child: IconButton(
                                          icon: Icon(!fullScreen ? 
                                            Icons.open_in_full : 
                                            Icons.close_fullscreen
                                          ),
                                          onPressed: () {
                                            // do not allow change while animation is running
                                            if (_controller.isAnimating) {
                                              return;
                                            }
                                            if(_controller.isCompleted) {
                                              _controller.reverse();
                                            } else if(_controller.isDismissed) {
                                              _controller.forward();
                                            }
                      
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
                              text: selectedText,
                              onMovedViaHeader: (event) {
                                setState(() {
                                  // assure that the popup is not moved out of view
                                  if(popupPositionLeft + event.delta.dx > 0 &&
                                    popupPositionLeft + popupSizeWidth + 
                                    2*padding + event.delta.dx < constraints.maxWidth) {
                                    popupPositionLeft += event.delta.dx;
                                  }
                                                  
                                  // assure that the popup is not moved out of view
                                  if(popupPositionTop + event.delta.dy > 0 &&
                                    popupPositionTop + popupSizeHeight + 
                                    2*padding + event.delta.dy < constraints.maxHeight) {
                                    popupPositionTop  += event.delta.dy;
                                  }
                                });
                              },
                              onResizedViaCorner: (event) {
                                setState(() {
                                  // don't allow resizing the popup over the 
                                  // window or smaller than the threshold 
                                  if(popupSizeWidth + event.delta.dx > popupSizeWidthMin &&
                                    popupSizeWidth + event.delta.dx + 2*padding < constraints.maxWidth) {
                                    popupSizeWidth += event.delta.dx;
                                  }
                                                  
                                  // don't allow resizing the popup over the 
                                  // window or smaller than the threshold 
                                  if(popupSizeHeight + event.delta.dy > popupSizeHeightMin &&
                                    popupSizeHeight + event.delta.dy + 2*padding < constraints.maxHeight) {
                                    popupSizeHeight += event.delta.dy;
                                  }
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
    );
  }


  /// Processes the given `text`.
  /// Analyzes the text with kagome, removes POS elements of punctuation marks,
  /// converts unidic POS to enum and removes readings for words that do not use
  /// kanji.
  /// 
  /// CAUTION: This method has SIDE-EFFECTS and outputs the processed text to the
  /// variable `kagomePos` and `kagomeWords`
  void processText(String text){
    
    // analyze text with kagome
    var analyzedWords = 
      GetIt.I<Kagome>().runAnalyzer(
        text, 
        AnalyzeModes.normal
      );
    kagomeWords = analyzedWords.item1.length == 1 && analyzedWords.item1[0] == ""
      ? [] : analyzedWords.item1;
    // remove POS for punctuation marks
    kagomePos = analyzedWords.item2.where(
      (e) => e.length > 5
    ).toList();
    
    for (var i = 0; i < kagomePos.length; i++) {
      // skip elements that are not words
      if(kagomePos[i].length < 17)
        continue;
      
      // convert the kagome pos to an enum element
      String l = kagomePos[i]
        .sublist(0, 4)
        .join("-")
        .replaceAll("-*", "");
      if(jpToPosUnidic[l] != null)
        kagomePos[i][0] = l;

      // if the word does not use kanji, remove the reading (furigana)
      if(GetIt.I<KanaKit>().isKana(kagomeWords[i]))
        kagomePos[i][9] = "";
    }
  }
}

