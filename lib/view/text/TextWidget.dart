import 'package:flutter/material.dart';

import 'package:ruby_text/ruby_text.dart';
import 'package:mecab_dart/mecab_dart.dart';



class TextWidget extends StatefulWidget {
  TextWidget({Key? key}) : super(key: key);

  final TextEditingController inputController = TextEditingController();

  @override
  State<TextWidget> createState() => _TextWidgetState();
}

class _TextWidgetState extends State<TextWidget> {

  // mecab tagger
  Mecab tagger = new Mecab();

  @override
  void initState() {
    tagger.init("assets/ipadic", true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          children: [
            Card(
              child: Container(
                width: constraints.maxWidth,
                height: constraints.maxHeight/2-8,
                child: TextField(
                  controller: widget.inputController,
                  maxLines: null,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                  onChanged: ((value) {
                    print(value);
                    setState(() { });
                  }),
                )
              ),
            ),
            Card(
              child: Container(
                width: constraints.maxWidth,
                height: constraints.maxHeight/2-8,
                child: RubyText(
                  [
                    RubyTextData(
                      widget.inputController.text
                    )
                  ],
                  style: TextStyle(
                    fontSize: 20
                  ),
                  maxLines: null,
                  textAlign: TextAlign.left,
                  textDirection: TextDirection.ltr,
                )
              ),
            ),
          ],
        );
      },
    );
  }
}