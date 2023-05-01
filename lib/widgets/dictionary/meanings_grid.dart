import 'dart:math';

import 'package:collection/collection.dart';
import 'package:da_kanji_mobile/domain/isar/isars.dart';
import 'package:da_kanji_mobile/domain/navigation_arguments.dart';
import 'package:database_builder/database_builder.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:get_it/get_it.dart';



/// `LayouGrid` structured to show a list of meanings with a count
class MeaningsGrid extends StatefulWidget {
  
  /// The style to be used for the text
  final TextStyle style;
  /// A list of meanings that should be shown
  final LanguageMeanings meanings;
  /// An offset that should used when showing the meanings
  final int countOffset;
  /// A limit of meanings that should be shown in this grid
  final int limit;

  const MeaningsGrid(
    {
      required this.meanings,
      required this.style,
      this.countOffset = 0,
      this.limit = 0,
      super.key
    }
  );

  @override
  State<MeaningsGrid> createState() => _MeaningsGridState();
}

class _MeaningsGridState extends State<MeaningsGrid> {

  /// if there are more than `widet.limit` meanings, should they be shown
  bool showAllMeanings = false;
  /// all related entries
  List<List<JMdict?>?> realtedEntries = [];

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  void didUpdateWidget(covariant MeaningsGrid oldWidget) {
    init();
    super.didUpdateWidget(oldWidget);
  }

  void init(){
    realtedEntries = [];
    
    // get all related entries from ISAR (xref)
    if(widget.meanings.xref != null){
      for (var i = 0; i < widget.meanings.xref!.length; i++) {
        if(widget.meanings.xref![i] != null){
          realtedEntries.add([]);
          for (var j = 0; j < widget.meanings.xref![i]!.attributes.length; j++) {
            realtedEntries[i]!.add(GetIt.I<Isars>().dictionary.jmdict.getSync(
              int.parse(widget.meanings.xref![i]!.attributes[j]!)
            ));
          }
        }
        else{
          realtedEntries.add(null);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    /// the lenght of this meanings table (how many rows)
    int tableLength = showAllMeanings ?
      widget.meanings.meanings!.length : 
      min(widget.meanings.meanings!.length, 5);
    /// should the 'show more'-button be there
    int hide = widget.meanings.meanings!.length > 5 && !showAllMeanings ? 1 : 0;
    
    return AnimatedSize(
      duration: Duration(milliseconds: 500),
      alignment: Alignment.topCenter,
      child: LayoutGrid(
        gridFit: GridFit.loose,
        columnGap: 10,
        rowGap: 5,
        columnSizes: [auto, 0.95.fr],
        rowSizes: List.generate(tableLength + hide, (index) => auto),
        children: () {
          // one meaning row of the table 
          List<Widget> ret = [];
          for (int j = 0; j < tableLength; j++) {
            ret.add(
              Align(
                alignment: Alignment.topRight,
                child: Text(
                  "${(j+1).toString()}. ",
                  style: TextStyle(
                    color: Colors.grey
                  )
                ),
              ),
            );
            ret.add(
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SelectableText(
                    widget.meanings.meanings![j].replaceAll("⬜", ", "),
                    style: widget.style
                  ),
                  // refernces, ex.: 悪どい, 
                  if(widget.meanings.xref != null && widget.meanings.xref![j] != null)
                    RichText(
                      text: TextSpan(
                        text: "See also: ",
                        style: TextStyle(
                          color: Colors.grey
                        ),
                        children: [
                          for (int i = 0; i < realtedEntries[j]!.length; i++)
                            if(realtedEntries[j] != null)
                              TextSpan(
                                text: (realtedEntries[j]![i]!.kanjis.isEmpty
                                  ? realtedEntries[j]![i]!.readings.first
                                  : realtedEntries[j]![i]!.kanjis.first)
                                  + (i < realtedEntries[j]!.length - 1
                                    ? ", "
                                    : ""),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      int id = int.parse(widget.meanings.xref![j]!.attributes[i]!);
                                      Navigator.pushNamedAndRemoveUntil(
                                        context,
                                        "/dictionary",
                                        (route) => false,
                                        arguments: NavigationArguments(
                                          false,
                                          initialEntryId: id
                                        )
                                      );
                                    },
                              )
                        ]
                      ),
                    ),
                  // kanji targets
                  if(widget.meanings.senseKanjiTarget != null)
                    Text(
                      "test"
                    ),
                ],
              )
            );
          }
          // show more button
          if(hide == 1)
            ret.add(
              InkWell(
                onTap: () {
                  setState(() {
                    showAllMeanings = !showAllMeanings;
                  });
                },
                child: Row(
                  children: [
                    Container(
                      child: Icon(Icons.expand_more)
                    ),
                    SizedBox(width: 10,),
                    Text("More...")
                  ],
                )
              ).withGridPlacement(columnSpan: 2)
            );
          
          return ret;
        } ()
      ),
    );
  }
}