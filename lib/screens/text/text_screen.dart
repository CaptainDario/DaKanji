// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:another_flushbar/flushbar.dart';
import 'package:clipboard_watcher/clipboard_watcher.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get_it/get_it.dart';
import 'package:keyboard_detection/keyboard_detection.dart';
import 'package:onboarding_overlay/onboarding_overlay.dart';
import 'package:provider/provider.dart';
import 'package:universal_io/io.dart';

// Project imports:
import 'package:da_kanji_mobile/application/text/mecab_text_editing_controller.dart';
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

class _TextScreenState extends State<TextScreen> with TickerProviderStateMixin,
  ClipboardListener, WidgetsBindingObserver {


  /// the padding used between all widgets
  final double padding = 8.0;

  /// Should continously be copied from the clipboard
  bool continouslyCopy = false;

  /// if the option for showing furigana above words is enabled
  bool showRubys = false;
  /// if the option for showing spaces between words is enabled
  bool addSpaces = false;
  /// if the text should be colorized matching part of speech elements
  bool colorizePos = false;

  /// the animation controller for scaling in the popup window
  late AnimationController popupAnimationController;
  /// the tab controller for the tab bar of the popup
  late TabController popupTabController;
  /// the animation for scaling in the popup window
  late final Animation<double> popupAnimation;

  /// FocusNode for the text input
  FocusNode textinputFocusNode = FocusNode();

  /// custom [TextEditingController] for the text input
  MecabTextEditingController? mecabTextEditingController;
  
  /// the currently selected text
  String selectedText = "";
  /// the text that is currently in the input field
  String? inputText;
  /// scroll controller for the text analysis buttons
  final ScrollController _analysisOptionsScrollController = ScrollController();

  /// Timer that refreshes the UI every 1s (android only)
  Timer? refreshClipboardTimer;

  late KeyboardDetectionController keyboardDetectionController = KeyboardDetectionController(
    onChanged: (state) {
      if(state == KeyboardState.visible){
        setState(() {});
      }
      else if(state == KeyboardState.hidden){
        setState(() {});
      }
    },
  );


  /// when app comes back to foregorund update dict
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    setState(() {});
  }
  
  @override
  void initState() {

    super.initState();

    popupAnimationController = AnimationController(
      duration: const Duration(milliseconds: 250),
      value: 0.0,
      vsync: this,
    );
    popupAnimation = popupAnimationController.drive(
      CurveTween(curve: Curves.easeInOut)
    );

    // show the sample text in debug mode initially
    if(kDebugMode) inputText = g_SampleText;
    // if there is initial text, set it
    if(widget.initialText != null) inputText = widget.initialText!;

    initTutorial();
    initClipboardWatcher();
  }

  void initTutorial(){
    // after first frame
    WidgetsBinding.instance.addPostFrameCallback((Duration timeStamp) {
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
  void onClipboardChanged() async {

    if(!continouslyCopy) return;

    String data = (await Clipboard.getData('text/plain'))?.text ?? "";
    
    if(data != "" && data != mecabTextEditingController!.text){
      mecabTextEditingController!.text = data;
    }
  }

  /// Initializes the clipboard watching
  void initClipboardWatcher(){
    // android / iOS do not allow for continous clipboard reading
    //   -> periodically read clipboard till there is new value
    if(Platform.isAndroid || Platform.isIOS){
      refreshClipboardTimer = Timer.periodic(const 
        Duration(milliseconds: 500), (timer) async {
          onClipboardChanged();
        }
      );
    }
    // on other platforms always listen to clipboard
    else{
      clipboardWatcher.addListener(this);
      // start watch
      clipboardWatcher.start();
    }
  }

  @override
  void dispose() {
    if(refreshClipboardTimer != null){
      refreshClipboardTimer!.cancel();
    }
    else{
      clipboardWatcher.removeListener(this);
      // stop watch
      clipboardWatcher.stop();
    }

    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    return DaKanjiDrawer(
      currentScreen: Screens.text,
      useBackArrowAppBar: widget.useBackArrowAppBar,
      drawerClosed: !widget.openedByDrawer,
      child: KeyboardDetection(
        controller: keyboardDetectionController,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return TextAnalysisStack(
              textToAnalyze: selectedText,
              popupAnimationController: popupAnimationController,
              padding: 8.0,
              constraints: constraints,
              allowDeconjugation: GetIt.I<Settings>().text.deconjugateBeforeSearch,
              onPopupInitialized: (tabController) {
                popupTabController = tabController;
              },
              children: [
                // processed text
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  bottom: keyboardDetectionController.state == KeyboardState.visible
                    ? keyboardDetectionController.size +
                      (Platform.isIOS ? 40 : 0)
                    : 0,
                  child: GestureDetector(
                    onTap: () {
                      assurePopupClosed();
                    },
                    child: Card(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(
                          padding, padding, padding, padding/2
                        ),
                        child: Column(
                          children: [
                            Expanded(
                              child: MultiFocus(
                                focusNodes: widget.includeTutorial
                                  ? GetIt.I<Tutorials>().textScreenTutorial.textInputSteps
                                  : null,
                                child: Align(
                                  alignment: Alignment.bottomLeft,
                                  child: CustomSelectableText(
                                    initialText: inputText,
                                    showRubys: showRubys,
                                    addSpaces: addSpaces,
                                    showColors: colorizePos,
                                    init: onTextFieldInit,
                                    onTap: onCustomSelectableTextTap,
                                    onLongPress: onCustomSelectableTextLongPress,
                                    onSelectionChange: onCustomSelectableTextChange,
                                    onTapOutsideOfText: (Offset location) {
                                      if(popupAnimationController.isCompleted){
                                        popupAnimationController.reverse();
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ),
                            // tools
                            if(mecabTextEditingController != null)
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
                                      // paste text button
                                      AnalysisOptionButton(
                                        true,
                                        offIcon: continouslyCopy
                                          ? Icons.sync
                                          : mecabTextEditingController!.text.isEmpty
                                            ? Icons.paste
                                            : Icons.close,
                                        onIcon: continouslyCopy
                                          ? Icons.sync
                                          : mecabTextEditingController!.text.isEmpty
                                            ? Icons.paste
                                            : Icons.close,
                                        onPressed: onPastePressed,
                                        onLongPressed: onPasteLongPressed,
                                      ),
                                      // copy button
                                      AnalysisOptionButton(
                                        true,
                                        offIcon: Icons.copy,
                                        onIcon: Icons.copy,
                                        onPressed: onCopyPressed,
                                      ),
                                      // info button
                                      AnalysisOptionButton(
                                        true,
                                        offIcon: Icons.info_outline,
                                        onIcon: Icons.info_outline,
                                        onPressed: onInfoPressed,
                                      ),
                                      // text navigation button
                                      if(GetIt.I<Settings>().text.selectionButtonsEnabled)
                                        ...[
                                          // shrink selection button
                                          AnalysisOptionButton(
                                            true,
                                            onIcon: Icons.arrow_back,
                                            offIcon: Icons.arrow_back,
                                            onPressed: onShrinkPressed,
                                            onLongPressed: onShrinkLongPressed
                                          ),
                                          // grow selection button
                                          AnalysisOptionButton(
                                            true,
                                            onIcon: Icons.arrow_forward,
                                            offIcon: Icons.arrow_forward,
                                            onPressed: onGrowPressed,
                                            onLongPressed: onGrowLongPressed,
                                          ),
                                          // select previous token / char
                                          AnalysisOptionButton(
                                            true,
                                            onIcon: Icons.arrow_left,
                                            offIcon: Icons.arrow_left,
                                            onPressed: onPreviousPressed, // token
                                            onLongPressed: onPreviousLongPressed // char
                                          ),
                                          // select next token / char
                                          AnalysisOptionButton(
                                            true,
                                            onIcon: Icons.arrow_right,
                                            offIcon: Icons.arrow_right,
                                            onPressed: onNextPressed, // token
                                            onLongPressed: onNextLongPressed, // char
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
        ),
      )
    );
  }

  /// Called when the text field has been initialized
  void onTextFieldInit(controller) {

    mecabTextEditingController = controller;
    if(!kDebugMode && context.read<Settings>().text.saveTextAcrossSessions){
      mecabTextEditingController!.text = context.read<Settings>().text.text;
    }

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  
    mecabTextEditingController!.addListener(() {
      context.read<Settings>().text.text = mecabTextEditingController!.text;
      context.read<Settings>().save();
    });

  }

  /// assures that the popup is open by opening it if it is closed
  void assurePopupOpen(){
    if(!popupAnimationController.isCompleted){
      popupAnimationController.forward();
    }
  }

  /// assures that the popup is open by opening it if it is closed
  void assurePopupClosed(){
    if(!popupAnimationController.isDismissed){
      popupAnimationController.reverse();
    }
  }

  /// Callback that is called when the text selection of the CustomSelectableText
  /// changes
  void onCustomSelectableTextChange(TextSelection selection){

    bool someTextIsSelected = (selection.end - selection.start).abs() != 0;

    if(!mecabTextEditingController!.readOnly) return;

    // open the dict popup when text is slected and it is not opening
    if(someTextIsSelected &&
      popupAnimationController.status != AnimationStatus.forward)
    {
      popupAnimationController.forward();
    }
    // If the popup is open but now there is no selection close the popup
    if(!someTextIsSelected && !popupAnimationController.isDismissed)
    {
      popupAnimationController.reverse(from: 1.0);
    }
    // get the part that the user selected
    if(mecabTextEditingController!.text.length < selection.extentOffset ||
      mecabTextEditingController!.text.length < selection.baseOffset) return;

    setState(() {
      selectedText = mecabTextEditingController!.text.substring(
        selection.start, selection.end
      );
    });
  }

  onCustomSelectableTextTap(TextSelection selection) {
    onCustomSelectableTextChange(selection);
  }

  /// Callback that is executed when the use long presses on the text widget
  onCustomSelectableTextLongPress(TextSelection selection) {

    setState(() {});
  }

  /// Callback when the user presses the info button
  void onInfoPressed(){

    if(mecabTextEditingController!.selection.isCollapsed) return;

    // remove current snackbar if any
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).removeCurrentSnackBar();

    // get the pos of the current selection
    int tokenIdx = mecabTextEditingController!.getTokenAtTextIndex(
      mecabTextEditingController!.selection.baseOffset)+1;
    String posText = mecabTextEditingController!.mecabPOS[tokenIdx]
      .where((pos) => pos != "*")
      .join(", ");

    // show the PoS of the currently selected work
    Flushbar(
      messageText: SelectableText(posText),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      duration: const Duration(milliseconds: 10000),
    ).show(context);

  }

  /// Callback that is executed when the user presses the paste button
  void onPastePressed() async {

    // if there is text and not continously copying, delete the text
    if(!continouslyCopy && mecabTextEditingController!.text.isNotEmpty){
      mecabTextEditingController!.text = "";
    }
    // otherwise paste the current clipboard
    else {
      ClipboardData? clipboardData = await Clipboard.getData('text/plain');
      String clipboardString = clipboardData?.text ?? "";
      mecabTextEditingController!.text = clipboardString;
    }

   setState(() {});

  }

  /// Callback that is executed when the user presses the copy button
  void onCopyPressed() {

    final s = mecabTextEditingController!.getStartAndEnd();

    String currentSelection = mecabTextEditingController!.text.substring(
      s.start == -1 ? 0 : s.start,
      s.end == -1 ? mecabTextEditingController!.text.length : s.end);
    
    Clipboard.setData(ClipboardData(text:currentSelection)).then((_){
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "${LocaleKeys.TextScreen_copy_button_copy.tr()} $currentSelection",
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ))
        );
    });

  }

  /// Callback that is executed when the user long presses the copy button
  void onPasteLongPressed() {

    setState(() { continouslyCopy = !continouslyCopy; });

  }

  /// Callback that is executed when the shrink button is pressed
  void onShrinkPressed(){

    mecabTextEditingController!.modifySelectionByTokens(-1);
    assurePopupOpen();

  }

  /// Callback that is executed when the shrink button is long pressed
  void onShrinkLongPressed(){

    mecabTextEditingController!.modifySelectionByCharacters(-1);
    assurePopupOpen();

  }

  /// Callback that is executed when the grow button is pressed
  void onGrowPressed(){

    mecabTextEditingController!.modifySelectionByTokens(1);
    assurePopupOpen();

  }

  /// Callback that is executed when the grow button is long pressed
  void onGrowLongPressed(){

    mecabTextEditingController!.modifySelectionByCharacters(1);
    assurePopupOpen();

  }

  /// Callback that is executed when the previous button is pressed
  void onPreviousPressed(){

    mecabTextEditingController!.moveSelectionByTokens(-1);
    assurePopupOpen();

  }

  /// Callback that is executed when the previous button is long pressed
  void onPreviousLongPressed(){

    mecabTextEditingController!.moveSelectionByCharacters(-1);
    assurePopupOpen();

  }

  /// Callback that is executed when the next button is pressed
  void onNextPressed(){

    mecabTextEditingController!.moveSelectionByTokens(1);
    assurePopupOpen();

  }

  /// Callback that is executed when the next button is long pressed
  void onNextLongPressed(){

    mecabTextEditingController!.moveSelectionByCharacters(1);
    assurePopupOpen();

  }

}

