import 'package:flutter/material.dart';



class SearchProfileSettingsToggleListTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  const SearchProfileSettingsToggleListTile({
    super.key,
    required this.title,
    this.subtitle,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: subtitle != null 
        ? Text(subtitle!, style: const TextStyle(fontSize: 12))
        : null,
      value: value,
      onChanged: onChanged,
    );
  }
}