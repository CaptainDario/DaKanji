// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:da_kanji_mobile/widgets/dictionary/verb_conjugation_entry.dart';

/// `ExpansionTile` that shows conjugations of `word` (verb, adjective)
class ConjugationColumn extends StatefulWidget {


  /// A list containing the titles of the conjugations
  final List<List<String>> conjugationTitles;
  /// A list containing the explanations of the conjugation forms
  final List<List<String>> conjugationExplanations;
  /// Nested list that contains all conjugations of `widget.word`
  final List<List<List<String>>> conjos;
  /// Decides which conjugation pattern to show, for example ます系、辞書系
  final List<int> conjugationSets;

  const ConjugationColumn(
    {
      required this.conjugationTitles,
      required this.conjugationExplanations,
      required this.conjos,
      required this.conjugationSets,
      super.key
    }
  );

  @override
  State<ConjugationColumn> createState() => _ConjugationColumnState();
}

class _ConjugationColumnState extends State<ConjugationColumn> {




  @override
  Widget build(BuildContext context) {
    return widget.conjugationTitles.isEmpty
      ? Container()
      : Column(
        children: [ 
          for (int i in widget.conjugationSets)
            Column(
              children: List.generate(widget.conjos[(i/2).floor()].length, (j) => 
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: VerbConjugationEntry(
                    title: widget.conjugationTitles[(i/2).floor()][j],
                    explanation: widget.conjugationExplanations[(i/2).floor()][j],
                    conjugationType: i.isEven
                      ? ConjugationType.plain
                      : ConjugationType.polite,
                    plainFormPositive: widget.conjos[(i/2).floor()][j][0],
                    plainFormNegative: widget.conjos[(i/2).floor()][j][1],
                    politeFormPositive: widget.conjos[(i/2).floor()][j][2], 
                    politeFormNegative: widget.conjos[(i/2).floor()][j][3]
                  ),
                ),
              )
            )
        ]
      );
  }

}
