import 'package:flutter/material.dart';


class ExampleSentenceCard extends StatefulWidget {
  ExampleSentenceCard(
    this.sentence,
    this.translation,
    {Key? key}
  ) : super(key: key);

  final sentence;

  final translation;

  @override
  State<ExampleSentenceCard> createState() => _ExampleSentenceCardState();
}

class _ExampleSentenceCardState extends State<ExampleSentenceCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.sentence
            ),
            Text(
              widget.translation
            ),
          ],
        )
      ),
    );
  }
}