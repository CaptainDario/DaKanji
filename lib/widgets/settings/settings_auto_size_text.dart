// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_size_text/auto_size_text.dart';

// Project imports:
import 'package:da_kanji_mobile/globals.dart';

class SettingsAutoSizeText extends StatefulWidget {
  const SettingsAutoSizeText(
    {
      required this.text,
      this.maxLines,
      super.key
    }
  );

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
      minFontSize: g_MinFontSize,
      overflow: TextOverflow.ellipsis,
      //group: globalSettingsAutoSizeGroup,
      maxLines: widget.maxLines,

    );
  }
}
