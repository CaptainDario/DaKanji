import 'package:flutter/material.dart';


class DictionaryScreenExampleTab extends StatefulWidget {
  DictionaryScreenExampleTab({Key? key}) : super(key: key);

  @override
  State<DictionaryScreenExampleTab> createState() => _DictionaryScreenExampleTabState();
}

class _DictionaryScreenExampleTabState extends State<DictionaryScreenExampleTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.orange,
      child: Text("Example")
    );
  }
}