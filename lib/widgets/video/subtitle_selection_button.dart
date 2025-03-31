// Copyright 2020 Sarbagya Dhaubanjar. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';



/// A widget to display playback speed changing button.
class SubtitleSelectionButton extends StatefulWidget {

  /// List of subtitle languages
  final List<String> languages;

  final Function(String)? onChanged;
  


  /// Creates [SubtitleSelectionButton] widget.
  const SubtitleSelectionButton({
    required this.languages,
    this.onChanged,
    super.key,
  });


  @override
  State<SubtitleSelectionButton> createState() => _SubtitleSelectionButtonState();
}

class _SubtitleSelectionButtonState extends State<SubtitleSelectionButton> {

  /// All languages that can be selected
  late List<String> languages = widget.languages + ["Off"];
  /// The currently selected language
  late String currentSelection = languages.last;


  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: (value) {
        currentSelection = value;
        widget.onChanged?.call(value);
      },
      tooltip: 'Select subtitle',
      itemBuilder: (context) => List.generate(languages.length, (index) {
        return _popUpItem(languages[index]);
      },),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Icon(currentSelection == languages.last
          ? Icons.subtitles_off
          : Icons.subtitles),
      ),
    );
  }

  PopupMenuEntry<String> _popUpItem(String text) {
    return CheckedPopupMenuItem(
      checked: currentSelection == text,
      value: text,
      child: Text(text),
    );
  }
}
