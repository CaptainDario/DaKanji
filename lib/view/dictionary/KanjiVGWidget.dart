import 'dart:math';

import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:xml/xml.dart';



class KanjiVGWidget extends StatefulWidget {
  KanjiVGWidget(
    this.kanjiVGString,
    this.height,
    this.width,
    {Key? key}
  ) : super(key: key);

  /// String containing a KanjiVG entry
  final String kanjiVGString;
  /// height of this widget
  final double height;
  /// width of this widget
  final double width;

  @override
  State<KanjiVGWidget> createState() => _KanjiVGWidgetState();
}

class _KanjiVGWidgetState extends State<KanjiVGWidget> {

  String tmp = '';

  @override
  void initState() {
    
    

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    tmp = colorizeKanjiVG(widget.kanjiVGString);

    return Container(
      height: widget.height,
      width: widget.width,
      child: SvgPicture.string(
        tmp
      ),
    );
  }

  /// Changes the colors of the strokes and text of the given `kanjiVGEntry`
  /// and returns it.
  String colorizeKanjiVG (String kanjiVGEntry) {

    // convert the KanjiVG entry to a Xml doc
    final document = XmlDocument.parse(kanjiVGEntry);

    //iterate over the strokes
    int cnt = 0, cntInc = 13;
    for (var element in document.findAllElements("path")) {
      element.setAttribute("stroke", "hsl($cnt, 100%, 50%)");

      cnt += cntInc;
      if(cnt > 360) cnt = 0;
    }

    // iterate over the texts
    cnt = 0;
    for (var element in document.findAllElements("text")) {
      element.setAttribute("stroke", "hsl($cnt, 100%, 50%)");

      cnt += cntInc;
      if(cnt > 360) cnt = 0;
    }

    return document.toString();
  }
}