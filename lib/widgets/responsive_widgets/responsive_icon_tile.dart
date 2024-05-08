// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_size_text/auto_size_text.dart';

class ResponsiveIconTile extends StatefulWidget {

  /// leading text
  final String text;
  /// the icon for this tile
  final Icon icon;
  /// The autoSizeGroup to use for the text
  final AutoSizeGroup? autoSizeGroup;
  /// callback that is executed when the user presses on the tile
  final Function? onTilePressed;


  const ResponsiveIconTile(
    {
      required this.text,
      required this.icon,
      this.autoSizeGroup,
      this.onTilePressed,
      super.key
    }
  );


  @override
  State<ResponsiveIconTile> createState() => _ResponsiveIconTileState();
}

class _ResponsiveIconTileState extends State<ResponsiveIconTile> {

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
          widget.onTilePressed?.call();
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
                child: Container(
                  padding: const EdgeInsets.all(8),
                  height: tileHeight*0.75,
                  child: FittedBox(
                    child: widget.icon,
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
