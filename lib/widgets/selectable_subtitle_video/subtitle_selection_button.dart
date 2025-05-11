// Copyright 2020 Sarbagya Dhaubanjar. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';



/// A widget to display playback speed changing button.
class SubtitleSelectionButton extends StatefulWidget {

  /// List of subtitle names
  final List<String> subtitleNames;

  /// The currently selected subtitle name
  final String currentSubtitleSelection;

  /// Callback that is executed when the selection changed
  final Function(String)? onChanged;
  


  /// Creates [SubtitleSelectionButton] widget.
  const SubtitleSelectionButton({
    required this.subtitleNames,
    required this.currentSubtitleSelection,
    this.onChanged,
    super.key,
  });


  @override
  State<SubtitleSelectionButton> createState() => _SubtitleSelectionButtonState();
}

class _SubtitleSelectionButtonState extends State<SubtitleSelectionButton> {

  /// All languages that can be selected
  late List<String> languages = widget.subtitleNames + ["Off"];


  @override
  void dispose() {
    print("DISPOSED");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: (value) {
        widget.onChanged?.call(value);
      },
      tooltip: 'Select subtitle',
      itemBuilder: (context) => List.generate(languages.length, (index) {
        return _popUpItem(languages[index]);
      },),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Icon(widget.currentSubtitleSelection == languages.last
          ? Icons.subtitles_off
          : Icons.subtitles),
      ),
    );
  }

  PopupMenuEntry<String> _popUpItem(String text) {
    return CheckedPopupMenuItem(
      checked: widget.currentSubtitleSelection == text,
      value: text,
      child: Text(text),
    );
  }
}
