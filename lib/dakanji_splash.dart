import 'package:flutter/material.dart';
import 'package:da_kanji_mobile/model/dark_theme.dart';



class DaKanjiSplash extends StatelessWidget {
  const DaKanjiSplash({super.key});

  @override
  Widget build(BuildContext context) {
    return     MaterialApp(
      home: Container(
        color: darkTheme.cardColor,
        child: Center(
          child: RichText(
            text: TextSpan(
              text: '',
              style: TextStyle(
                color: darkTheme.highlightColor,
                fontFamily: "theater"
              ),
              children: const <TextSpan>[
                TextSpan(
                  text: 'D', 
                  style: TextStyle(fontSize: 80,),
                ),
                TextSpan(
                  text: 'a',
                  style: TextStyle(fontSize: 60,),
                ),
                TextSpan(
                  text: 'K', 
                  style: TextStyle(fontSize: 80,),
                ),
                TextSpan(
                  text: 'anji',
                  style: TextStyle(fontSize: 60,),
                ),
              ],
            ),
          )
        ),
      ),
    );
  }
}