// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:database_builder/database_builder.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get_it/get_it.dart';

// Project imports:
import 'package:da_kanji_mobile/entities/conjugation/kwpos.dart';
import 'package:da_kanji_mobile/entities/settings/settings.dart';
import 'package:da_kanji_mobile/entities/settings/settings_dictionary.dart';
import 'package:da_kanji_mobile/globals.dart';
import 'package:da_kanji_mobile/locales_keys.dart';
import 'package:da_kanji_mobile/widgets/dictionary/conjugation_expansion_tile.dart';
import 'package:da_kanji_mobile/widgets/dictionary/dictionary_word_tab_kanji.dart';
import 'package:da_kanji_mobile/widgets/dictionary/word_meanings.dart';

class DictionaryWordCard extends StatefulWidget {

  /// the dict entry that should be shown 
  final JMdict? entry;
  /// should the image search expansion tile be included in this widget
  final bool showImageSearch;
  /// should the conjugation table be included in this widget
  final bool showConjugationTable;
  /// should the conjugation table be expandable
  final bool conjugationTableExpandable;
  /// Callback that is triggered when the user changes the expansion state
  /// of the google image search table
  final Function(bool state)? onGooglSearchExpansionChanged;
  /// Callback that is triggered when the user changes the expansion state
  /// of the conjugation table
  final Function(bool state)? onConjugationTableExpansionChanged;

  const DictionaryWordCard(
    this.entry,
    {
      this.showImageSearch = true,
      this.showConjugationTable = true,
      this.conjugationTableExpandable = true,
      this.onGooglSearchExpansionChanged,
      this.onConjugationTableExpansionChanged,
      super.key
    }
  );

  @override
  State<DictionaryWordCard> createState() => _DictionaryWordCardState();
}

class _DictionaryWordCardState extends State<DictionaryWordCard> {
  
  /// the text style to use for all partOfSpeech elements
  TextStyle? partOfSpeechStyle;

  /// the text style to use for all meaning elements
  TextStyle meaningsStyle = const TextStyle();
  /// either `widget.entry.kanji[0]` if not null, otherwise `widget.entry.readings[0]`
  String? readingOrKanji;
  /// The pos that should be used for conjugating this word
  List<Pos>? conjugationPos;

  @override
  void initState() {
    initData();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant DictionaryWordCard oldWidget) {
    initData();
    super.didUpdateWidget(oldWidget);
  }

  /// parses and initializes all data elements of this widget
  void initData() {

    if(widget.entry != null){
      readingOrKanji = widget.entry!.kanjis.isEmpty
        ? widget.entry!.readings[0]
        : widget.entry!.kanjis[0];

      // get the pos for conjugating this word
      conjugationPos = widget.entry!.meanings.map((e) => e.partOfSpeech)
        .nonNulls.expand((e) => e)
        .nonNulls.expand((e) => e.attributes)
        .nonNulls.map((e) => posDescriptionToPosEnum[e]!)
        .toSet().toList();
    }
  }



  @override
  Widget build(BuildContext context) {

    partOfSpeechStyle ??= TextStyle(fontSize: 12, color: Theme.of(context).hintColor);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            DictionaryWordTabKanji(widget.entry!),
              
            const SizedBox(
              height: 5,
            ),
              
            // JLPT
            if(widget.entry!.jlptLevel != null && widget.entry!.jlptLevel!.isNotEmpty)
              ...[
                Text(
                  widget.entry!.jlptLevel!.join(", "),
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12
                  ),
                ),
              
                const SizedBox(
                  height: 5,
                ),
              ],

            // Frequency
            if(GetIt.I<Settings>().dictionary.showWordFruequency)
              ...[
                Text(
                  "${LocaleKeys.DictionaryScreen_kanji_frequency.tr()}: ${widget.entry!.frequency.toStringAsFixed(2)}",
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12
                  ),
                ),
              
                const SizedBox(
                  height: 5,
                ),
              ],
              
            // meanings
            WordMeanings(
              entry: widget.entry!, 
              meaningsStyle: meaningsStyle,
            ),
              
            if(g_webViewSupported && widget.showImageSearch)
              ExpansionTile(
                title: Text(LocaleKeys.DictionaryScreen_word_images.tr()),
                onExpansionChanged: (value) {
                  widget.onGooglSearchExpansionChanged?.call(value);
                },
                children: [
                  AspectRatio(
                    aspectRatio: 1,
                    child: InAppWebView(
                      onWebViewCreated: (controller) {

                        String s = GetIt.I<Settings>()
                          .dictionary.googleImageSearchQuery
                          .replaceAll(SettingsDictionary.d_googleImageSearchQuery, readingOrKanji ?? "");
                        controller.loadUrl(urlRequest: URLRequest(
                          url: WebUri("$g_GoogleImgSearchUrl$s")
                        ));
                      },
                    )
                  )
                ],
              ),
            if(conjugationPos != null && conjugationPos!.isNotEmpty
              && widget.showConjugationTable)
              ConjugationExpansionTile(
                word: readingOrKanji!,
                pos: conjugationPos!,
                isExpandable: widget.conjugationTableExpandable,
                onExpansionChanged: (state) {
                  widget.onConjugationTableExpansionChanged?.call(state);
                },
              ),
          ],
        ),
      )
    );
  }
}
