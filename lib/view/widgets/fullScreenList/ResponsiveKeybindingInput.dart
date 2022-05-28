

import "package:flutter/material.dart";
import 'package:flutter/services.dart';


class ResponsiveKeybindingInput extends StatefulWidget {
  ResponsiveKeybindingInput(
  {
    required this.keyBinding,
    required this.hintText,
    required this.defaultKeyBinding,
    this.onChanged,
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

    if(widget.onChanged != null)
      widget.onChanged!(keys);
  }

  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;
    double tileHeight = (height * 0.1).clamp(0, 45);
    double width = MediaQuery.of(context).size.width;

    return Focus(
      onFocusChange: (focused) {
        
        // if the widget is loosing focus and there is no text
        if(!focused && widget.textEditingController.text.length == 0){
          currentKeys = widget.defaultKeyBinding;
          onChanged(currentKeys);
        }

      },
      child: RawKeyboardListener(
        autofocus: false,
        focusNode: FocusNode(),
        onKey: (RawKeyEvent e) {
          
          // only register key down events
          if(!e.isKeyPressed(e.logicalKey)) return;
          // do not register multiple down events
          if(e.repeat) return;
    
          currentKeys.add(e.logicalKey);
          onChanged(currentKeys);
        },
        child: Material(
          child: InkWell(
            onTap: () {
            },
            child: Container(
              height: tileHeight,
              width: width,
              child: Row(
                children: [
                  Expanded(
                    child: Center(
                      child: Container(
                        height: (tileHeight*0.75),
                        child: TextField(
                          readOnly: false,
                          controller: widget.textEditingController,
                          autocorrect: false,
                          textAlignVertical: TextAlignVertical.bottom,
                          maxLines: 1,
                          decoration: InputDecoration(
                            labelText: widget.hintText,
                            border: OutlineInputBorder(),
                            hintText: widget.hintText,
                          ),
                          style: TextStyle(
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