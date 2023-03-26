import 'package:flutter/material.dart';

import 'package:kana_kit/kana_kit.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:path/path.dart';



class KanaGrid extends StatefulWidget {

  /// The table of kana to be displayed
  final List<List<String>> kanaTable;
  /// Whether to show romaji or not
  final bool showRomaji;
  /// The callback function to be called when a kana is tapped
  final Function(String)? onTap;
  /// The callback function to be called when a kana is long pressed
  final Function(String)? onLongPress;


  const KanaGrid(
    this.kanaTable,
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
    return GridView.count(
      mainAxisSpacing: 0.0,
      crossAxisSpacing: 0.0,
      crossAxisCount: widget.kanaTable[0].length,
      childAspectRatio: (MediaQuery.of(context).size.width / 5)
        / (MediaQuery.of(context).size.height / 13),
      padding: EdgeInsets.all(0.0),
      shrinkWrap: true,
      children: List.generate(widget.kanaTable.length*widget.kanaTable[0].length, (index) => 
          AnimationConfiguration.staggeredGrid(
          position: index,
          columnCount: widget.kanaTable[0].length,
          duration: Duration(milliseconds: 300),
          child: widget.kanaTable[index~/5][index%5] != ""
          ? FadeInAnimation(
            key: Key("${widget.kanaTable[index~/5][index%5]}"),
            child: ScaleAnimation(
              key: Key("${widget.kanaTable[index~/5][index%5]}"),
              child: TextButton(
                onPressed: () {
                  widget.onTap?.call("${widget.kanaTable[index~/5][index%5]}");
                },
                child: RichText(
                  text: TextSpan(
                    text: widget.kanaTable[index~/5][index%5],
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                    ),
                    children: [
                      if(widget.showRomaji)
                        TextSpan(
                          text: KanaKit().toRomaji(
                            " " + widget.kanaTable[index~/5][index%5]
                          ),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        )
                    ]
                  ),
                )
              ),
            ),
          )
          : SizedBox()
        )
      )
    );
  }
}