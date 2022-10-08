import 'package:da_kanji_mobile/globals.dart';
import 'package:flutter/material.dart';

import 'package:auto_size_text/auto_size_text.dart';



class ResponsiveCheckBoxTile extends StatefulWidget {
  const ResponsiveCheckBoxTile(
    {
      required this.text,
      required this.value,
      this.onTileTapped,
      Key? key
    }
  ) : super(key: key);

  /// leading text
  final String text;
  /// the current value of the checkbox
  final bool value;
  /// callback which will be executed by in every tap
  final Function (bool value)? onTileTapped;

  @override
  State<ResponsiveCheckBoxTile> createState() => _ResponsiveCheckBoxTileState();
}

class _ResponsiveCheckBoxTileState extends State<ResponsiveCheckBoxTile> {


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
            if(widget.onTileTapped != null) widget.onTileTapped!(checked);
          });
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
                    group: settingsAutoSizeGroup
                  )
                ),
              ),
              Checkbox(
                value: widget.value,
                onChanged: (value){
                  setState(() {
                    if(value != null) {
                      checked = value;
                    }

                    if(widget.onTileTapped != null) widget.onTileTapped!(checked);
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