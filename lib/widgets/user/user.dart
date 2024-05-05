import 'package:flutter/material.dart';



class User extends StatefulWidget {
  const User({super.key});

  @override
  State<User> createState() => _UserState();
}

class _UserState extends State<User> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 16, 0, 0),
      child: Column(
        children: [
          Text(
            () {
              if(TimeOfDay.now().hour < 12) { return "おはよう！"; }
              else if(TimeOfDay.now().hour < 18) { return "こんにちは！"; }
              else { return "こんばんは！";}
            } (),
            style: const TextStyle(
              fontSize: 30,
              fontFamily: "kouzan"
            ),
          ),
          DefaultTabController(
            length: 2,
            child: Column(
              children: [
                TabBar(
                  tabs: [
                    Text("Sync"),
                    Text("Overview")
                  ]
                ),
                TabBarView(
                  children: [
                    Container(),
                    Container()
                  ]
                )
              ],
            )
          )
        ],
      ),
    );
  }
}