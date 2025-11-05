import 'package:dakanji_db_core/database/term/term_bank_v3_entry.dart';
import 'package:flutter/material.dart';
import 'package:language_processing/japanese/furigana_matching.dart';


class DictionaryMatchTermWidget extends StatefulWidget {

  /// The terms to display.
  final List<TermBankV3Entry> entries;

  const DictionaryMatchTermWidget(this.entries, {super.key});

  @override
  State<DictionaryMatchTermWidget> createState() => _DictionaryMatchTermWidgetState();
}

class _DictionaryMatchTermWidgetState extends State<DictionaryMatchTermWidget> {

  /// The terms and readings bundled as furigana pairs.
  List<List<FuriganaPair>> termsAndReadings = [];

  TextStyle get readingTextStyle => const TextStyle(
    fontSize: 14,
    color: Colors.grey,
  );

  TextStyle get kanjiTextStyle => const TextStyle(fontSize: 18,);


  @override
  void initState() {
    super.initState();
    termsAndReadings = widget.entries
      .map((e) => (e.term, e.reading)).toSet()
      .map((e) => matchFurigana(e.$1, e.$2)).toList();
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
                      children: [
                        if (pair.kanji.isNotEmpty && pair.reading.isNotEmpty)
                          Text(pair.reading, style: readingTextStyle),
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