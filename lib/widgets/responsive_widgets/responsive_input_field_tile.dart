import 'package:flutter/material.dart';



class ResponsiveInputFieldTile extends StatefulWidget {
  const ResponsiveInputFieldTile(
    {
      required this.enabled,
      this.leadingIcon,
      this.text,
      this.onChanged,
      this.onLeadingIconPressed,
      this.hintText,
      Key? key
    }
  ) : super(key: key);

  /// Is the Input field enabled
  final bool enabled;
  /// the icon for the button to press
  final IconData? leadingIcon;
  // leading text
  final String? text;
  /// callback which will be executed at every input change
  final Function (String value)? onChanged;
  /// callback which will be execute when the icon button on the side is pressed
  final Function? onLeadingIconPressed;
  /// the hint text to show when nothing was inputted
  final String? hintText;

  @override
  State<ResponsiveInputFieldTile> createState() => _ResponsiveInputFieldTileState();
}

class _ResponsiveInputFieldTileState extends State<ResponsiveInputFieldTile> {

  /// the controller for the input field
  final TextEditingController _controller = TextEditingController();


  @override
  void initState() {
    super.initState();
    if(widget.text != null) {
      _controller.text = widget.text!;
    }
  }

  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;
    double tileHeight = (height * 0.1).clamp(0, 45);
    double width = MediaQuery.of(context).size.width;

    return Material(
      child: InkWell(
        onTap: () {
        },
        child: SizedBox(
          height: tileHeight,
          width: width,
          child: Row(
            children: [
              if(widget.leadingIcon != null)
                Center(
                  child: SizedBox(
                    child: FittedBox(
                      child: IconButton(
                        splashRadius: tileHeight*0.5,
                        onPressed: () {
                          setState(() {
                            if(widget.onLeadingIconPressed != null) widget.onLeadingIconPressed!();
                          });
                        },
                        icon: Icon(
                          widget.leadingIcon,
                        )
                      ),
                    ),
                  ),
                ),
              Expanded(
                child: SizedBox(
                  height: (tileHeight*0.75),
                  child: TextField(
                    controller: _controller,
                    enabled: widget.enabled,
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                      labelText: widget.hintText,
                      border: const OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      if(widget.onChanged != null) {
                        widget.onChanged!(value);
                      }
                    },
                  )
                ),
              ),
              SizedBox(width: width*0.05,),
            ]
          ),
        ),
      ),
    );
  }
}