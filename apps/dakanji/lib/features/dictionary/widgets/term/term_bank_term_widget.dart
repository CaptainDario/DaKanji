import 'package:da_db/database/da_db.dart';
import 'package:da_db/database/term/term_bank_v3_entry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_util/widgets/conditional_parent_widget.dart';
import 'package:get_it/get_it.dart';
import 'package:language_processing/language_processing.dart';


class TermBankTermWidget extends StatefulWidget {

  /// The terms to display.
  final List<TermBankV3Entry> entries;
  /// Use katakana for furigana readings.
  final bool useKatakanaForFurigana;
  /// Should the audio playback button be shown (queries them from db).
  final bool showAudioPlaybackButtons;

  const TermBankTermWidget(
    this.entries,
    {
      this.useKatakanaForFurigana = false,
      this.showAudioPlaybackButtons = false,
      super.key
    }
  );

  @override
  State<TermBankTermWidget> createState() => _TermBankTermWidgetState();
}

class _TermBankTermWidgetState extends State<TermBankTermWidget> {

  /// The terms and readings bundled as furigana pairs.
  List<List<TermReadingPair>> termsAndReadings = [];

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
      .map((e) => GetIt.I<DaDb>().languageProcessor.getTermReadingPairs(
        e.$1, e.$2, ProcessorOptions(japaneseOptions: JapaneseProcessorOptions(
          getTermReadingPairsConvertToKatakanaForFurigana: widget.useKatakanaForFurigana
      )))).toList();
  }

  Future getAudiosForTerms(List<TermBankV3Entry> entries) async {
  
    // TODO audios
    //GetIt.I<DaDb>().audioDao.;

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
                alignment: .start,
                crossAxisAlignment: .end,
                children: [
                  for (final pair in termAndReading)
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ConditionalParentWidget(
                          // if there is no term ...
                          condition: pair.term.isEmpty,
                          conditionalBuilder: (child) {
                            // ... disable selection of reading
                            return SelectionContainer.disabled(child: child);
                          },
                          child: Text(
                            pair.term.isNotEmpty && pair.reading.isNotEmpty
                              ? pair.reading
                              : "", // when there is no kanji, don't show reading 
                            style: readingTextStyle
                          )
                        ),
                        Text(
                          pair.term.isNotEmpty ? pair.term : pair.reading,
                          style: kanjiTextStyle
                        ),
                      ],
                    ),
                  // audio playback button
                  Column(
                    children: [
                      InkWell(
                        onTap: () {
                          // TODO play audio for term
                          print("Playing audio for term: ${termAndReading.map((e) => e.term.isNotEmpty ? e.term : e.reading).join()}");
                        },
                        borderRadius: BorderRadius.circular(40),
                        child: Icon(
                          Icons.volume_up_rounded,
                          size: 20,
                          color: Colors.grey
                        ),
                      ),
                      SizedBox(height: 12),
                    ],
                  ),
                  // separator
                  if(termAndReading != termsAndReadings.last) Text("、")
                ],
              )
            ),
          ]
      ],
    );
  }
}