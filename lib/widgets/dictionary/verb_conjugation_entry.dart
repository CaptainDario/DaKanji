// Flutter imports:
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
  TextStyle negativeStyle = const TextStyle(fontSize: 20, color: Colors.grey);
  /// style for normal conjugation
  TextStyle positiveStyle = const TextStyle(fontSize: 20);

  @override
  Widget build(BuildContext context) {
    
    return widget.conjugationType == ConjugationType.plain && widget.plainFormPositive == "" && widget.plainFormNegative == "" ||
      widget.conjugationType == ConjugationType.polite && widget.politeFormPositive == "" && widget.politeFormNegative == "" 
    ? const SizedBox()
    : Column(
      children: [
        // Grammar "name"
        Text(
          widget.title,
          style: const TextStyle(fontSize: 20),
        ),
        // Grammar "explanation"
        if(widget.explanation != "")
          Text.rich(
            TextSpan(
              children: widget.explanation.split(RegExp(" ")).map((e) => 
                TextSpan(
                  text: "$e ",
                  style: TextStyle(
                    color: RegExp(r"\[[N|n]ot.*?\]").hasMatch(e)
                      ? Colors.grey
                      : null
                  )
                )
              ).toList() 
            )
          ),
        const SizedBox(height: 4,),
        Row(
          children: [
            // plain conjugations
            if(widget.conjugationType == ConjugationType.plain &&
              widget.plainFormPositive != "")
                Expanded(
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: SelectableText(
                      widget.plainFormPositive, 
                      style: positiveStyle,
                    ),
                  )
                ),    
            if(widget.conjugationType == ConjugationType.plain &&
              widget.plainFormNegative != "")
              Expanded(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: SelectableText(
                    widget.plainFormNegative,
                    style: negativeStyle,
                  ),
                )
              ),

            // masu conjugations
            if(widget.conjugationType == ConjugationType.polite &&
              widget.politeFormPositive != "")
              Expanded(
                child: Align(
                  alignment: Alignment.center,
                  child: SelectableText(
                    widget.politeFormPositive,
                    style: positiveStyle,
                  ),
                ),
              ),
            if(widget.conjugationType == ConjugationType.polite &&
              widget.politeFormNegative != "")
              Expanded(
                child: Align(
                  alignment: Alignment.center,
                  child: SelectableText(
                    widget.politeFormNegative,
                    style: negativeStyle,
                    
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}
