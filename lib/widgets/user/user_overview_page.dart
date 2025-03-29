import 'package:da_kanji_mobile/widgets/user/activity_chart.dart';
import 'package:flutter/material.dart';



class UserOverviewPage extends StatefulWidget {
  const UserOverviewPage({super.key});

  @override
  State<UserOverviewPage> createState() => _UserOverviewPageState();
}

class _UserOverviewPageState extends State<UserOverviewPage> {
  @override
  Widget build(BuildContext context) {

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text("You have a ${25} day streak, you are on fire!")
            ),
            SizedBox(height: 10,),
            ActivityChart()
          ]),
      ),
    );
  
  }
}