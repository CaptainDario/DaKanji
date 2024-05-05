
import 'package:da_kanji_mobile/widgets/user/user_account.dart';
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
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
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
          ),
          const SizedBox(height: 16,),
          DefaultTabController(
            length: 2,
            child: Expanded(
              child: Column(
                children: [
                  TabBar(
                    labelColor: Theme.of(context).highlightColor,
                    unselectedLabelColor: Colors.grey,
                    indicatorColor: Theme.of(context).highlightColor,
                    tabs: [
                      Tab(
                        child: Text("Sync")
                      ),
                      Tab(
                        child: Text("Overview")
                      )
                    ]
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        UserAccount(),
                        Container(height: 50,)
                      ]
                    ),
                  )
                ],
              ),
            )
          )
        ],
      ),
    );
  }
}