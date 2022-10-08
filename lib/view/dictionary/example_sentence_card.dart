import 'package:flutter/material.dart';


class ExampleSentenceCard extends StatefulWidget {
  const ExampleSentenceCard(
    this.sentence,
    this.translations,
    {Key? key}
  ) : super(key: key);

  /// the japanese example sentence
  final String sentence;
  /// a list containing all translations that should be shown
  final List<String> translations;

  @override
  State<ExampleSentenceCard> createState() => _ExampleSentenceCardState();
}

class _ExampleSentenceCardState extends State<ExampleSentenceCard> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
              widget.translations.join("\n")
            ),
          ],
        )
      ),
    );
  }
}