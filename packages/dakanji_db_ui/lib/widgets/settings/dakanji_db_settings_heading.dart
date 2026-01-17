import 'package:flutter/material.dart';



class DakanjiDbSettingsHeading extends StatelessWidget {
  
  final String title;
  
  const DakanjiDbSettingsHeading(
    this.title,
    {
      super.key
    }
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Text(
        title,
        style: Theme.of(context).textTheme.headlineSmall
      ),
    );
  }
}