import 'package:da_db/database/kanji/kanji_bank_v3_entry_stat.dart';
import 'package:flutter/material.dart';


class KanjiMatchStatsWidget extends StatelessWidget {

  final List<KanjiBankV3EntryStat> stats;

  const KanjiMatchStatsWidget(
    this.stats,
    {
      super.key
    }
  );

  @override
  Widget build(BuildContext context) {
    return Table(
      children: [
        for (var stat in stats) 
          TableRow(
            children: [
              Text(
                stat.tag.notes,
                style: TextStyle(color: Colors.grey),
              ),
              Text(stat.value.toString(),),
            ]
          )
      ],
    );
  }
}