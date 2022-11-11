import 'package:flutter/material.dart';



/// Widget that shows one conjugation tense. Usually used in
/// `VerbConjugationExpansionTile` 
class VerbConjugationEntry extends StatefulWidget {
  const VerbConjugationEntry(
    {
      required this.title,
      required this.explanation,
      required this.dictFormPositive,
      required this.dictFormNegative,
      required this.masuFormPositive,
      required this.masuFormNegative,
      super.key
    });
  /// The title, or name of this tense
  final String title;
  /// The expalantion, or name of this tense
  final String explanation;
  /// The conjugation of this tense in "positive" dictionary form
  final String dictFormPositive;
  /// The conjugation of this tense in "negative" dictionary form
  final String dictFormNegative;
  /// The conjugation of this tense in "positive" masu form
  final String masuFormPositive;
  /// The conjugation of this tense in "negative" masu form
  final String masuFormNegative;

  @override
  State<VerbConjugationEntry> createState() => _VerbConjugationEntryState();
}

class _VerbConjugationEntryState extends State<VerbConjugationEntry> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Grammar "name"
        SelectableText(
          widget.title,
          style: TextStyle(fontSize: 20),
        ),
        // Grammar "explanation"
        if(widget.explanation != "")
          SelectableText(
            widget.explanation,
            style: TextStyle(fontSize: 14),
          ),
        SizedBox(height: 8,),
        Row(
          children: [
            // positive conjugations
            Expanded(
              child: Center(
                child: SelectableText.rich(
                  TextSpan(
                    children: [
                      // normal form
                      TextSpan(
                        text: widget.dictFormPositive,
                        style: TextStyle(
                          fontSize: 20
                        ),
                      ),
                      // polite form
                      TextSpan(
                        text: "、 " + widget.dictFormNegative,
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.grey
                        ),
                      ),
                    ]
                  )
                )
              )
            ),
            // negative conjugations
            Expanded(
              child: Center(
                child: SelectableText.rich(
                  TextSpan(
                    children: [
                      // normal form
                      TextSpan(
                        text: widget.masuFormPositive,
                        style: TextStyle(
                          fontSize: 20
                        ),
                      ),
                      // polite form
                      TextSpan(
                        text: "、 " + widget.masuFormNegative,
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.grey
                        ),
                      ),
                    ]
                  )
                )
              )
            ),
          ],
        ),
      ],
    );
  }
}