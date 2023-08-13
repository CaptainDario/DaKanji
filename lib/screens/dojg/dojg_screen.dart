import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import 'package:da_kanji_mobile/data/screens.dart';
import 'package:da_kanji_mobile/widgets/drawer/drawer.dart';
import 'package:da_kanji_mobile/widgets/dojg/dojg_widget.dart';



class DoJGScreen extends StatefulWidget {
  const DoJGScreen({super.key});

  @override
  State<DoJGScreen> createState() => _DoJGScreenState();
}

class _DoJGScreenState extends State<DoJGScreen> {

  /// has the DoJG deck been imported?
  bool dojgImported = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DaKanjiDrawer(
      currentScreen: Screens.dojg,
      child: dojgImported
        ? DoJGWidget()
        : GestureDetector(
          onTap: () {
            setState(() {
              dojgImported = true;
            });
          },
          child: Container(
            constraints: BoxConstraints.expand(),
            //color: Colors.amber,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.add_circle_outline),
                SizedBox(width: 10.0),
                Text("Tap to import DoJG Deck")
              ],
            ),
          ),
        ),
    );
  }
}