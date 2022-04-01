import 'package:flutter/material.dart';



class SettingsTileHeader extends StatelessWidget {
  const SettingsTileHeader(
    this.text,
    {Key? key}
  ) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        this.text,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18
        ),
      ),
    );
  }
}