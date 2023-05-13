import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';

import 'package:database_builder/database_builder.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';

import 'package:da_kanji_mobile/domain/isar/isars.dart';
import 'package:da_kanji_mobile/application/kana/kana.dart';



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
  /// The svg of the kana's mnemonics
  String? mnemonicSvg;
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

  /// initialize this widget
  void init() async {
    // get the svg of the kana
    kanaSvg = GetIt.I<Isars>().dictionary.kanjiSVGs.where()
      .characterEqualTo(widget.kana[0])
    .findFirstSync()!.svg;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        kanaSvg = modifyKanjiVGSvg(kanaSvg,
          strokeColor: Theme.of(context).brightness == Brightness.dark
            ? Colors.white
            : Colors.black
        );
      });
    });
    // load the mnemonic if there is one for this kana
    mnemonicSvg = null;
    if((await rootBundle.loadString('AssetManifest.json')).contains("assets/images/kana/individuals/${widget.kana}.svg")) {
      rootBundle.loadString(
        "assets/images/kana/individuals/${widget.kana}.svg"
      ).then((value) {
        setState(() {
          mnemonicSvg = themeMnemonicSvg(
            value, Theme.of(context).brightness == Brightness.dark
          );
        });
      });
    }

    // get the svg of the yoon kana if there is one
    if(widget.kana.length > 1){
      yoonSVG = GetIt.I<Isars>().dictionary.kanjiSVGs.where()
        .characterEqualTo(widget.kana[1])
      .findFirstSync()!.svg;
      yoonSVG = modifyKanjiVGSvg(
        yoonSVG,
        strokeColor: SchedulerBinding.instance.window.platformBrightness == Brightness.dark
          ? Colors.white
          : Colors.black
      );
    }
    // get the text of the mnemonic
    else {
      mnemonic = kanaMnemonics[widget.kana[0]];
    }

  }

  @override
  Widget build(BuildContext context) {

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
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
                        child: SvgPicture.string(
                          kanaSvg,
                          height: MediaQuery.of(context).size.height * 0.2,
                        ),
                      )
                    ),
                    // mnemonic (if there is one)
                    if(widget.kana.length < 2 && mnemonicSvg != null)
                      Expanded(
                        child: Center(
                          child: SvgPicture.string(
                            mnemonicSvg!,
                            height: MediaQuery.of(context).size.height * 0.2,
                          )
                        )
                      ),
                    // yoon if there are two kana
                    if(widget.kana.length > 1)
                      Expanded(
                        child: Center(
                          child: SvgPicture.string(
                            yoonSVG,
                          )
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
                              decoration: TextDecoration.underline,
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
        ),
      )
    );
  }

}