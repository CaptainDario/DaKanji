// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_size_text/auto_size_text.dart';

class ResponsiveHeaderTile extends StatelessWidget {
  const ResponsiveHeaderTile(
    this.text,
    this.icon,
    {
      this.autoSizeGroup,
      Key? key
    }
  ) : super(key: key);

  /// the text of the heading
  final String text;
  /// the auto
  final AutoSizeGroup? autoSizeGroup;
  /// the icon to display
  final IconData icon;

  @override
  Widget build(BuildContext context) {

    double screenHeight = MediaQuery.of(context).size.height;
    double tileHeight = (screenHeight * 0.1).clamp(0, 60);
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      height: tileHeight,
      width: screenWidth,
      alignment: Alignment.centerLeft,
      child: SizedBox(
        height: tileHeight*0.5,
        child: FittedBox(
          child: Row(
            children: [
              Icon(
                this.icon,
                size: tileHeight*0.3,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                text,
                overflow: TextOverflow.ellipsis,
                textScaleFactor: 1.25,
                maxLines: 1,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
