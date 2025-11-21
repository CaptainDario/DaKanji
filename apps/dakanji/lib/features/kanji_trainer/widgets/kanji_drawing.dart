// Dart imports:
import 'dart:ui' as ui;

// Flutter imports:
import 'package:flutter/material.dart';


class KanjiDrawingWidget extends StatefulWidget {
  const KanjiDrawingWidget(
    {
      super.key
    }
  );

  @override
  State<KanjiDrawingWidget> createState() => _KanjiDrawingWidgetState();
}

class _KanjiDrawingWidgetState extends State<KanjiDrawingWidget> {


  ui.Image? brush;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Text("Kanji Drawing");
  
  }
}
