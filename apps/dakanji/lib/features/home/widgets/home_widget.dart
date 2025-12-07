
import 'package:da_kanji_mobile/features/home/widgets/account/user_login_or_widget.dart';
import 'package:da_kanji_mobile/features/home/widgets/home_overview_page.dart';
import 'package:da_kanji_mobile/features/home/widgets/account/user_account_page.dart';
import 'package:flutter/material.dart';



class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
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
                        HomeOverviewPage(),
                        Container(height: 50,),
                        UserLoginOrWidget(UserAccountPage()),
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