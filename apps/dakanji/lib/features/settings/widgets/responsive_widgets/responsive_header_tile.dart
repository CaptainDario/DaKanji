// Flutter imports:
import 'package:flutter/material.dart';

/// A settings header tile that can be expanded to show settings
class ResponsiveHeaderTile extends StatelessWidget {
  const ResponsiveHeaderTile(
    this.text,
    this.icon,
    {
      required this.children,
      super.key
    }
  );

  /// the text of the heading
  final String text;
  /// A list of child widgets when this
  final List<Widget> children;
  /// the icon to display
  final IconData icon;
  

  @override
  Widget build(BuildContext context) {

    double screenHeight = MediaQuery.of(context).size.height;
    double tileHeight = (screenHeight * 0.1).clamp(0, 60);
    double screenWidth = MediaQuery.of(context).size.width;

    return ExpansionTile(
      childrenPadding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
      title: Container(
        height: tileHeight,
        width: screenWidth,
        alignment: Alignment.centerLeft,
        child: SizedBox(
          height: tileHeight*0.5,
          child: FittedBox(
            child: Row(
              children: [
                Icon(
                  icon,
                  size: tileHeight*0.3,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  text,
                  overflow: TextOverflow.ellipsis,
                  textScaler: const TextScaler.linear(1.25),
                  maxLines: 1,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      children: children,
    );
  }
}
