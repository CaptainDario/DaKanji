import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get_it/get_it.dart';
import 'package:mecab_dart/mecab_dart.dart';
import 'package:onboarding_overlay/onboarding_overlay.dart';
import 'package:kana_kit/kana_kit.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:da_kanji_mobile/domain/settings/settings.dart';
import 'package:da_kanji_mobile/widgets/text_analysis/text_analysis_stack.dart';
import 'package:da_kanji_mobile/widgets/widgets/multi_focus.dart';
import 'package:da_kanji_mobile/locales_keys.dart';
import 'package:da_kanji_mobile/data/screens.dart';
import 'package:da_kanji_mobile/widgets/text/custom_selectable_text.dart';
import 'package:da_kanji_mobile/application/helper/part_of_speech.dart';
import 'package:da_kanji_mobile/widgets/drawer/drawer.dart';
import 'package:da_kanji_mobile/widgets/text/analysis_option_button.dart';
import 'package:da_kanji_mobile/data/show_cases/tutorials.dart';
import 'package:da_kanji_mobile/domain/user_data/user_data.dart';




/// The "draw"-screen.
/// 
/// Lets the user draw a kanji and than shows the most likely predictions.
/// Those can than be copied / opened in dictionaries by buttons.
class TextScreen extends StatefulWidget {

  /// was this page opened by clicking on the tab in the drawer
  final bool openedByDrawer;
  /// If set to true, the app will include a back-arrow instead of the hamburger
  /// menu (useful if a sceen should just be shown shortly and the user likely
  /// want to go back to the previous screen)
  final bool useBackArrowAppBar;
  /// should the focus nodes for the tutorial be included
  final bool includeTutorial;
  /// The text that should be analyzed when the screen is opened
  final String? initialText;

  TextScreen(
    this.openedByDrawer, 
    this.includeTutorial, 
    {
      this.useBackArrowAppBar = false,
      this.initialText,
      Key? key
    }) : super(key: key);

  @override
  _TextScreenState createState() => _TextScreenState();
}

class _TextScreenState extends State<TextScreen> with TickerProviderStateMixin {

  /// the output surfaces of mecab
  List<String> mecabSurfaces = const [];
  /// the output part of speech elements of mecab
  List<String> mecabPOS = const [];
  /// the output readings of mecab
  List<String> mecabReadings = const [];

  /// the padding used between all widgets
  final double padding = 8.0;

  /// if the option to make the analyzed text fullscreen
  bool fullScreen = false;  
  /// if the option for showing furigana above words is enabled
  bool showRubys = false;
  /// if the option for showing spaces between words is enabled
  bool addSpaces = false;
  /// if the text should be colorized matching part of speech elements
  bool colorizePos = false;

  /// should this screen be shown in portrait or not
  bool runningInPortrait = false;

  /// the animation controller for scaling in the popup window
  late AnimationController popupAnimationController;
  /// the tab controller for the tab bar of the popup
  late TabController popupTabController;
  /// the animation for scaling in the popup window
  late final Animation<double> popupAnimation;
  /// the animation controller for animating maximizing the processed text widget
  late final AnimationController _controller;
  /// the animation for animating maximizing the processed text widget
  late Animation _animation;

  /// the input field's controller
  final TextEditingController inputController = TextEditingController();
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

    // after first frame
    WidgetsBinding.instance.addPostFrameCallback((Duration timeStamp) {

      // if there is initial text, set it
      if(widget.initialText != null){
        setState(() {
          inputController.text = widget.initialText!;
          inputText = widget.initialText!;
          processText(inputText);
        }); 
      }

      // init tutorial
      if(widget.includeTutorial){
        final OnboardingState? onboarding = Onboarding.of(context);
        if (onboarding != null && 
          GetIt.I<UserData>().showShowcaseText) {

          onboarding.showWithSteps(
            GetIt.I<Tutorials>().textScreenTutorial.indexes![0],
            GetIt.I<Tutorials>().textScreenTutorial.indexes!
          );
        }
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
      useBackArrowAppBar: widget.useBackArrowAppBar,
      animationAtStart: !widget.openedByDrawer,
      child: LayoutBuilder(
        builder: (context, constraints) {

          runningInPortrait = constraints.maxHeight > constraints.maxWidth ? true : false;

          return AnimatedBuilder(
            animation: _controller,
            builder: (context, builder) {
              return TextAnalysisStack(
                textToAnalyze: selectedText,
                poupAnimationController: popupAnimationController,
                padding: 8.0,
                constraints: constraints,
                allowDeconjugation: GetIt.I<Settings>().dictionary.searchDeconjugate,
                onPopupInitialized: (tabController) {
                  popupTabController = tabController;
                },
                children: [
                  // Text input
                  Focus(
                    onFocusChange: (value) {
                      if(value && popupAnimationController.isCompleted){
                        popupAnimationController.reverse();
                      }
                    },
                    child: SizedBox(
                      width: runningInPortrait
                        ? constraints.maxWidth - padding
                        : (constraints.maxWidth/2-padding) * (1-_animation.value),
                      height: runningInPortrait
                        ? (constraints.maxHeight/2-padding) * (1-_animation.value)
                        : constraints.maxHeight - padding,
                      child: Card(
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(
                            2*padding, padding, 2*padding, padding
                          ),
                          child: Focus(
                            focusNode: widget.includeTutorial
                              ? GetIt.I<Tutorials>().textScreenTutorial.textInputSteps
                              : null,
                            child: TextField(
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                hintText: LocaleKeys.TextScreen_input_text_here.tr(),
                              ),
                              inputFormatters: [
                                FilteringTextInputFormatter.deny(
                                  RegExp(r"\u000d| "),
                                  //replacementString: "\r"
                                ),
                                FilteringTextInputFormatter.deny(
                                  RegExp(r"\u000a|\U+2588"),
                                  replacementString: "\n"
                                ),
                              ],
                              controller: inputController,
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
                    )
                  ),
                  // processed text
                  Positioned(
                    bottom: 0,
                    right: runningInPortrait ? null : 0,
                    child: SizedBox(
                      width: runningInPortrait
                        ? constraints.maxWidth - 2*padding
                        : (constraints.maxWidth/2-padding) * (_animation.value+1.0),
                      height: runningInPortrait
                        ? (constraints.maxHeight/2-padding) * (_animation.value+1.0)
                        : constraints.maxHeight - 2*padding,
                      child: Card(
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(
                            2*padding, 2*padding, 2*padding, padding/2
                          ),
                          child: Column(
                            children: [
                              Expanded(
                                child: MultiFocus(
                                  focusNodes: widget.includeTutorial
                                    ? GetIt.I<Tutorials>().textScreenTutorial.processedTextSteps
                                    : null,
                                  child: Center(
                                    child: CustomSelectableText(
                                      words: mecabSurfaces,
                                      rubys: mecabReadings,
                                      wordColors: List.generate(
                                        mecabPOS.length, (i) => posToColor(mecabPOS[i])
                                      ),
                                      showRubys: showRubys,
                                      addSpaces: addSpaces,
                                      showColors: colorizePos,
                                      paintTextBoxes: false,
                                      textColor: Theme.of(context).brightness == Brightness.light
                                        ? Colors.black
                                        : Colors.white,
                                      selectionColor: Theme.of(context).highlightColor,
                                      onSelectionChange: onCustomSelectableTextChange,
                                      onLongPress: onCustomSelectableTextLongPressed,
                                      onTapOutsideOfText: (Offset location) {
                                        if(popupAnimationController.isCompleted){
                                          popupAnimationController.reverse();
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  // spaces toggle
                                  Focus(
                                    focusNode: widget.includeTutorial ?
                                      GetIt.I<Tutorials>().textScreenTutorial.spacesButtonSteps : null,
                                    child: AnalysisOptionButton(
                                      addSpaces,
                                      svgAssetPattern: "assets/icons/space_bar_*.svg",
                                      onPressed: (() => 
                                        setState(() {addSpaces = !addSpaces;})
                                      ),
                                    ),
                                  ),
                                  // furigana toggle
                                  Focus(
                                    focusNode: widget.includeTutorial ?
                                      GetIt.I<Tutorials>().textScreenTutorial.furiganaSteps : null,
                                    child: AnalysisOptionButton(
                                      showRubys,
                                      svgAssetPattern: "assets/icons/furigana_*.svg",
                                      onPressed: (() => 
                                        setState(() {showRubys = !showRubys;})
                                      ),
                                    )
                                  ),
                                  // button to colorize words matching POS
                                  Focus(
                                    focusNode: widget.includeTutorial ?
                                      GetIt.I<Tutorials>().textScreenTutorial.colorButtonSteps : null,
                                    child: AnalysisOptionButton(
                                      colorizePos,
                                      svgAssetPattern: "assets/icons/pos_*.svg",
                                      onPressed: (() => 
                                        setState(() {colorizePos = !colorizePos;})
                                      ),
                                    )
                                  ),
                                  // full screen toggle
                                  Focus(
                                    focusNode: widget.includeTutorial ?
                                      GetIt.I<Tutorials>().textScreenTutorial.fullscreenSteps : null,
                                    child: AnalysisOptionButton(
                                      fullScreen,
                                      onIcon: Icons.fullscreen,
                                      offIcon: Icons.fullscreen_exit,
                                      onPressed: onFullScreenButtonPress
                                    )
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  
                ]
              );
            }
          );
        }
      )
    );
  }

  /// Callback that is called when the text selection of the CustomSelectableText
  /// changes
  void onCustomSelectableTextChange(TextSelection selection){
    // open the dict popup when text is slected and it is not opening
    if(selection != "" &&
      popupAnimationController.status != AnimationStatus.forward)
    {
      popupAnimationController.forward();
    }
    // close the dict popup when there is no selection
    if(selection == "" &&
      popupAnimationController.isCompleted)
    {
      popupAnimationController.reverse(from: 1.0);
    }
    // get the part that the user selected
    int start = min(selection.baseOffset, selection.extentOffset);
    int end   = max(selection.baseOffset, selection.extentOffset);
    String word = mecabSurfaces
      .join(addSpaces ? " " : "")
      .substring(start, end)
      .replaceAll(" ", "");
    setState(() {
      selectedText = word;
    });
  }

  /// Callback when the user long presses the a word in the text
  void onCustomSelectableTextLongPressed(TextSelection selection){
    // remove current snackbar if any
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).removeCurrentSnackBar();

    int cnt = 0; String pos = "";
    for (int i = 0; i < mecabSurfaces.length; i++) {
      if(selection.baseOffset <= cnt && cnt <= selection.extentOffset){
        pos = posToTranslation(mecabPOS[i]) ?? "";
        break;
      }
      cnt += (mecabSurfaces[i] + (addSpaces ? " " : "")).length;
    }

    if(pos == "")
      return;

    setState(() {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(pos),
          duration: Duration(milliseconds: 5000),
        )
      );
    });
  }

  /// Callback when the user presses the full screen button
  void onFullScreenButtonPress() {
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
  }

  /// Processes the given `text` with mecab. Outputs the processing result to 
  /// mecabPOS, mecabSurfaces and mecabReadings
  void processText(String text){
    
    // analyze text with kagome
    List<TokenNode> _analyzedText = GetIt.I<Mecab>().parse(text);
    // remove EOS symbol
    _analyzedText.removeLast(); 

    mecabReadings = []; mecabSurfaces = []; mecabPOS = [];
    int txtCnt = 0;
    for (var i = 0; i < _analyzedText.length; i++) {
      // remove furigana when: non Japanese, kana only, no reading, reading == word
      if(!GetIt.I<KanaKit>().isJapanese(_analyzedText[i].surface) ||
        GetIt.I<KanaKit>().isKana(_analyzedText[i].surface) ||
        _analyzedText[i].features.length < 8 ||
        _analyzedText[i].features[7] == _analyzedText[i].surface
      )
      {
        mecabReadings.add(" ");
      }
      else{
        mecabReadings.add(GetIt.I<KanaKit>().toHiragana(_analyzedText[i].features[7]));
      }
      mecabPOS.add(_analyzedText[i].features.sublist(0, 4).join("-"));
      mecabSurfaces.add(_analyzedText[i].surface);

      // add line breaks to mecab output
      if(i < _analyzedText.length-1 && text[txtCnt + _analyzedText[i].surface.length] == "\n"){
        while(text[txtCnt + _analyzedText[i].surface.length] == "\n"){
          mecabPOS.add("");
          mecabSurfaces.add("\n");
          mecabReadings.add("");
          txtCnt += 1;
        }
      }
      txtCnt += _analyzedText[i].surface.length;
    }
  }
}

