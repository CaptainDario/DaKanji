import 'package:da_kanji_mobile/globals.dart';
import 'package:flutter/material.dart';
import 'package:da_kanji_mobile/model/dark_theme.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';



class DaKanjiSplash extends StatelessWidget {

  /// The text to show under the loading spinner
  final String? text;

  const DaKanjiSplash(
    {
      this.text,
      super.key
    }
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          color: darkTheme.cardColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RichText(
                text: TextSpan(
                  text: '',
                  style: TextStyle(
                    color: g_Dakanji_red,
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
              ),
              const SizedBox(height: 20,),
              const SpinKitSpinningLines(
                color: g_Dakanji_green,
                lineWidth: 3,
                size: 30.0,
                itemCount: 10,
              ),
              if(text != null)
                Text(
                  text!,
                  style: const TextStyle(
                    color: g_Dakanji_green,
                    fontSize: 20,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}