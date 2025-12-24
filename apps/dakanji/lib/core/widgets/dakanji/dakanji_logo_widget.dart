import 'package:da_kanji_mobile/core/widgets/dakanji/dakanji_logo_text.dart';
import 'package:flutter/material.dart';



class DakanjiLogoWidget extends StatelessWidget {

  /// The size multiplier for the logo
  final double size;
  /// If true, show the version text below the logo
  final bool showVersion;
  /// If true, use a column layout instead of a row
  final bool useColumn;

  const DakanjiLogoWidget(
    {
      this.size = 1,
      this.showVersion = false,
      this.useColumn = false,
      super.key
    }
  );

  @override
  Widget build(BuildContext context) {

    final children = [
      Image.asset(
        "assets/images/dakanji/icon.png",
        height: (!useColumn ? 36 : 72)*size,
      ),
      SizedBox(width: 8),
      DaKanjiLogoText(
        fontSize: 40*size,
        showVersion: showVersion,
      ),
    ];

    return !useColumn  
      ? Row(
        children: children,
      )
      : Column(
        children: children, 
      );
  }
}