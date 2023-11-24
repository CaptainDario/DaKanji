// Flutter imports:
import 'package:da_kanji_mobile/domain/settings/settings.dart';
import 'package:da_kanji_mobile/entities/kana/mnemonics.dart';
import 'package:da_kanji_mobile/widgets/dictionary/kanji_vg_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:database_builder/database_builder.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';

// Project imports:
import 'package:da_kanji_mobile/application/kana/kana.dart';
import 'package:da_kanji_mobile/domain/isar/isars.dart';



/// Widget that shows information about a given kana. This information is
/// * romaji
/// * stroke order diagram
/// * mnemonic image
/// * mnemonic text
/// Additionally, a sound of the kana is played.
class KanaInfoCard extends StatefulWidget {

  /// current kana
  final String kana;
  /// Should the kana be animated
  final bool showAnimatedKana;
  /// Callback that is executed when the user presses the play button
  final Function()? onPlayPressed;


  const KanaInfoCard(
    this.kana,
    {
      this.showAnimatedKana = false,
      this.onPlayPressed,
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
  String? yoonSVG;
  /// The mnemonic of the kana
  String? mnemonic;


  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant KanaInfoCard oldWidget) {
    if(oldWidget.kana != widget.kana) init(); 
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
    yoonSVG = null;
    if(widget.kana.length > 1){
      yoonSVG = GetIt.I<Isars>().dictionary.kanjiSVGs.where()
        .characterEqualTo(widget.kana[1])
      .findFirstSync()!.svg;
      yoonSVG = modifyKanjiVGSvg(
        yoonSVG!,
        // ignore: use_build_context_synchronously
        strokeColor: Theme.of(context).brightness == Brightness.dark
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

    return LayoutBuilder(
      builder: (context, constraints) {
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if(constraints.maxWidth > 100)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          convertToRomaji(widget.kana),
                          maxLines: 1,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          )
                        ),
                        IconButton(
                          onPressed: widget.onPlayPressed,
                          icon: const Icon(Icons.play_arrow)
                        )
                      ],
                    ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // kana
                        Expanded(
                          child: Center(
                            child: widget.showAnimatedKana
                              ? KanjiVGWidget(
                                kanaSvg,
                                MediaQuery.of(context).size.height * 0.2,
                                MediaQuery.of(context).size.height * 0.2,
                                GetIt.I<Settings>().kanaTable.playKanaAnimationWhenOpened,
                                GetIt.I<Settings>().kanaTable.kanaAnimationStrokesPerSecond,
                                GetIt.I<Settings>().kanaTable.resumeAnimationAfterStopSwipe,
                                borderAround: false,
                              )
                              : SvgPicture.string(
                                kanaSvg,
                                height: MediaQuery.of(context).size.height * 0.2,
                                width: MediaQuery.of(context).size.height * 0.2,
                                color: Theme.of(context).brightness == Brightness.dark
                                  ? Colors.white
                                  : Colors.black,
                              )
                          )
                        ),
                        // mnemonic (if there is one)
                        if(widget.kana.length < 2 && mnemonicSvg != null)
                          Expanded(
                            child: Center(
                              child: SvgPicture.string(
                                mnemonicSvg!,
                                height: MediaQuery.of(context).size.height * 0.2,
                                width: MediaQuery.of(context).size.height * 0.2,
                              )
                            )
                          ),
                        // yoon if there are two kana
                        if(widget.kana.length > 1 && yoonSVG != null)
                          Expanded(
                            child: Transform.translate(
                              offset: Offset(0, MediaQuery.of(context).size.height * 0.025),
                              child: Center(
                                child: SvgPicture.string(
                                  yoonSVG!,
                                  height: MediaQuery.of(context).size.height * 0.15,
                                )
                              ),
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
                                p: const TextStyle(
                                  fontSize: 20,
                                ),
                                // bold text
                                strong: const TextStyle(
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
              ),
            ),
          )
        );
      }
    );
  }

}
