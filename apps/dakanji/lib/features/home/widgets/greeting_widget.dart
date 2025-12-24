import 'package:flutter/material.dart';



class GreetingWidget extends StatelessWidget {
  
  final String userName;

  const GreetingWidget(
    this.userName,
    {
      super.key
    }
  );

  @override
  Widget build(BuildContext context) {
    String greeting = "";
    if(TimeOfDay.now().hour < 12) { greeting = "おはよう、"; }
    else if(TimeOfDay.now().hour < 18) { greeting = "こんにちは、"; }
    else { greeting = "こんばんは、";}
    greeting += "$userNameさん！";

    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final style = Theme.of(context).textTheme.headlineSmall!;
          final double minFontSize = 18;
          
          // Create a TextPainter to measure the text at full size
          final textPainter = TextPainter(
            text: TextSpan(text: greeting, style: style),
            textDirection: TextDirection.ltr,
            maxLines: 1,
          );
          
          textPainter.layout(minWidth: 0, maxWidth: double.infinity);
          
          // Check if text fits normally
          if (textPainter.width < constraints.maxWidth) {
            return Text(greeting, style: style);
          } 
          
          // Calculate the scale factor needed to fit the text
          final double scaleFactor = constraints.maxWidth / textPainter.width;
          final double scaledFontSize = style.fontSize! * scaleFactor;

          // If the scaled size is BELOW our minimum, return Ellipsis Text
          if (scaledFontSize < minFontSize) {
            return Text(
              greeting,
              style: style.copyWith(fontSize: minFontSize),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            );
          }

          // Otherwise, return the Scaled Text (using FittedBox logic)
          return FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(
              greeting,
              style: style
            ),
          );
        },
      ),
    );

  }
}