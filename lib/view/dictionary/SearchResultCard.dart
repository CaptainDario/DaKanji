import 'package:flutter/material.dart';



class SearchResultCard extends StatefulWidget {
  SearchResultCard(
    this.reading,
    this.kanji,
    this.meaning,
    {Key? key}
  ) : super(key: key);

  /// The reading that should be displayed in this card
  String reading;
  /// The kanji that should be displayed in this card
  String kanji;
  /// The meaning that should be displayed in this card
  String meaning;

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
          print("test");
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    widget.reading,
                    style: TextStyle(
                      fontSize: 10
                    ),
                  ),
                  Text(
                    widget.kanji,
                    style: TextStyle(
                      fontSize: 20
                    ),
                  ),
                  Text(
                    widget.meaning,
                    style: TextStyle(
                      fontSize: 10
                    ),
                  )
                ],
              ),
              Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "common",
                        style: TextStyle(
                          fontSize: 10
                        ),
                      ),
                      Text(
                        "する"
                      ),
                      Text(
                        "noun",
                        style: TextStyle(
                          fontSize: 10
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}