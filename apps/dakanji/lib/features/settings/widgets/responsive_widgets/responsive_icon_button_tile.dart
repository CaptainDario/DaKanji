// Flutter imports:
import 'package:flutter/material.dart';

class ResponsiveIconButtonTile extends StatefulWidget {

  /// the description of this settings
  final String text;
  /// the icon for the button to press
  final IconData icon;
  /// callback which will be executed by every button press
  final Function? onButtonPressed;


  const ResponsiveIconButtonTile(
    {
      required this.text,
      required this.icon,
      this.onButtonPressed,
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
        onTap: () {},
        child: Container(
          width: width,
          constraints: BoxConstraints(minHeight: tileHeight),
          child: Row(
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  widget.text,
                  textAlign: TextAlign.start,
                ),
              ),
              FittedBox(
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
            ]
          ),
        ),
      ),
    );
  }
}
