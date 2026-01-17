import 'package:dakanji_db_core/database/term/term_bank_v3_entry.dart';
import 'package:dakanji_util/widgets/conditional_parent_widget.dart';
import 'package:flutter/material.dart';
import 'package:language_processing/japanese/furigana_matching.dart';


class DictionaryMatchTermBankTermWidget extends StatefulWidget {

  /// The terms to display.
  final List<TermBankV3Entry> entries;
  /// Use katakana for furigana readings.
  final bool useKatakanaForFurigana;

  const DictionaryMatchTermBankTermWidget(
    this.entries,
    {
      this.useKatakanaForFurigana = false,
      super.key
    }
  );

  @override
  State<DictionaryMatchTermBankTermWidget> createState() => _DictionaryMatchTermBankTermWidgetState();
}

class _DictionaryMatchTermBankTermWidgetState extends State<DictionaryMatchTermBankTermWidget> {

  /// The terms and readings bundled as furigana pairs.
  List<List<FuriganaPair>> termsAndReadings = [];

  TextStyle get readingTextStyle => const TextStyle(
    fontSize: 12,
    color: Colors.grey,
  );

  TextStyle get kanjiTextStyle => const TextStyle(fontSize: 18,);


  @override
  void initState() {
    super.initState();
    termsAndReadings = widget.entries
      .map((e) => (e.term, e.reading)).toSet()
      .map((e) => matchFurigana(e.$1, e.$2, convertToKatakana: widget.useKatakanaForFurigana))
      .toList();
  }

  @override
  Widget build(BuildContext context) {

    return Wrap(
      children: [
        for (var termAndReading in termsAndReadings) 
          ...[
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Wrap(
                alignment: WrapAlignment.start,
                crossAxisAlignment: WrapCrossAlignment.end,
                children: [
                  for (final pair in termAndReading)
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ConditionalParentWidget(
                          // if there is no term ...
                          condition: pair.kanji.isEmpty,
                          conditionalBuilder: (child) {
                            // ... disable selection of reading
                            return SelectionContainer.disabled(child: child);
                          },
                          child: Text(
                            pair.kanji.isNotEmpty && pair.reading.isNotEmpty
                              ? pair.reading
                              : "", // when there is no kanji, don't show reading 
                            style: readingTextStyle
                          )
                        ),
                        Text(
                          pair.kanji.isNotEmpty ? pair.kanji : pair.reading,
                          style: kanjiTextStyle
                        ),
                      ],
                    ),
                  if(termAndReading != termsAndReadings.last) Text("、")
                ],
              )
            ),
          ]
      ],
    );
  }
}