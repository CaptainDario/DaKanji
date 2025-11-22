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
    // TODO use user name
    greeting += "$userNameさん！";

    return Text(
      greeting,
      style: Theme.of(context).textTheme.headlineSmall,
    );

  }
}