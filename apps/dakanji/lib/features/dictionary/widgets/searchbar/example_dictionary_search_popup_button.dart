import 'package:flutter/material.dart';



class ExampleDictionarySearchPopupButton extends StatelessWidget {
  
  final List<String> exampleTerms;
  final Function(String)? onSelected;

  const ExampleDictionarySearchPopupButton({
    super.key,
    required this.exampleTerms,
    this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      // A little bug icon so it's obviously a dev tool
      icon: const Icon(Icons.list_alt, color: Colors.grey), 
      tooltip: 'Dev: Example Searches',
      onSelected: (String term) async {
        onSelected?.call(term);
      },
      itemBuilder: (BuildContext context) {
        return exampleTerms.map((term) {
          return PopupMenuItem<String>(
            value: term,
            child: Text(term),
          );
        }).toList();
      },
    );
  }
}