import 'dart:math';

import 'package:flutter/material.dart';

import 'package:kana_kit/kana_kit.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';



class KanaGrid extends StatefulWidget {

  /// The table of kana to be displayed
  final List<List<String>> kanaTable;
  /// Whether to show romaji or not
  final bool showRomaji;
  /// Whether the screen is in portrait mode
  final bool isPortrait;
  /// The callback function to be called when a kana is tapped
  final Function(String)? onTap;
  /// The callback function to be called when a kana is long pressed
  final Function(String)? onLongPress;


  const KanaGrid(
    this.kanaTable,
    this.isPortrait,
    {
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

    int colunmCount = widget.kanaTable.map((e) => e.length).reduce(max);
    int rowCount = widget.kanaTable.length;

    return GridView.count(
      mainAxisSpacing: 0.0,
      crossAxisSpacing: 0.0,
      crossAxisCount: colunmCount,
      physics: NeverScrollableScrollPhysics(),
      childAspectRatio: (MediaQuery.of(context).size.width / colunmCount)
        / (MediaQuery.of(context).size.height / max(widget.isPortrait ? 13 : 8, rowCount)),
      padding: EdgeInsets.all(0.0),
      shrinkWrap: true,
      children: List.generate(rowCount*colunmCount, (index) {

        String currentKana = widget.kanaTable[index~/colunmCount][index%colunmCount];

        return AnimationConfiguration.staggeredGrid(
          position: index,
          columnCount: colunmCount,
          duration: Duration(milliseconds: 300),
          child: currentKana != ""
          ? FadeInAnimation(
            key: Key("${currentKana}_${widget.showRomaji}"),
            child: ScaleAnimation(
              child: TextButton(
                onPressed: () {
                  widget.onTap?.call("${currentKana}");
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
                          text: KanaKit().toRomaji(
                            "\n" + currentKana
                          ),
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
          : SizedBox()
        );
      })
    );
  }
}