import 'package:da_kanji_mobile/helper/conjugation/conj.dart';
import 'package:da_kanji_mobile/helper/conjugation/conjugate.dart';
import 'package:flutter/material.dart';

import 'package:da_kanji_mobile/helper/conjugation/kwpos.dart';
import 'package:da_kanji_mobile/view/dictionary/verb_conjugation_entry.dart';


enum ConjugationTileType {
  verb,
  adjective
}

/// `ExpansionTile` that shows conjugations of `word` (verb, adjective)
class ConjugationExpansionTile extends StatefulWidget {
  const ConjugationExpansionTile(
    {
      required this.word,
      required this.pos,
      required this.conjugationTileType,
      super.key
    }
  );

  /// The verb of which the conjugation are shown in this widget
  final String word;
  /// The part of speech of this verb
  final Pos pos;
  ///
  final ConjugationTileType conjugationTileType;

  @override
  State<ConjugationExpansionTile> createState() => _ConjugationExpansionTileState();
}

class _ConjugationExpansionTileState extends State<ConjugationExpansionTile> {

  /// A list containing the titles of the conjugations
  final List<String> conjugationTitles = [];
  /// A list containing the explanations of the conjugation forms
  final List<String> conjugationExplanations = [];
  /// Nested list that contains all conjugations of `widget.word`
  final List<List<String>> _conjos = [];

  @override
  void initState() {

    /// list containing all part of speech
    final List<Conj> _conjugations = [];

    if(widget.conjugationTileType == ConjugationTileType.verb){
      conjugationTitles.addAll([
        "Present, (Future)",
        "Past",
        "て-form, Continuative",
        //"",
        "Progressive",
        "Volitional",
        "Imperative",
        "Request",
        "Provisional",
        "Conditional",
        "Potential",
        "Passive, Respectful",
        "Causative",
        "Causative passive"
      ]);
      conjugationExplanations.addAll([
        "Will [not] do",
        "Did [not] do",
        "",
        //"[not] doing",
        "I will [not] do, I do [not] intend to do",
        "Do [not] do!",
        "Please do [not do]",
        "If X does [not do], if X is [not]",
        "If X were [not] to do, when X does [not] do",
        "[Not] be able to do, can [not] do",
        "Is [not] done (by ...), will [not] be done (by ...)",
        "Does [not] / will [not] make, let (someone) do",
        "Is [not] made / will [not] be made to do (by someone)"
      ]);
      _conjugations.addAll([
        Conj.Non_past,
        Conj.Past,
        Conj.Conjunctive,
        //Conj.Continuative,
        Conj.Volitional,
        Conj.Imperative,
        Conj.Conjunctive,
        Conj.Provisional,
        Conj.Conditional,
        Conj.Potential,
        Conj.Passive,
        Conj.Causative,
        Conj.Causative_Passive
        
      ]);
    }
    else if(widget.conjugationTileType == ConjugationTileType.adjective){
      conjugationTitles.addAll([
        "Present, (Future)",
        "Past",
        "て-form, Continuative",
        "Provisional",
        "Conditional",
        "Causative",
      ]);
      conjugationExplanations.addAll([
        "Is [not]",
        "was [not]",
        "",
        "If it is [not]",
        "When/if it is [not]",
        "Make somebody [not]"
      ]);
      _conjugations.addAll([
        Conj.Non_past,
        Conj.Past,
        Conj.Conjunctive,
        Conj.Provisional,
        Conj.Conditional,
        Conj.Causative
      ]);
    }

    for (var conj in _conjugations) {
      _conjos.add([
        conjosFromArgs(widget.pos, conj, false, false).map((conjo) => 
          conjugate(widget.word, conjo)
        ).toList().join(" / "),
        conjosFromArgs(widget.pos, conj, false, true).map((conjo) => 
          conjugate(widget.word, conjo)
        ).toList().join(" / "),
        conjosFromArgs(widget.pos, conj, true, false).map((conjo) => 
          conjugate(widget.word, conjo)
        ).toList().join(" / "),
        conjosFromArgs(widget.pos, conj, true, true).map((conjo) => 
          conjugate(widget.word, conjo)
        ).toList().join(" / ")
      ]);
    }

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      childrenPadding: EdgeInsets.all(16),
      title: const Text("Conjugation"),
      children: List.generate(_conjos.length, (i) => 
        VerbConjugationEntry(
          title: conjugationTitles[i],
          explanation: conjugationExplanations[i],
          dictFormPositive: _conjos[i][0],
          dictFormNegative: _conjos[i][1],
          masuFormPositive: _conjos[i][2], 
          masuFormNegative: _conjos[i][3]
        ),
      )
    );
  }
}