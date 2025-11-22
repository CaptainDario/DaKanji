import 'package:da_kanji_mobile/globals.dart';
import 'package:flutter/material.dart';



class DaKanjiLogoText extends StatelessWidget {
  
  final double fontSize;

  const DaKanjiLogoText(
    {
      this.fontSize = 80,
      super.key,
    }
  );

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(0, fontSize * 0.08),
      child: RichText(
        text: TextSpan(
          text: '',
          style: TextStyle(
            color: g_Dakanji_red,
            height: 1.2,
            fontFamily: "theater"
          ),
          children: <TextSpan>[
            TextSpan(
              text: 'D', 
              style: TextStyle(fontSize: fontSize,),
            ),
            TextSpan(
              text: 'a',
              style: TextStyle(fontSize: fontSize*0.75,),
            ),
            TextSpan(
              text: 'K', 
              style: TextStyle(fontSize: fontSize,),
            ),
            TextSpan(
              text: 'anji',
              style: TextStyle(fontSize: fontSize*0.75,),
            ),
            TextSpan(
              text: "  v$g_Version",
              style: TextStyle(
                fontSize: fontSize*0.3,
                color: Colors.grey,              ),
            )
          ],
        ),
      ),
    );
  }
}