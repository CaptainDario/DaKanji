import 'package:flutter/material.dart';



class FilterSuggestionTile extends StatelessWidget {
  final String filterKey;
  final String prefix;
  final String description;
  final IconData icon;
  final SearchController controller;
  final VoidCallback onSelected;

  const FilterSuggestionTile({
    super.key,
    required this.filterKey,
    required this.prefix,
    required this.description,
    required this.icon,
    required this.controller,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    // Wrap the tile in a Material widget so the splash is linked to THIS widget
    return Material(
      // Make the background transparent so only the splash is visible
      color: Colors.transparent,
      child: ListTile(
        leading: Icon(icon),
        title: Text(filterKey),
        subtitle: Text(description),
        onTap: () {
          final segments = controller.text.split(' ');
          segments.removeLast(); 
          controller.text = segments.join(' ') + (segments.isNotEmpty ? ' ' : '');
          controller.selection = TextSelection.collapsed(offset: controller.text.length);
          onSelected();
        },
      ),
    );
  }
}