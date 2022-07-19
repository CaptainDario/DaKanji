import 'package:flutter/material.dart';
import 'dart:math';

import 'package:ruby_text/ruby_text.dart';
import 'package:kagome_dart/kagome_dart.dart';



class TextWidget extends StatelessWidget {
  TextWidget(
    { 
      required List<String> this.texts,
      required List<String> this.rubys,
      required double this.width,
      required double this.height,
      Key? key
    }
  ) : super(key: key);
  
  final List<String> texts;
  final List<String> rubys;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {

    return Card(
      child: Container(
        width: width,
        height: height,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: [
              Positioned(
                child: RubyText(
                  List.generate(
                    texts.length, 
                    (index) => RubyTextData(
                      texts[index],
                      ruby: rubys[index],
                    )
                  ),
                  maxLines: null,
                  style: TextStyle(
                    fontSize: 20
                  ),
                ),
              ),
              Positioned(
                height: 1,
                width: width,
                bottom: 25 + 24,
                child: Divider(),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      iconSize: 25,
                      padding: EdgeInsets.zero,
                      onPressed: () => print("Disable furigana"), 
                      icon: Icon(Icons.disabled_by_default_outlined)
                    ),
                    IconButton(
                      iconSize: 25,
                      padding: EdgeInsets.zero,
                      onPressed: () => print("Make full screen"), 
                      icon: Icon(Icons.fullscreen)
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      )
    );

  }
}
