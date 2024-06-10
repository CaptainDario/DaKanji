// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_size_text/auto_size_text.dart';
import 'package:reorderables/reorderables.dart';

// Project imports:
import 'package:da_kanji_mobile/globals.dart';

/// Widget that shows reorderable and selectable chips
class ResponsiveFilterChips extends StatefulWidget {

  /// Function that defines how the chip at `index` should look like
  final Widget Function(int index) chipWidget;
  /// Function that should determine if the chip at `index` is selected
  final bool Function(int index) selected;
  /// Number of chips in this widget
  final int numChips;
  /// Text that describes the chips (shown above the actual chips)
  final String? description;
  /// Function that is called when user taps on a filter chip
  final void Function(bool selected, int index)? onFilterChipTap;
  /// Function that is called when user taps on a filter chip
  final void Function(int oldIndex, int newIndex)? onReorder;

  const ResponsiveFilterChips(
    {
      required this.chipWidget,
      required this.selected,
      required this.numChips,
      this.description,
      this.onFilterChipTap,
      this.onReorder,
      super.key
    }
  );

  @override
  State<ResponsiveFilterChips> createState() => _ResponsiveFilterChipsState();
}

class _ResponsiveFilterChipsState extends State<ResponsiveFilterChips> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if(widget.description != null)
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
            child: Align(
              alignment: Alignment.centerLeft, 
              child: AutoSizeText(
                widget.description!,
                group: g_SettingsAutoSizeGroup,
              )
            ),
          ),
        Align(
          alignment: Alignment.centerLeft,
          child: ReorderableWrap(
            controller: ScrollController(),
            spacing: 8.0,
            runSpacing: 4.0,
            needsLongPressDraggable: false,
            padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
            crossAxisAlignment: WrapCrossAlignment.start,
            alignment: WrapAlignment.start,
            runAlignment: WrapAlignment.start,
            enableReorder: widget.onReorder != null,
            onReorder: (int oldIndex, int newIndex) {
              widget.onReorder?.call(oldIndex, newIndex);
            },
            children: List.generate(
              widget.numChips,
              (index) {
                return FilterChip(
                  onSelected: (selected) {
                    widget.onFilterChipTap?.call(selected, index);
                  },
                  selected: widget.selected(index),
                  label: Builder(
                    builder: (context) {
                      return widget.chipWidget(index);
                    },
                  )
                );
              }
            ),
            
          ),
        ),
      ],
    );
  }
}
