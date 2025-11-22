import 'package:da_kanji_mobile/core/widgets/dakanji/dakanji_logo_text.dart';
import 'package:da_kanji_mobile/globals.dart';
import 'package:flutter/material.dart';



class DakanjiLogoWidget extends StatelessWidget {

  final double size;

  const DakanjiLogoWidget(
    {
      this.size = 1,
      super.key
    }
  );

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Row(
        //crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/dakanji/icon.png",
            height: 36*size,
          ),
          DaKanjiLogoText(fontSize: 40*size,),
        ],
      ),
    );
  }
}