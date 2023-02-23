import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';



/// `LayouGrid` structured to show a list of meanings with a count
class MeaningsGrid extends StatefulWidget {
  
  /// The style to be used for the text
  final TextStyle style;
  /// A list of meanings that should be shown
  final List<String> meanings;
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

  @override
  Widget build(BuildContext context) {

    /// the lenght of this meanings table (how many rows)
    int tableLength = showAllMeanings ?
      widget.meanings.length : 
      min(widget.meanings.length, 5);
    /// should the 'show more'-button be there
    int hide = widget.meanings.length > 5 && !showAllMeanings ? 1 : 0;
    
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
              SelectableText(
                widget.meanings[j],
                style: widget.style
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