import 'package:flutter/material.dart';

import 'package:da_kanji_mobile/domain/dojg/dojg_entry.dart';
import 'package:da_kanji_mobile/domain/isar/isars.dart';
import 'package:da_kanji_mobile/widgets/dojg/dojg_entry_card.dart';
import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';



class DojgEntryList extends StatefulWidget {

  const DojgEntryList(
    {
      super.key
    }
  );

  @override
  State<DojgEntryList> createState() => _DojgEntryListState();
}

class _DojgEntryListState extends State<DojgEntryList> {

  List<DojgEntry> currentEntries = [];

  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant DojgEntryList oldWidget) {
    init();
    super.didUpdateWidget(oldWidget);
  }

  void init() {
    currentEntries = GetIt.I<Isars>().dojg!.dojgEntrys.where()
      .anyId()
      .findAllSync()
    ..sort(((a, b) => a.grammaticalConcept.compareTo(b.grammaticalConcept)));
  }


  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: CustomScrollView(
        //padding: EdgeInsets.all(8.0),
        slivers: <Widget>[
          SliverAppBar(
            title: Text("test"),
            floating: true,
          ),
          SliverList.separated(
            itemCount: currentEntries.length,
            separatorBuilder: (context, i) {
              if(i < currentEntries.length && currentEntries[i].grammaticalConcept.split("")[0] !=
                currentEntries[i+1].grammaticalConcept.split("")[0])
                return Text("${currentEntries[i+1].grammaticalConcept.split("")[0]}");
              else
                return SizedBox();
            },
            itemBuilder: (context, i) {
              return DojgEntryCard(currentEntries[i]);
            }
          )
            
        ],
      ),
    );
  }
}