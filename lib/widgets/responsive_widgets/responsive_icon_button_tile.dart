// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_size_text/auto_size_text.dart';

class ResponsiveIconButtonTile extends StatefulWidget {

  /// the description of this settings
  final String text;
  /// the icon for the button to press
  final IconData icon;
  /// callback which will be executed by every button press
  final Function? onButtonPressed;
  /// The autoSizeGroup to use for the text
  final AutoSizeGroup? autoSizeGroup;


  const ResponsiveIconButtonTile(
    {
      required this.text,
      required this.icon,
      this.onButtonPressed,
      this.autoSizeGroup,
      super.key
    }
  );

  @override
  State<ResponsiveIconButtonTile> createState() => _ResponsiveIconButtonTileState();
}

class _ResponsiveIconButtonTileState extends State<ResponsiveIconButtonTile> {



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
              Center(
                child: SizedBox(
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
