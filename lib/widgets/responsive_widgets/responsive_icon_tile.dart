// Flutter imports:
import 'package:flutter/material.dart';


class ResponsiveIconTile extends StatefulWidget {

  /// leading text
  final String text;
  /// the icon for this tile
  final Icon icon;
  /// callback that is executed when the user presses on the tile
  final Function? onTilePressed;


  const ResponsiveIconTile(
    {
      required this.text,
      required this.icon,
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
        child: Container(
          constraints: BoxConstraints(
            minHeight: tileHeight
          ),
          width: width,
          child: Row(
            children: [
              Expanded(
                child: Text(
                  widget.text,
                  textAlign: TextAlign.start,
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
