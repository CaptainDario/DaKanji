
import 'package:da_kanji_mobile/widgets/user/user_overview_page.dart';
import 'package:da_kanji_mobile/widgets/user/user_account_page.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';



class User extends StatefulWidget {
  const User({super.key});

  @override
  State<User> createState() => _UserState();
}

class _UserState extends State<User> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
      child: Column(
        children: [
          const SizedBox(height: 0,),
          DefaultTabController(
            length: 3,
            child: Expanded(
              child: Column(
                children: [
                  TabBar(
                    labelColor: Theme.of(context).highlightColor,
                    unselectedLabelColor: Colors.grey,
                    indicatorColor: Theme.of(context).highlightColor,
                    tabs: [
                      Tab(
                        child: Text("Overview")
                      ),
                      Tab(
                        child: Text("Statistics")
                      ),
                      Tab(
                        child: Text("Account")
                      ),
                    ]
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        UserOverviewPage(),
                        Container(height: 50,),
                        UserAccountPage(Supabase.instance.client),
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