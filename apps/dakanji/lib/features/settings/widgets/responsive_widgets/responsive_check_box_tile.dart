// Flutter imports:
import 'package:flutter/material.dart';

class ResponsiveCheckBoxTile extends StatefulWidget {
  const ResponsiveCheckBoxTile(
    {
      required this.text,
      required this.value,
      this.leadingIcon,
      this.onTileTapped,
      this.onLeadingIconPressed,
      super.key
    }
  );

  /// leading text
  final String text;
  /// the current value of the checkbox
  final bool value;
  /// the icon for the button to press
  final IconData? leadingIcon;
  /// callback which will be executed by in every tap
  final Function (bool value)? onTileTapped;
  /// callback which will be execute when the icon button on the side is pressed
  final Function? onLeadingIconPressed;

  @override
  State<ResponsiveCheckBoxTile> createState() => _ResponsiveCheckBoxTileState();
}

class _ResponsiveCheckBoxTileState extends State<ResponsiveCheckBoxTile> {

  /// is the tile checked or not
  bool checked = false;

  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;
    double tileHeight = (height * 0.1).clamp(0, 45);
    double width = MediaQuery.of(context).size.width;

    return Material(
      child: InkWell(
        onTap: () {
          setState(() {
            checked = !checked;
            widget.onTileTapped?.call(checked);
          });
        },
        child: Container(
          width: width,
          constraints: BoxConstraints(minHeight: tileHeight),
          child: Row(
            children: [
              if(widget.leadingIcon != null)
                SizedBox(
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
              Expanded(
                child: Text(
                  widget.text,
                  textAlign: TextAlign.start,
                ),
              ),
              Checkbox(
                value: widget.value,
                fillColor: widget.onTileTapped == null
                  ? null
                  : null,
                onChanged: (value){
                  setState(() {
                    if(value != null) {
                      checked = value;
                    }

                    widget.onTileTapped?.call(checked);
                  });
                },
              ),
            ]
          ),
        ),
      ),
    );
  }
}
