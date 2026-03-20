// Flutter imports:
import 'package:da_kanji_mobile/features/dictionary/model/dictionary_search_state.dart';
import 'package:da_kanji_mobile/features/dictionary/widgets/term/term_entry_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get_it/get_it.dart';

// Project imports:
import 'package:language_processing/language_processing.dart';
import 'package:da_kanji_mobile/features/settings/model/settings.dart';
import 'package:da_kanji_mobile/features/settings/model/settings_dictionary.dart';
import 'package:da_kanji_mobile/globals.dart';
import 'package:da_kanji_mobile/locales_keys.dart';
import 'package:da_kanji_mobile/features/dictionary/widgets/conjugation_expansion_tile.dart';
import 'package:provider/provider.dart';

class DictionaryWordCard extends StatefulWidget {

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

    final match = context.read<DictionarySearchState>().selectedResult;
    if(match != null){
      readingOrKanji = match.entries.first.term.isEmpty
        ? match.entries.first.reading
        : match.entries.first.term;

      // get the pos for conjugating this word
      conjugationPos = match.entries.first.ruleIdentifiers
        .nonNulls.map((e) => posStringToPosEnum[e])
        .nonNulls.toSet().toList();
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
            
            TermEntryWidget(
              context.watch<DictionarySearchState>().selectedResult!,
              includeCard: false,
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
                      gestureRecognizers: {
                        Factory<OneSequenceGestureRecognizer>(()  
                          => EagerGestureRecognizer())
                      },
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
