import 'package:flutter/material.dart';



enum ConjugationType {
  polite, plain
}

/// Widget that shows one conjugation tense. Usually used in
/// `VerbConjugationExpansionTile` 
class VerbConjugationEntry extends StatefulWidget {
  const VerbConjugationEntry(
    {
      required this.title,
      required this.explanation,
      required this.conjugationType,
      required this.plainFormPositive,
      required this.plainFormNegative,
      required this.politeFormPositive,
      required this.politeFormNegative,
      super.key
    });
  /// The title, or name of this tense
  final String title;
  /// The expalantion, or name of this tense
  final String explanation;
  /// the type of conjugation which should be shown in this widget.
  final ConjugationType conjugationType;
  /// The conjugation of this tense in "positive" plain form
  final String plainFormPositive;
  /// The conjugation of this tense in "negative" plain form
  final String plainFormNegative;
  /// The conjugation of this tense in "positive" masu form
  final String politeFormPositive;
  /// The conjugation of this tense in "negative" masu form
  final String politeFormNegative;

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
    
    return widget.plainFormPositive == "" && widget.plainFormNegative == "" &&
      widget.politeFormPositive == "" && widget.politeFormNegative == "" 
    ? SizedBox()
    : Column(
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
            if(widget.conjugationType == ConjugationType.plain &&
              widget.plainFormPositive != "")
              Column(
                children: 
                  widget.plainFormPositive.split(" / ").map((e) => 
                    SelectableText(e, style: positiveStyle)
                  ).toList()
                
              ),
            if(widget.conjugationType == ConjugationType.plain &&
              widget.plainFormNegative != "")
              Column(
                children: 
                  widget.plainFormNegative.split(" / ").map((e) => 
                    SelectableText(e, style: negativeStyle)
                  ).toList()
              ),
            // masu conjugations
            if(widget.conjugationType == ConjugationType.polite &&
              widget.politeFormPositive != "")
              Column(
                children: 
                  widget.politeFormPositive.split(" / ").map((e) => 
                    SelectableText(e, style: positiveStyle)
                  ).toList()
                
              ),
            if(widget.conjugationType == ConjugationType.polite &&
              widget.politeFormNegative != "")
              Column(
                children: 
                  widget.politeFormNegative.split(" / ").map((e) => 
                    SelectableText(e, style: negativeStyle)
                  ).toList()
              ),
          ],
        ),
      ],
    );
  }
}