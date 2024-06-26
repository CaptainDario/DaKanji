// Dart imports:
import 'dart:math';

// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:get_it/get_it.dart';
import 'package:kana_kit/kana_kit.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:mecab_dart/mecab_dart.dart';
import 'package:onboarding_overlay/onboarding_overlay.dart';

// Project imports:
import 'package:da_kanji_mobile/application/text/custom_selectable_text_controller.dart';
import 'package:da_kanji_mobile/application/text/pos.dart';
import 'package:da_kanji_mobile/entities/screens.dart';
import 'package:da_kanji_mobile/entities/settings/settings.dart';
import 'package:da_kanji_mobile/entities/show_cases/tutorials.dart';
import 'package:da_kanji_mobile/entities/user_data/user_data.dart';
import 'package:da_kanji_mobile/globals.dart';
import 'package:da_kanji_mobile/locales_keys.dart';
import 'package:da_kanji_mobile/widgets/drawer/drawer.dart';
import 'package:da_kanji_mobile/widgets/text/analysis_option_button.dart';
import 'package:da_kanji_mobile/widgets/text/custom_selectable_text.dart';
import 'package:da_kanji_mobile/widgets/text_analysis/text_analysis_stack.dart';
import 'package:da_kanji_mobile/widgets/widgets/multi_focus.dart';

/// The "draw"-screen.
/// 
/// Lets the user draw a kanji and than shows the most likely predictions.
/// Those can than be copied / opened in dictionaries by buttons.
class TextScreen extends StatefulWidget {

  /// was this page opened by clicking on the tab in the drawer
  final bool openedByDrawer;
  /// If set to true, the app will include a back-arrow instead of the hamburger
  /// menu (useful if a screen should just be shown shortly and the user likely
  /// want to go back to the previous screen)
  final bool useBackArrowAppBar;
  /// should the focus nodes for the tutorial be included
  final bool includeTutorial;
  /// The text that should be analyzed when the screen is opened
  final String? initialText;

  const TextScreen(
    this.openedByDrawer, 
    this.includeTutorial, 
    {
      this.useBackArrowAppBar = false,
      this.initialText,
      super.key
    });

  @override
  State<TextScreen> createState() => _TextScreenState();
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
  /// FocusNode for the text input
  FocusNode textinputFocusNode = FocusNode();
  /// the currently selected text
  String selectedText = "";
  /// the text that is currently in the input field
  String inputText = "";
  /// the controller to manipulate the CustomSelectableText
  late CustomSelectableTextController customSelectableTextController;
  /// scroll controller for the text analysis buttons
  final ScrollController _analysisOptionsScrollController = ScrollController();


  
  @override
  void initState() {

    super.initState();

    // check if the screen should open with the processed text in fullscreen
    fullScreen = GetIt.I<Settings>().text.openInFullscreen;

    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      value: fullScreen ? 1.0 : 0.0,
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

      // show the sample text in debug mode initially
      if(kDebugMode){
        setState(() {
          inputController.text = g_SampleText;
          inputText = g_SampleText;
          processText(inputText);
        }); 
      }

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
        if(widget.includeTutorial && onboarding != null && 
          GetIt.I<UserData>().showTutorialText) {
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
      drawerClosed: !widget.openedByDrawer,
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
                allowDeconjugation: GetIt.I<Settings>().text.searchDeconjugate,
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
                            child: KeyboardActions(
                              config: KeyboardActionsConfig(
                                actions: [
                                  KeyboardActionsItem(
                                    focusNode: textinputFocusNode,
                                    toolbarButtons: [
                                    (node) {
                                      return GestureDetector(
                                        onTap: () => node.unfocus(),
                                        child: const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Icon(Icons.close),
                                        ),
                                      );
                                    }
                                  ]),
                                ]
                              ),
                              child: TextField(
                                focusNode: textinputFocusNode,
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
                                      init: (controller){
                                        customSelectableTextController = controller;
                                      },
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
                              Align(
                                alignment: Alignment.centerRight,
                                child: Scrollbar(
                                  controller: _analysisOptionsScrollController,
                                  child: SingleChildScrollView(
                                    controller: _analysisOptionsScrollController,
                                    scrollDirection: Axis.horizontal,
                                    child: Wrap(
                                      runAlignment: WrapAlignment.end,
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
                                        // paste text button
                                        AnalysisOptionButton(
                                          true,
                                          offIcon: Icons.paste,
                                          onIcon: Icons.paste,
                                          onPressed: () async {
                                            ClipboardData? clipboardData = await Clipboard.getData('text/plain');
                                            String clipboardString = clipboardData?.text ?? "";
                                            setState(() {
                                              customSelectableTextController.resetSelection();
                                              inputController.text = clipboardString;
                                              inputText = clipboardString;
                                              processText(clipboardString);
                                            });
                                          },
                                        ),
                                        // copy button
                                        AnalysisOptionButton(
                                          true,
                                          offIcon: Icons.copy,
                                          onIcon: Icons.copy,
                                          onPressed: () {
                                  
                                            String currentSelection =
                                              customSelectableTextController.getCurrentSelectionString();
                                            Clipboard.setData(
                                              ClipboardData(text:currentSelection)
                                            ).then((_){
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                SnackBar(
                                                  content: Text("${LocaleKeys.TextScreen_copy_button_copy.tr()} $currentSelection"))
                                                );
                                            });
                                          },
                                        ),
                                        
                                        if(GetIt.I<Settings>().text.selectionButtonsEnabled)
                                          ...[
                                            // shrink selection button
                                            AnalysisOptionButton(
                                              true,
                                              onIcon: Icons.arrow_back,
                                              offIcon: Icons.arrow_back,
                                              onPressed: () {
                                                customSelectableTextController.shrinkSelectionRight(0);
                                                assurePopupOpen();
                                              },
                                              onLongPressed: () {
                                                customSelectableTextController.shrinkSelectionRight(1);
                                                assurePopupOpen();
                                              },
                                            ),
                                            // grow selection button
                                            AnalysisOptionButton(
                                              true,
                                              onIcon: Icons.arrow_forward,
                                              offIcon: Icons.arrow_forward,
                                              onPressed: () {
                                                customSelectableTextController.growSelectionRight(growBy: 0);
                                                assurePopupOpen();
                                              },
                                              onLongPressed: () {
                                                customSelectableTextController.growSelectionRight(growBy: 1);
                                                assurePopupOpen();
                                              },
                                            ),
                                            // select previous token / char
                                            AnalysisOptionButton(
                                              true,
                                              onIcon: Icons.arrow_left,
                                              offIcon: Icons.arrow_left,
                                              onPressed: () {
                                                customSelectableTextController.selectPrevious();
                                                assurePopupOpen();
                                              },
                                              onLongPressed: () {
                                                customSelectableTextController.selectPrevious(previousChar: true);
                                                assurePopupOpen();
                                              },
                                            ),
                                            // select next token / char
                                            AnalysisOptionButton(
                                              true,
                                              onIcon: Icons.arrow_right,
                                              offIcon: Icons.arrow_right,
                                              // word
                                              onPressed: () {
                                                customSelectableTextController.selectNext();
                                                assurePopupOpen();
                                              },
                                              // char
                                              onLongPressed: () {
                                                customSelectableTextController.selectNext(nextChar: true);
                                                assurePopupOpen();
                                              },
                                            ),
                                          ]
                                      ],
                                    ),
                                  ),
                                ),
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

  /// assures that the popup is open by opening it if it is closed
  void assurePopupOpen(){
    if(!popupAnimationController.isCompleted){
      popupAnimationController.forward();
    }
  }

  /// Callback that is called when the text selection of the CustomSelectableText
  /// changes
  void onCustomSelectableTextChange(TextSelection selection){
    // open the dict popup when text is slected and it is not opening
    if(selection.start != selection.end &&
      popupAnimationController.status != AnimationStatus.forward)
    {
      popupAnimationController.forward();
    }
    // close the dict popup when there is no selection
    if(selection.isCollapsed && popupAnimationController.isCompleted)
    {
      popupAnimationController.reverse(from: 1.0);
    }
    // get the part that the user selected
    int start = min(selection.baseOffset, selection.extentOffset);
    int end   = max(selection.baseOffset, selection.extentOffset);
    String word = mecabSurfaces
      .join("")
      .substring(start, end)
      .replaceAll("\n ", "\n")
      .replaceAll(" \n", "\n");
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
      cnt += mecabSurfaces[i].length;
    }

    if(pos == "") {
      return;
    }

    setState(() {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(pos),
          duration: const Duration(milliseconds: 5000),
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
    
    // analyze text with mecab
    List<TokenNode> analyzedText = GetIt.I<Mecab>().parse(text);
    // remove EOS symbol
    analyzedText.removeLast(); 

    mecabReadings = []; mecabSurfaces = []; mecabPOS = [];
    int txtCnt = 0;
    for (var i = 0; i < analyzedText.length; i++) {
      // remove furigana when: non Japanese, kana only, no reading, reading == word
      if(!GetIt.I<KanaKit>().isJapanese(analyzedText[i].surface) ||
        GetIt.I<KanaKit>().isKana(analyzedText[i].surface) ||
        analyzedText[i].features.length < 8 ||
        analyzedText[i].features[7] == analyzedText[i].surface
      )
      {
        mecabReadings.add(" ");
      }
      else{
        mecabReadings.add(GetIt.I<KanaKit>().toHiragana(analyzedText[i].features[7]));
      }
      mecabPOS.add(analyzedText[i].features.sublist(0, 4).join("-"));
      mecabSurfaces.add(analyzedText[i].surface);

      // add line breaks to mecab output
      if(i < analyzedText.length-1 && text[txtCnt + analyzedText[i].surface.length] == "\n"){
        while(text[txtCnt + analyzedText[i].surface.length] == "\n"){
          mecabPOS.add("");
          mecabSurfaces.add("\n");
          mecabReadings.add("");
          txtCnt += 1;
        }
      }
      txtCnt += analyzedText[i].surface.length;
    }
  }
}

