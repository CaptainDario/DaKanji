import 'package:flutter/material.dart';



class ScreenWelcomeOverlay extends StatelessWidget {

  const ScreenWelcomeOverlay(
    this.titleText,
    this.text,
    this.smallText,
    {Key? key}
  ) : super(key: key);

  /// The title text
  final String titleText;
  ///
  final String text;
  /// 
  final String smallText;



  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, 
      height: double.infinity,
      color: Colors.transparent,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // TITLE
            Text(
              titleText,
              textScaleFactor: 2,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white
              ),
            ),
            // TEXT
            Text(
              text,
              textScaleFactor: 1.5,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white
              ),
            ),
            // SMALL TEXT
            Container(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                child: Text(
                  smallText,
                  textScaleFactor: 1.0,
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    color: Colors.grey
                  ),
                ),
              ),
            )
          ]
        ),
      ),
    );
  }
}