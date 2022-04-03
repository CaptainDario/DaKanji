import 'package:auto_size_text/auto_size_text.dart';
import 'package:da_kanji_mobile/globals.dart';
import 'package:flutter/material.dart';



class ResponsiveHeaderTile extends StatelessWidget {
  const ResponsiveHeaderTile(
    this.text,
    {
      this.autoSizeGroup,
      Key? key
    }
  ) : super(key: key);

  /// the text of the heading
  final String text;
  /// the auto
  final AutoSizeGroup? autoSizeGroup;

  @override
  Widget build(BuildContext context) {

    double screenHeight = MediaQuery.of(context).size.height;
    double tileHeight = (screenHeight * 0.1).clamp(0, 60);
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      height: tileHeight,
      width: screenWidth,
      alignment: Alignment.centerLeft,
      child: Container(
        height: tileHeight*0.5,
        child: FittedBox(
          child: Text(
            text,
            overflow: TextOverflow.ellipsis,
            textScaleFactor: 1.25,
            maxLines: 1,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}