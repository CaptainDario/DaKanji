import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

Future<Color?> showColorPickerDialog(BuildContext context, Color currentIconColor) async {

  Color tempColor = currentIconColor;

  return showDialog<Color>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Pick a color'),
        content: SingleChildScrollView(
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return ColorPicker(
                pickerColor: tempColor,
                enableAlpha: false,
                onColorChanged: (Color color) {
                  setState(() => tempColor = color);
                },
              );
            },
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              // Return null if canceled
              Navigator.of(context).pop(null);
            },
          ),
          ElevatedButton(
            child: const Text('Ok'),
            onPressed: () {
              // Return the selected color
              Navigator.of(context).pop(tempColor);
            },
          ),
        ],
      );
    },
  );
}