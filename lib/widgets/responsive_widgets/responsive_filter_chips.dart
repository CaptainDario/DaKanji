// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:reorderables/reorderables.dart';

// Project imports:

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
  /// A widget that describes the chips in more detail (popup button) 
  final Widget? detailedDescription;
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
      this.detailedDescription,
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
        if(widget.description != null || widget.detailedDescription != null)
          SizedBox(
            width: MediaQuery.sizeOf(context).width,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                if(widget.detailedDescription != null)
                  IconButton(
                    icon: const Icon(Icons.info_outline),
                    onPressed: () async {
                      await AwesomeDialog(
                        context: context,
                        dialogType: DialogType.noHeader,
                        body: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: widget.detailedDescription,
                        )
                      ).show();
                    },
                  ),
                if(widget.description != null)
                  Flexible(
                    child: Text(
                      widget.description!,
                    ),
                  ),
              ],
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
