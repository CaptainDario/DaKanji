// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_size_text/auto_size_text.dart';

class ResponsiveCheckBoxTile extends StatefulWidget {
  const ResponsiveCheckBoxTile(
    {
      required this.text,
      required this.value,
      this.leadingIcon,
      this.infoText,
      this.autoSizeGroup,
      this.onTileTapped,
      this.onLeadingIconPressed,
      Key? key
    }
  ) : super(key: key);

  /// leading text
  final String text;
  /// the current value of the checkbox
  final bool value;
  /// the icon for the button to press
  final IconData? leadingIcon;
  /// when set to a value shows a leading info icon and when the user presses
  /// this icon a info dialog will open
  final String? infoText;
  /// The autoSizeGroup to use for the text
  final AutoSizeGroup? autoSizeGroup;
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
                child: Container(
                  height: (tileHeight*0.75),
                  alignment: Alignment.centerLeft,
                  child: AutoSizeText(
                    widget.text,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.start,
                    maxLines: 2,
                    group: widget.autoSizeGroup
                  )
                ),
              ),
              Checkbox(
                value: widget.value,
                fillColor: widget.onTileTapped == null
                  ? null
                  : MaterialStateProperty.all(Theme.of(context).highlightColor),
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
