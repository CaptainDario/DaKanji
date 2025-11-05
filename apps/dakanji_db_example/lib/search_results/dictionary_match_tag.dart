import 'package:flutter/material.dart';



class DictionaryMatchTag extends StatelessWidget {

  /// The tag's text to display.
  final String name;

  /// The tag's notes to show in a snackbar.
  final String? details;

  /// The tag's color.
  final Color? color;

  const DictionaryMatchTag(this.name, this.details, {this.color, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      /// show snackbar
      onTap: details == null
        ? null
        : () => ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(details!)),
        ),
      child: Chip(
        labelPadding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 0.0),
        padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
        backgroundColor: color,
        label: Text(
          name,
          style: const TextStyle(fontSize: 11),
        ),
      ),
    );
  }
}