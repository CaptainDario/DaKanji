import 'package:flutter/material.dart';



class DakanjiDbSettingsCardAddButton extends StatelessWidget {

  final String text;

  final VoidCallback? onPressed;

  const DakanjiDbSettingsCardAddButton(
    this.text,
    this.onPressed,
    {
      super.key
    }
  );

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias, 
      child: OutlinedButton.icon(
        onPressed: onPressed,
        icon: const Icon(Icons.add),
        label: Text(text),
        style: OutlinedButton.styleFrom(
          side: BorderSide.none, 
          minimumSize: const Size.fromHeight(52),
          alignment: Alignment.center,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
      ),
    );
  }
}