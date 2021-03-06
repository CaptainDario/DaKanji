import 'package:flutter/material.dart';

import 'package:auto_size_text/auto_size_text.dart';

import 'package:da_kanji_mobile/globals.dart';



class SettingsAutoSizeText extends StatefulWidget {
  SettingsAutoSizeText(
    {
      required this.text,
      this.maxLines,
      Key? key
    }
  ) : super(key: key);

  final String text;

  final int? maxLines;



  @override
  State<SettingsAutoSizeText> createState() => _SettingsAutoSizeTextState();
}

class _SettingsAutoSizeTextState extends State<SettingsAutoSizeText> {
  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      widget.text,
      minFontSize: GlobalMinFontSize,
      overflow: TextOverflow.ellipsis,
      //group: settingsAutoSizeGroup,
      maxLines: widget.maxLines,

    );
  }
}