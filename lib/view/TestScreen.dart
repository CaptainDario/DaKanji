import 'package:da_kanji_mobile/view/FoldingWidget.dart';
import 'package:da_kanji_mobile/view/drawing/DrawScreen.dart';
import 'package:flutter/material.dart';


class TestScreen extends StatefulWidget {
  TestScreen();

  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {

  GlobalKey<FoldingWidgetState> foldingKey = 
    new GlobalKey<FoldingWidgetState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("TestScreen"),),
      body: Row(
        children: [
          Container(
            width: MediaQuery.of(context).size.width/2,
            height: MediaQuery.of(context).size.height,
            child: DrawScreen(false)
          ),
          Container(
            width: MediaQuery.of(context).size.width/2,
            height: MediaQuery.of(context).size.height,
            child: DrawScreen(false)
          )
        ],
      ) 
    );
  }
}
