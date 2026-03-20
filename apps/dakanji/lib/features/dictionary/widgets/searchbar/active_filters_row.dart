import 'package:da_kanji_mobile/features/dictionary/widgets/searchbar/animated_filter_chip.dart';
import 'package:flutter/material.dart';



class ActiveFiltersRow extends StatelessWidget {
  final List<String> activeFilters;
  final ValueChanged<String> onDeleted;

  const ActiveFiltersRow({
    super.key,
    required this.activeFilters,
    required this.onDeleted,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 4,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        ...activeFilters.map((filter) => AnimatedFilterChip(
          filter: filter,
          onDeleted: () => onDeleted(filter),
        )),
      ],
    );
  }
}