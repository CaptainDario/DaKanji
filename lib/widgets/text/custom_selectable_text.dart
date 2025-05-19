// Flutter imports:
import 'package:da_kanji_mobile/locales_keys.dart';
import 'package:da_kanji_mobile/widgets/helper/conditional_parent_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

// Project imports:
import 'package:da_kanji_mobile/globals.dart';
import 'package:da_kanji_mobile/application/text/mecab_text_editing_controller.dart';
import 'package:da_kanji_mobile/application/text/mecab_text_field_formatter.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

/// Widget that implements custom text selection and furigana rendering
class CustomSelectableText extends StatefulWidget {
  const CustomSelectableText({
    super.key,

    this.editable = true,
    this.initialText,

    this.init,

    this.showRubys = false,
    this.addSpaces = false,
    this.showColors = false,
  
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

  /// Function that is called after initializtion and provides the 
  /// [TextEditingController] of this input field
  final void Function(MecabTextEditingController controller)? init;

  /// should the rubys be shown or not
  final bool showRubys;
  /// should spaces be added to the text between words
  final bool addSpaces;
  /// should the text be rendered in colors matching the POS
  final bool showColors;

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


  /// The controller used for displaying the Japanese text
  late MecabTextEditingController textInputController;
  /// The focus node of this widget
  FocusNode f = FocusNode();


  void setReadOnly(bool newValue){

    if(!widget.editable) return;

    textInputController.readOnly = newValue;
  }

  @override
  void initState() {
    super.initState();

    textInputController = MecabTextEditingController(
      showRubys: widget.showRubys,
      addSpaces: widget.addSpaces,
      showColors: widget.showColors,
      readOnly: true,
      onTap: (TextSelection selection) {
        if(textInputController.text.isNotEmpty){
          setState(() {
            setReadOnly(true);  
          });
        }
        widget.onTap?.call(selection);
      },
      onDoubleTap: widget.onDoubleTap,
      onTripleTap: widget.onTripleTap,
      onSelectionChange: (TextSelection selecion) {
        widget.onSelectionChange?.call(selecion);
      },
      onLongPress: (TextSelection selection) {
        f.requestFocus();
        setReadOnly(false);
        widget.onLongPress?.call(selection);
      },
    );

    if(widget.initialText!=null) textInputController.text = widget.initialText!;

    widget.init?.call(textInputController);
  }

  @override
  void dispose() {
    f.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget (CustomSelectableText oldWidget) {
    super.didUpdateWidget(oldWidget);

    textInputController.showRubys  = widget.showRubys;
    textInputController.addSpaces  = widget.addSpaces;
    textInputController.showColors = widget.showColors;
  }


  @override
  Widget build(BuildContext context) {

    return KeyboardActions(
      enable: textInputController.readOnly,
      autoScroll: false,
      disableScroll: true,
      config: KeyboardActionsConfig(
        keyboardActionsPlatform: KeyboardActionsPlatform.IOS,
        keyboardBarColor: Theme.of(context).brightness == Brightness.dark
          ? Colors.grey[800]?.withAlpha(180)
          : Colors.grey[400]?.withAlpha(180),
        actions: [
          KeyboardActionsItem(
            focusNode: f,
            displayDoneButton: false,
            displayArrows: false,
            toolbarButtons: [
              (node) => IconButton(
                onPressed: () => node.unfocus(),
                icon: const Icon(Icons.close)
              )
            ]
          ),
        ],
      ),
      child: InputDecorator(
        decoration: InputDecoration(
          hintText: LocaleKeys.TextScreen_input_text_here.tr(),
        ),
        isEmpty: textInputController.text.isEmpty,
        child: EditableText(
          focusNode: f,
          cursorHeight: textInputController.textCharacterSize.height,
          showCursor: true,
          cursorColor: g_Dakanji_red,
          
          backgroundCursorColor: g_Dakanji_red,
          selectionColor: g_Dakanji_green.withAlpha(150),
          showSelectionHandles: false,
          readOnly: textInputController.readOnly,
          selectionControls: MaterialTextSelectionControls(),
          enableInteractiveSelection: false,
          
          stylusHandwritingEnabled: true,
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
    );
  }
}
