import 'dart:math';

import 'package:flutter/material.dart';

import 'package:database_builder/src/jm_enam_and_dict_to_db/data_classes.dart' as Jmdict;



/// A Card that is used to preview the content of a search result
class SearchResultCard extends StatefulWidget {
  const SearchResultCard(
    {
      required this.dictEntry,
      required this.resultIndex,
      this.onPressed,
      Key? key
    }
  ) : super(key: key);

  /// The reading that should be displayed in this card
  final Jmdict.Entry dictEntry;
  /// 
  final int resultIndex;
  /// Callback that is invoked if the card is pressed, passes `dict_entry`
  /// as parameter
  final Function(Jmdict.Entry selection)? onPressed;

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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // reading
                    Hero(
                      tag: "resultCard_${widget.resultIndex}",
                      child: Text(
                        widget.dictEntry.kanjis.isEmpty ? 
                          "" : widget.dictEntry.readings.join(", "),
                        style: const TextStyle(
                          fontSize: 10
                        ),
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
                          min(widget.dictEntry.meanings[0].meanings.length, 3),
                          (int index) => Text(
                            "${(index+1).toString()}. ${widget.dictEntry.meanings[0].meanings[index]}",
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 10
                            ),
                          )
                        )
                      ],
                    )
                  ],
                ),
              ),
              //part of speech information
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.dictEntry.partOfSpeech.first.toString(),
                    style: const TextStyle(
                      fontSize: 10
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}