import 'package:flutter/material.dart';

import 'package:ruby_text/ruby_text.dart';



class TextWidget extends StatelessWidget {
  TextWidget(
    { 
      required List<String> this.texts,
      required List<String> this.rubys,
      required bool this.showFurigana,
      Key? key
    }
  ) : super(key: key);
  
  final List<String> texts;
  final List<String> rubys;
  final bool showFurigana;

  @override
  Widget build(BuildContext context) {

    return RubyText(
      List.generate(
        texts.length, 
        (index) => RubyTextData(
          texts[index],
          ruby: showFurigana ? 
            rubys[index] : null,
        )
      ),
      maxLines: null,
      style: TextStyle(
        fontSize: 20
      ),
    );

  }
}
