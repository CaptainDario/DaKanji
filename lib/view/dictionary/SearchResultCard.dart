import 'package:flutter/material.dart';



/// A Card that is used to preview the content of a search result
class SearchResultCard extends StatefulWidget {
  SearchResultCard(
    this.readings,
    this.kanjis,
    this.meanings,
    this.partOfSpeech,
    {Key? key}
  ) : super(key: key);

  /// The reading that should be displayed in this card
  final List<String> readings;
  /// The kanji that should be displayed in this card
  final List<String> kanjis;
  /// The meaning that should be displayed in this card
  final List<String> meanings;

  final List<String> partOfSpeech;

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
          
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.kanjis.isEmpty ? "" : widget.readings.join(", "),
                      style: TextStyle(
                        fontSize: 10
                      ),
                    ),
                    Text(
                      (
                        widget.kanjis.isNotEmpty ? widget.kanjis : widget.readings
                      ).join(", "),
                      style: TextStyle(
                        fontSize: 20
                      ),
                    ),
                    Text(
                      widget.meanings.join("/ "),
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 10
                      ),
                    )
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.partOfSpeech.first.toString(),
                    style: TextStyle(
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