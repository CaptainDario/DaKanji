import 'package:flutter/material.dart';


class ExampleSentenceCard extends StatefulWidget {
  const ExampleSentenceCard(
    this.sentences,
    {Key? key}
  ) : super(key: key);

  /// the example sentence
  final List<String>? sentences;

  @override
  State<ExampleSentenceCard> createState() => _ExampleSentenceCardState();
}

class _ExampleSentenceCardState extends State<ExampleSentenceCard> {
  @override
  Widget build(BuildContext context) {

    if(widget.sentences == null)
      return Container();
    else
      return SizedBox(
        height: 150,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.sentences!.join("\n")
                ),
              ],
            ),
          )
        ),
      );
  }
}