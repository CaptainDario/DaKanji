import 'package:flutter/material.dart';



class TestScreen extends StatefulWidget {
  TestScreen();

  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text("TestScreen"),),
      body: Center(child: Text("test"))
    );
  }
}
