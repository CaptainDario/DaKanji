

import "package:flutter/material.dart";
import 'package:flutter/services.dart';


class SettingsDrawBindingsInput extends StatefulWidget {
  SettingsDrawBindingsInput(
  {
    required this.enabled,
    required this.hintText,
    required this.defaultKey,
    this.onChanged,
    Key? key
  }) : super(key: key);

  /// Is the Input field enabled
  final bool enabled;
  // explanatory text
  final String hintText;
  // the default option for this shortcut
  final LogicalKeyboardKey defaultKey;
  /// callback which will be executed at every input change
  final Function (String value)? onChanged;

  final TextEditingController textEditingController = TextEditingController();

  @override
  State<SettingsDrawBindingsInput> createState() => _SettingsDrawBindingsInputState();
}

class _SettingsDrawBindingsInputState extends State<SettingsDrawBindingsInput> {

  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;
    double tileHeight = (height * 0.1).clamp(0, 45);
    double width = MediaQuery.of(context).size.width;


    return Focus(
      onFocusChange: (focused) {
        
        // assure that the widget is loosing focus
        if(focused)
        // assure that there is no text
        if(widget.textEditingController.text.length != 0)

        widget.textEditingController.text = widget.defaultKey.debugName!;

      },
      child: RawKeyboardListener(
        autofocus: true,
        focusNode: FocusNode(),
        onKey: (RawKeyEvent e) {
          
          // only register key down events
          if(!e.isKeyPressed(e.logicalKey)) return;
          // do not register multiple down events
          if(e.repeat) return;
          // assure that the key has a name
          if(e.logicalKey.debugName == null) return;
    
          if(widget.textEditingController.text.length == 0)
            widget.textEditingController.text = e.logicalKey.debugName!;
          else
            widget.textEditingController.text += " + " + e.logicalKey.debugName!;
          
          // text has changed
          if(widget.onChanged != null) 
            widget.onChanged!(widget.textEditingController.text);
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
                          controller: widget.textEditingController,
                          autocorrect: false,
                          enabled: widget.enabled,
                          textAlignVertical: TextAlignVertical.bottom,
                          decoration: InputDecoration(
                            labelText: widget.hintText,
                            border: OutlineInputBorder(),
                            hintText: widget.hintText,
                          ),
                          readOnly: true,
                          onTap: (){
                            widget.textEditingController.text = "";
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