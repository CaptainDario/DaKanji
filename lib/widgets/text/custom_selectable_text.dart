// Flutter imports:
import 'package:da_kanji_mobile/application/text/mecab_text_field_formatter.dart';
import 'package:da_kanji_mobile/globals.dart';
import 'package:da_kanji_mobile/application/text/mecab_text_editing_controller.dart';
import 'package:flutter/material.dart';

// Project imports:
import 'package:da_kanji_mobile/application/text/custom_selectable_text_controller.dart';
import 'package:provider/provider.dart';



/// Widget that implements custom text selection and furigana rendering
class CustomSelectableText extends StatefulWidget {
  const CustomSelectableText({
    super.key,

    this.editable = true,
    this.initialText,

    this.showRubys = false,
    this.addSpaces = false,
    this.showColors = false,

    this.textColor = Colors.black,
    
    this.init,
    this.onSelectionChange,
    this.onTap,
    this.onLongPress,
    this.onDoubleTap,
    this.onTripleTap,
    this.onTapOutsideOfText,
  });

  /// Is the text editable or read only
  final bool editable;
  /// The text that should be displayed when creating this widget
  final String? initialText;

  /// should the rubys be shown or not
  final bool showRubys;
  /// should spaces be added to the text between words
  final bool addSpaces;
  /// should the text be rendered in colors matching the POS
  final bool showColors;

  /// The color in which the text should be rendered
  final Color textColor;

  /// Callback that is called once this `CustomSelectableText` has been
  /// initialized, provides a controller to manipuilate this object as 
  /// parameter
  final void Function(CustomSelectableTextController controller)? init;
  /// callback that should be executed when the currently selected text chagnes
  /// provides the current `TextSelection` as parameter
  final void Function(TextSelection)? onSelectionChange;
  /// callback that is executed when a single tap is executed on the text
  /// provides the `TextSelection` where the tap appeared as parameter
  final void Function(TextSelection)? onTap;
  /// callbach that is executed when a long press is executed on the text
  /// provides the `TextSelection` where the tap appeared as parameter
  final void Function(TextSelection)? onLongPress;
  /// callback that is executed when a double tap is executed on the text
  /// provides the `TextSelection` where the tap appeared as parameter
  final void Function(TextSelection)? onDoubleTap;
  /// callback that is executed when a triple tap is executed on the text
  /// provides the `TextSelection` where the tap appeared as parameter
  final void Function(TextSelection)? onTripleTap;
  /// callback that is executed when a tap is executed outside of the text
  /// provides the `Offset` where the tap appeared as parameter
  final void Function(Offset)? onTapOutsideOfText;

  @override
  State<CustomSelectableText> createState() => _CustomSelectableTextState();
}

class _CustomSelectableTextState extends State<CustomSelectableText> {

  /// controller to manipulate this widget from outside
  late final CustomSelectableTextController _cstController;
  /// the cursor to use when hovering over text
  final MouseCursor _cursor = SystemMouseCursors.text;

  /// matches full and half width punctuations
  static const String punctuations = "。|？|！|\\.|\\!|\\?";
  /// matches japanese ending parantheses
  static const String japaneseParantheses = "』|」";
  /// matches any whitespace
  static const String anyWhiteSpace = "\\s|　";
  /// Regex that matches a sentence
  RegExp sentenceRegex = RegExp(
    "(?:[^$anyWhiteSpace])+?(?:(?!($punctuations)$japaneseParantheses)$punctuations|\\n|\$)",
    multiLine: true
  );
  /// Regex that matches a paragraph
  RegExp paragraphRegex = RegExp(
    r"(.+?):?(\n\n|$)",
    multiLine: false,
    dotAll: true
  );

  /// The controller used for displaying the Japanese text
  late MecabTextEditingController textInputController;




  @override
  void initState() {
    super.initState();
    _cstController = CustomSelectableTextController(
      updateSelectionGraphics: () => setState(() {}));

    textInputController = MecabTextEditingController(
      showRubys: widget.showRubys,
      addSpaces: widget.addSpaces,
      showColors: widget.showColors,
    );
    if(widget.initialText!=null) textInputController.text = widget.initialText!;
  }

  @override
  void didUpdateWidget (CustomSelectableText oldWidget) {
    super.didUpdateWidget(oldWidget);

    textInputController.showRubys  = widget.showRubys;
    textInputController.addSpaces  = widget.addSpaces;
    textInputController.showColors = widget.showColors;
  }

  /// Selects the word (PoS) where `event` happend
  void selectWord(int textStartIndex){

    var cnt = 0;
    for (var text in _cstController.words) {
      if(cnt + text.length > textStartIndex){
        _cstController.currentSelection = TextSelection(
          baseOffset: cnt,
          extentOffset: cnt + text.length
        );
        break;
      }

      cnt += text.length;
    }
  }

  /// Selects the sentance in which the position the user tapped is located
  void selectSentence(int textStartIndex){

    for (var match in sentenceRegex.allMatches(_cstController.words.join(""))) {
      if (match.start <= textStartIndex && textStartIndex <= match.end) {
        _cstController.currentSelection = TextSelection(
          baseOffset: match.start, 
          extentOffset: match.end
        );
        break;
      }
    }
  }

  /// Selects the paragraph that contains the word where `event` happend
  void selectParagraph(int textStartIndex){
    
    for (var match in paragraphRegex.allMatches(_cstController.words.join(""))) {
      if (match.start <= textStartIndex && textStartIndex <= match.end) {
        _cstController.currentSelection = TextSelection(
          baseOffset: match.start, 
          extentOffset: match.end-1
        );
        break;
      }
    }
  }


  @override
  Widget build(BuildContext context) {

    return Focus(
      focusNode: FocusNode(),
      canRequestFocus: true,
      child: MouseRegion(
        cursor: _cursor,
        hitTestBehavior: HitTestBehavior.translucent,
        child: Container(
          clipBehavior: Clip.hardEdge,
          decoration: const BoxDecoration(
            color: Colors.transparent,
          ),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: TextField(
              cursorHeight: textInputController.textCharacterSize.height,
              decoration: InputDecoration(
                hintText: "Start typing or use the tools below...",
              ),
              enabled: widget.editable,
              clipBehavior: Clip.none,
              // TODO test on SAMSUNG
              scribbleEnabled: true,
              maxLines: null,
              // allow line breaks
              keyboardType: TextInputType.multiline,
              textInputAction: TextInputAction.newline,
              // adjust the line height based on if rubys show or not
              style: TextStyle(
                height: widget.showRubys ? 2.5 : 2
              ),
              // do not allow some characters
              inputFormatters: [
                MecabTextFieldFormatter()
              ],
              controller: textInputController,
            ),
          ),
        ),
      ),
    );
  }
}
