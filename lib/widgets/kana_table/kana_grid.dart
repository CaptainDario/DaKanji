import 'dart:math';

import 'package:da_kanji_mobile/data/show_cases/tutorials.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import 'package:da_kanji_mobile/application/kana/kana.dart';
import 'package:get_it/get_it.dart';



class KanaGrid extends StatefulWidget {

  /// The table of kana to be displayed
  final List<List<String>> kanaTable;
  /// Whether the screen is in portrait mode
  final bool isPortrait;
  /// The height of this widget
  final double height;
  /// The width of this widget
  final double width;
  /// Whether to show romaji or not
  final bool showRomaji;
  /// The callback function to be called when a kana is tapped
  final Function(String)? onTap;
  /// The callback function to be called when a kana is long pressed
  final Function(String)? onLongPress;


  const KanaGrid(
    this.kanaTable,
    this.isPortrait,
    {
      required this.height,
      required this.width,
      this.showRomaji = true,
      this.onTap,
      this.onLongPress,
      super.key
    }
  );

  @override
  State<KanaGrid> createState() => _KanaGridState();
}

class _KanaGridState extends State<KanaGrid> {

  @override
  Widget build(BuildContext context) {
    /// number of columns in the grid
    int columnCount = widget.kanaTable.map((e) => e.length).reduce(max);
    /// number of rows in the grid
    int rowCount = widget.kanaTable.length;

    return GridView.count(
      mainAxisSpacing: 0.0,
      crossAxisSpacing: 0.0,
      crossAxisCount: columnCount,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: (widget.width / columnCount)
        / (widget.height / (rowCount)),
      padding: const EdgeInsets.all(0.0),
      shrinkWrap: true,
      children: List.generate(rowCount*columnCount, (index) {

        String currentKana = "";
        if(widget.kanaTable.length >= index~/columnCount+1 &&
          widget.kanaTable[index~/columnCount].length >= index%columnCount+1) {
          currentKana = widget.kanaTable[index~/columnCount][index%columnCount];
        }

        return AnimationConfiguration.staggeredGrid(
          position: index,
          columnCount: columnCount,
          duration: const Duration(milliseconds: 300),
          child: currentKana != ""
          ? FadeInAnimation(
            key: Key("${currentKana}_${widget.showRomaji}_${widget.isPortrait}"),
            child: ScaleAnimation(
              child: TextButton(
                focusNode: index == 0
                  ? GetIt.I<Tutorials>().kanaTableScreenTutorial.focusNodes![1]
                  : null,
                onPressed: () {
                  widget.onTap?.call(currentKana);
                },
                child: RichText(
                  overflow: TextOverflow.visible,
                  textAlign: TextAlign.center,
                  softWrap: false,
                  text: TextSpan(
                    text: currentKana[0],
                    style: TextStyle(
                      color: Theme.of(context).brightness == Brightness.light ?
                        Colors.black : Colors.white,
                      fontSize: 30,
                    ),
                    children: [
                      // daku
                      if(currentKana.length > 1)
                        TextSpan(
                          text: currentKana[1],
                          style: TextStyle(
                            color: Theme.of(context).brightness == Brightness.light ?
                              Colors.black : Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      // romaji
                      if(widget.showRomaji)
                        TextSpan(
                          text: "\n${convertToRomaji(currentKana)}",
                          style: TextStyle(
                            overflow: TextOverflow.visible,
                            color: Theme.of(context).brightness == Brightness.light ?
                            Colors.black : Colors.white,
                            fontSize: 12,
                            height: 0.8
                          ),
                        )
                    ]
                  ),
                )
              ),
            ),
          )
          : const SizedBox()
        );
      })
    );
  }
}