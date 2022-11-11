import 'package:flutter/material.dart';



enum ConjugationType {
  masu, plain
}

/// Widget that shows one conjugation tense. Usually used in
/// `VerbConjugationExpansionTile` 
class VerbConjugationEntry extends StatefulWidget {
  const VerbConjugationEntry(
    {
      required this.title,
      required this.explanation,
      required this.conjugationType,
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
  /// the type of conjugation which should be shown in this widget.
  final ConjugationType conjugationType;
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

  /// style for negated conjugation
  TextStyle negativeStyle = TextStyle(fontSize: 20, color: Colors.grey);
  /// style for normal conjugation
  TextStyle positiveStyle = TextStyle(fontSize: 20);

  @override
  Widget build(BuildContext context) {
    
    return Column(
      children: [
        // Grammar "name"
        Text(
          widget.title,
          style: TextStyle(fontSize: 20),
        ),
        // Grammar "explanation"
        if(widget.explanation != "")
          Text.rich(
            TextSpan(
              children: widget.explanation.split(RegExp(" ")).map((e) => 
                TextSpan(
                  text: e + " ",
                  style: TextStyle(
                    color: RegExp(r"\[[N|n]ot.*?\]").hasMatch(e)
                      ? Colors.grey
                      : null
                  )
                )
              ).toList() 
            )
          ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // positive conjugations
            if(widget.conjugationType == ConjugationType.plain)
              Column(
                children: 
                  widget.dictFormPositive.split(" / ").map((e) => 
                    SelectableText(e, style: positiveStyle)
                  ).toList()
                
              ),
            if(widget.conjugationType == ConjugationType.plain)
              Column(
                children: 
                  widget.dictFormNegative.split(" / ").map((e) => 
                    SelectableText(e, style: negativeStyle)
                  ).toList()
              ),
            // masu conjugations
            if(widget.conjugationType == ConjugationType.masu)
              Column(
                children: 
                  widget.masuFormPositive.split(" / ").map((e) => 
                    SelectableText(e, style: positiveStyle)
                  ).toList()
                
              ),
            if(widget.conjugationType == ConjugationType.masu)
              Column(
                children: 
                  widget.masuFormNegative.split(" / ").map((e) => 
                    SelectableText(e, style: negativeStyle)
                  ).toList()
              ),
          ],
        ),
      ],
    );
  }
}