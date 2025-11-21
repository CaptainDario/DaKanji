import 'dart:math';

import 'package:da_kanji_mobile/globals.dart';
import 'package:flutter/material.dart';



class ActivityChart extends StatefulWidget {


  const ActivityChart(
    {
      super.key
    }
  );

  @override
  State<ActivityChart> createState() => _ActivityChartState();
}

class _ActivityChartState extends State<ActivityChart> {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: GridView.count(
        crossAxisCount: (getDaysOfThisYear()~/7)+1,
        mainAxisSpacing: 2,
        crossAxisSpacing: 2,
        children: List.generate(365, (int i) {

          int progress = Random().nextInt(256);

          return Container(
            height: 8,
            width: 8,
            decoration: BoxDecoration(
              color: g_Dakanji_red.withAlpha(progress),
              borderRadius: BorderRadius.circular(2),
              border: Border.all(
                color: progress == 255 ? Colors.white : Colors.transparent,
                width: progress == 255 ? 0.5 : 0,
              ),
            ),
          );
        }),
      ),
    );
  }

  int getDaysOfThisYear(){

    final now = DateTime.now();
    final firstOfTheYear = DateTime(now.year, 1, 1);
    final lastOfTheYear = DateTime(now.year+1, 1, 1);

    final days = lastOfTheYear.difference(firstOfTheYear).inDays;

    return days;

  }

}