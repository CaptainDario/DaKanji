

// Flutter imports:
import "package:flutter/material.dart";
import 'package:flutter/services.dart';

class ResponsiveKeybindingInput extends StatefulWidget {
  ResponsiveKeybindingInput(
  {
    required this.keyBinding,
    required this.hintText,
    required this.defaultKeyBinding,
    this.onChanged,
    this.maxKeyCount = 3,
    Key? key
  }) : super(key: key);

  ///the key binding which should be used on instantiation
  final Set<LogicalKeyboardKey> keyBinding;
  /// explanatory text for the keybinding
  final String hintText;
  /// the default option for this keybinding
  /// 
  /// this is used when the user unfocusses the input field while no input
  /// was made
  final Set<LogicalKeyboardKey> defaultKeyBinding;
  /// callback which will be executed at every input change
  final Function (Set<LogicalKeyboardKey> keys)? onChanged;
  /// the maximum allowed number of keys for a keybinding
  final int maxKeyCount;
  /// TextEditingController which manages the of this input
  late final TextEditingController textEditingController = TextEditingController(
    text: keyBinding.map((e) => e.debugName!).join(" + ")
  );

  @override
  State<ResponsiveKeybindingInput> createState() => _ResponsiveKeybindingInputState();
}

class _ResponsiveKeybindingInputState extends State<ResponsiveKeybindingInput> {

  Set<LogicalKeyboardKey> currentKeys = {};

  void onChanged (Set<LogicalKeyboardKey> keys) {
    // set the input field's text to the key binding
    widget.textEditingController.text = keys.map((e) => e.debugName!).join(" + ");

    if(widget.onChanged != null) {
      widget.onChanged!(keys);
    }
  }

  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;
    double tileHeight = (height * 0.1).clamp(0, 45);
    double width = MediaQuery.of(context).size.width;

    return Focus(
      onFocusChange: (focused) {
        
        // if the widget is loosing focus and there is no text
        if(!focused && widget.textEditingController.text.isEmpty){
          currentKeys = widget.defaultKeyBinding;
          onChanged(currentKeys);
        }

      },
      child: KeyboardListener(
        focusNode: FocusNode(),
        onKeyEvent: (KeyEvent e) {
          
          // only register key down events
          if(e.runtimeType == KeyUpEvent) return;
    
          if(currentKeys.length < widget.maxKeyCount){
            currentKeys.add(e.logicalKey);
            onChanged(currentKeys);
          }
        },
        child: Material(
          child: InkWell(
            onTap: () {
            },
            child: SizedBox(
              height: tileHeight,
              width: width,
              child: Row(
                children: [
                  Expanded(
                    child: Center(
                      child: SizedBox(
                        height: (tileHeight*0.75),
                        child: TextField(
                          readOnly: false,
                          controller: widget.textEditingController,
                          autocorrect: false,
                          textAlignVertical: TextAlignVertical.bottom,
                          maxLines: 1,
                          decoration: InputDecoration(
                            labelText: widget.hintText,
                            border: const OutlineInputBorder(),
                            hintText: widget.hintText,
                          ),
                          style: const TextStyle(
                            overflow: TextOverflow.ellipsis,
                          ),
                          onTap: (){
                            currentKeys = {};
                            widget.textEditingController.text = "";
                            onChanged(currentKeys);
                          },
                          onChanged: (value) {
                            widget.textEditingController.text = "";
                            onChanged(currentKeys);
                            
                          },
                        )
                      ),
                    ),
                  ),
                  SizedBox(width: width*0.05,),
                ]
              ),
            ),
          ),
        ),
      ),
    );
  }
}
