import 'package:flutter/material.dart';

import 'package:auto_size_text/auto_size_text.dart';

import 'package:da_kanji_mobile/globals.dart';



class ResponsiveInputFieldTile extends StatefulWidget {
  ResponsiveInputFieldTile(
    {
      required this.enabled,
      required this.icon,
      this.text,
      this.onChanged,
      this.onButtonPressed,
      this.hintText,
      Key? key
    }
  ) : super(key: key);

  /// Is the Inputfield enabled
  final bool enabled;
  /// the icon for the button to press
  final IconData icon;
  // leading text
  final String? text;
  /// callback which will be executed at every input change
  final Function (String value)? onChanged;
  /// callback which will be execute when the icon button on the side is pressed
  final Function? onButtonPressed;
  /// the hint text to show when nothing was inputted
  final String? hintText;

  @override
  State<ResponsiveInputFieldTile> createState() => _ResponsiveInputFieldTileState();
}

class _ResponsiveInputFieldTileState extends State<ResponsiveInputFieldTile> {



  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;
    double tileHeight = (height * 0.1).clamp(0, 45);
    double width = MediaQuery.of(context).size.width;

    return Material(
      child: InkWell(
        onTap: () {
        },
        child: Container(
          height: tileHeight,
          width: width,
          child: Row(
            children: [
              Expanded(
                child: Container(
                  height: (tileHeight*0.75),
                  child: TextField(
                    enabled: widget.enabled,
                    textAlignVertical: TextAlignVertical.bottom,
                    decoration: InputDecoration(
                      labelText: widget.text,
                      border: OutlineInputBorder(),
                      hintText: widget.hintText,
                    ),
                    onChanged: (value) {
                      if(widget.onChanged != null)
                        widget.onChanged!(value);
                    },
                  )
                ),
              ),
              SizedBox(width: width*0.05,),
              Center(
                child: Container(
                  height: tileHeight*0.75,
                  child: FittedBox(
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          if(widget.onButtonPressed != null) widget.onButtonPressed!();
                        });
                      },
                      icon: Icon(
                        widget.icon,
                      )
                    ),
                  ),
                ),
              ),
            ]
          ),
        ),
      ),
    );
  }
}