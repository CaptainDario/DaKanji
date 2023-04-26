import 'package:da_kanji_mobile/helper/iso/iso_table.dart';
import 'package:da_kanji_mobile/provider/settings/settings.dart';
import 'package:flutter/material.dart';

import 'package:database_builder/database_builder.dart';
import 'package:get_it/get_it.dart';



/// A Card that is used to preview the content of a search result
class SearchResultCard extends StatefulWidget {
  const SearchResultCard(
    {
      required this.dictEntry,
      required this.resultIndex,
      this.showWordFrequency = false,
      this.onPressed,
      Key? key
    }
  ) : super(key: key);

  /// The reading that should be displayed in this card
  final JMdict dictEntry;
  /// If true the word frequency will be displayed
  final bool showWordFrequency;
  /// The index of this result in the search results
  final int resultIndex;
  /// Callback that is invoked if the card is pressed, passes `dict_entry`
  /// as parameter
  final Function(JMdict selection)? onPressed;

  @override
  State<SearchResultCard> createState() => _SearchResultCardState();
}

class _SearchResultCardState extends State<SearchResultCard> {

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(5.0),
        onTap: () {
          if(widget.onPressed != null) {
            widget.onPressed!(widget.dictEntry);
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              // Japanese words + translations
              Expanded(
                flex: 7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // reading
                    Text(
                      widget.dictEntry.kanjis.isEmpty ? 
                        "" : widget.dictEntry.readings.join(", "),
                      style: const TextStyle(
                        fontSize: 10
                      ),
                    ),
                    // kanjis
                    Text(
                      (
                        widget.dictEntry.kanjis.isNotEmpty ? 
                          widget.dictEntry.kanjis : widget.dictEntry.readings
                      ).join(", "),
                      style: const TextStyle(
                        fontSize: 20
                      ),
                    ),
                    // meanings
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ...List.generate(
                          // find first language that is in meanings and selected in settings
                          3,
                          (int index) {

                            // get the index of the first selected language
                            int idx = -1;
                            outerloop:
                            for (var l in GetIt.I<Settings>().dictionary.selectedTranslationLanguages) {
                              int cnt = 0;
                              for (var m in widget.dictEntry.meanings) {
                                if(isoToiso639_1[m.language]!.name == l){
                                  idx = cnt;
                                  break outerloop;
                                }
                                cnt += 1;
                              }
                            }

                            return Text(
                              widget.dictEntry.meanings[idx].meanings!.length > index
                                ? "${(index+1).toString()}. ${widget.dictEntry.meanings[idx].meanings![index]}"
                                : "",
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 10
                              ),
                            );
                          }
                        )
                      ],
                    )
                  ],
                ),
              ),
              //part of speech information
              Expanded(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    if(widget.dictEntry.partOfSpeech != null)
                      Text(
                        widget.dictEntry.partOfSpeech!.toSet().join(" \u200B").toString(),
                        textAlign: TextAlign.end,
                        style: const TextStyle(
                          fontSize: 10,
                          letterSpacing: 0
                        ),
                      ),
                    if(widget.showWordFrequency)
                      SizedBox(height: 5,),
                    if(widget.showWordFrequency)
                      Text(
                        textAlign: TextAlign.end,
                        widget.dictEntry.frequency.toStringAsFixed(2),
                        style: const TextStyle(
                          fontSize: 10,
                          letterSpacing: 0
                        ),
                      ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}