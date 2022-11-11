import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';



/// `LayouGrid` structured to show a list of meanings with a count
class MeaningsGrid extends StatelessWidget {
  
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
  Widget build(BuildContext context) {

    int offset = min(countOffset, meanings.length-1);

    List<String> _meanings = meanings.sublist(
      offset, 
      limit == 0 ? null : min(countOffset+limit, meanings.length)
    );

    return LayoutGrid(
      gridFit: GridFit.loose,
      columnSizes: [auto, 0.425.fr, auto, 0.425.fr],
      rowSizes: List.generate(_meanings.length~/2+1, (index) => auto),
      children: List.generate(
        (_meanings.length),
        (int j) => [
          Text(
            "${(j+1+offset).toString()}. ",
            style: style
          ),
          SelectableText(
            meanings[j],
            style: style
          )
        ],
      ).expand((e) => e).toList()
    );
  }
}