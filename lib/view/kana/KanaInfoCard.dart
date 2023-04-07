import 'package:da_kanji_mobile/model/kana/kana.dart';
import 'package:flutter/material.dart';

import 'package:database_builder/database_builder.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';

import 'package:da_kanji_mobile/provider/isars.dart';



class KanaInfoCard extends StatefulWidget {

  /// current kana
  final String kana;

  const KanaInfoCard(
    this.kana,
    {
      super.key
    }
  );

  @override
  State<KanaInfoCard> createState() => _KanaInfoCardState();
}

class _KanaInfoCardState extends State<KanaInfoCard> {

  /// The svg of the kana
  String kanaSvg = "";
  /// The svg of the dakuten
  String yoonSVG = "";
  /// The mnemonic of the kana
  String? mnemonic = null;

  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant KanaInfoCard oldWidget) {
    init();
    super.didUpdateWidget(oldWidget);
  }

  /// initialize the kanaSvg and yoonSVG
  void init(){
    // get the svg of the kana
    kanaSvg = GetIt.I<Isars>().dictionary.kanjiSVGs.where()
      .characterEqualTo(widget.kana[0])
    .findFirstSync()!.svg;

    // get the svg of the yoon kana if there is one
    // get the mnemonic of the kana if there is one
    if(widget.kana.length > 1){
      yoonSVG = GetIt.I<Isars>().dictionary.kanjiSVGs.where()
        .characterEqualTo(widget.kana[1])
      .findFirstSync()!.svg;
    }
    else {
      mnemonic = kanaMnemonics[widget.kana[0]];
    }
  }

  @override
  Widget build(BuildContext context) {

    return Card(
      child: Center(
        child: Column(
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // kana
                  Expanded(
                    child: Center(
                      child: SvgPicture.string(kanaSvg),
                    )
                  ),
                  // mnemonic (if there is one)
                  if(widget.kana.length < 2)
                    Expanded(
                      child: Center(
                        child: Text(
                          "Mnemonic - picture"
                        )
                      )
                    ),
                  // yoon if there are two kana
                  if(widget.kana.length > 1)
                    Expanded(
                      child: Center(
                        child: SvgPicture.string(yoonSVG),
                      )
                    )
                ],
              ),
            ),
            if(mnemonic != null)
              Expanded(
                child: Center(
                  child: Wrap(
                    clipBehavior: Clip.hardEdge,
                    children: [
                      MarkdownBody(
                        styleSheet: MarkdownStyleSheet(
                          p: TextStyle(
                            fontSize: 20,
                          ),
                          // bold text
                          strong: TextStyle(
                            fontSize: 20,
                          )
                        ),
                        data: mnemonic!,
                        softLineBreak: true,
                      ),
                    ],
                  ),
                ),
              ),
          ],
        )
      )
    );
  }
}