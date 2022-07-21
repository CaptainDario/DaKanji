import 'package:flutter/material.dart';

import 'package:ruby_text/ruby_text.dart';



class TextWidget extends StatelessWidget {
  TextWidget(
    { 
      required List<String> this.texts,
      required List<String> this.rubys,
      required bool this.showFurigana,
      required bool this.addSpaces,
      Key? key
    }
  ) : super(key: key);
  
  final List<String> texts;
  final List<String> rubys;
  final bool showFurigana;
  final bool addSpaces;

  @override
  Widget build(BuildContext context) {

    return RubyText(
      () {
        List<RubyTextData> ret = [];
        
        for (var i = 0; i < texts.length; i++) {
          ret.add(
            RubyTextData(
              texts[i],
              ruby: showFurigana ? 
                rubys[i] : null,
            )
          );
          if(addSpaces)
            ret.add(RubyTextData("  "));
        }
        return ret;
      } (),
      
      maxLines: null,
      style: TextStyle(
        fontSize: 20,
        height: 1.5
      ),
    );

  }
}
