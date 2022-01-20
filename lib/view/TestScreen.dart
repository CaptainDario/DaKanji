import 'package:da_kanji_mobile/view/FoldingWidget.dart';
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
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.play_arrow),
        onPressed: () => foldingKey.currentState?.toggleFold(),
      ),
      body: 
        Center(
          child: FoldingWidget(
            // outer widget
            Container(
              color: Colors.green,
              child: Icon(Icons.brush_outlined),
            ),
            SizedBox(
              width: 400,
              height: 400,
              child: 
              Container(
                color: Colors.black,
                child: Image( image: AssetImage("media/icon.png"),
                ),
              ),
            ),
            foldingKey, 400, 400,
            foldingColor: Colors.green,
            onClose: () {
              print("close");
            },
            onOpen: () {
              print("open");
            },
          ),
        ),

    );
  }
}
