// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:da_kanji_mobile/globals.dart';
import 'package:da_kanji_mobile/widgets/widgets/da_kanji_loading_indicator.dart';

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
          color: Theme.of(context).scaffoldBackgroundColor,
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
              const SizedBox(height: 20, width: 1,),
              const DaKanjiLoadingIndicator(),
              if(text != null)
                ...[
                  SizedBox(height: 8,),
                  Text(
                    text!,
                    style: TextStyle(
                      fontSize: 20,
                      color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black
                    ),
                  ),
                ]
            ],
          ),
        ),
      ),
    );
  }
}
