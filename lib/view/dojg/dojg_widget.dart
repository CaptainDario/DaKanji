import 'package:flutter/material.dart';



class DoJGWidget extends StatefulWidget {
  const DoJGWidget({super.key});

  @override
  State<DoJGWidget> createState() => _DoJGWidgetState();
}

class _DoJGWidgetState extends State<DoJGWidget> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: ListView(
        padding: EdgeInsets.all(8.0),
        children: [
          Text("DoJG Widget"),
          Text("DoJG Widget"),
          Text("DoJG Widget"),
          Text("DoJG Widget")
        ],
      ),
    );
  }
}