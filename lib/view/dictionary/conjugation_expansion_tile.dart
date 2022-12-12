import 'package:da_kanji_mobile/helper/conjugation/conj.dart';
import 'package:da_kanji_mobile/helper/conjugation/conjugate.dart';
import 'package:da_kanji_mobile/helper/conjugation/conjugation_descriptions.dart';
import 'package:flutter/material.dart';

import 'package:da_kanji_mobile/helper/conjugation/kwpos.dart';
import 'package:da_kanji_mobile/view/dictionary/verb_conjugation_entry.dart';




/// `ExpansionTile` that shows conjugations of `word` (verb, adjective)
class ConjugationExpansionTile extends StatefulWidget {
  const ConjugationExpansionTile(
    {
      required this.word,
      required this.pos,
      super.key
    }
  );

  /// The verb of which the conjugation are shown in this widget
  final String word;
  /// The part of speech of this verb that should be used for conjugating
  final List<Pos> pos;

  @override
  State<ConjugationExpansionTile> createState() => _ConjugationExpansionTileState();
}

class _ConjugationExpansionTileState extends State<ConjugationExpansionTile>
  with SingleTickerProviderStateMixin {

  /// A list containing the titles of the conjugations
  final List<List<String>> conjugationTitles = [];
  /// A list containing the explanations of the conjugation forms
  final List<List<String>> conjugationExplanations = [];
  /// Nested list that contains all conjugations of `widget.word`
  final List<List<List<String>>> _conjos = [];
  /// List of titles for the conjugation tabs
  final List<String> tabTitles = [];
  final List<String> words = [];
  /// Controller for handling the conjugation tabs
  late final TabController tabController;


  @override
  void initState() {

    /// list containing all part of speech
    final List<List<Conj>> _conjugations = [];

    for (int i = 0; i < widget.pos.length; i++){// in widget.pos) {

      // add "だ" coplua for noun and "な" adjectives
      if(widget.pos[i] == Pos.n || widget.pos[i] == Pos.adj_na){
        widget.pos[i] = Pos.cop;
        words.add(widget.word + "だ");
      }
      // add "する" to words that conjugate with "する" 
      else if(widget.pos[i] == Pos.vs){
        widget.pos[i] = Pos.vs_i;
        words.add(widget.word + "する");
      }
      else{
        words.add(widget.word);
      }

      if(posEnumToPosDescription[widget.pos[i]]!.contains(" verb")){
        conjugationTitles.add(verbConjugationTitles);
        conjugationExplanations.add(verbConjugationMeanings);
        _conjugations.add(verbConjugationTypes);
        tabTitles.add("Verb - plain");
        tabTitles.add("Verb - polite");
      }
      else if(posEnumToPosDescription[widget.pos[i]]!.contains("adjective")){
        conjugationTitles.add(adjectiveConjugationTitles);
        conjugationExplanations.add(adjectiveConjugationMeanings);
        _conjugations.add(adjectiveConjugationTypes);
        tabTitles.add("Adjective - plain");
        tabTitles.add("Adjective - polite");
      }
      else if (widget.pos.contains(Pos.cop)){
        conjugationTitles.add(adjectiveConjugationTitles);
        conjugationExplanations.add(adjectiveConjugationMeanings);
        _conjugations.add(adjectiveConjugationTypes);
        tabTitles.add("Copula - plain");
        tabTitles.add("Copula - polite");
      }
    }

    for (int i = 0; i < _conjugations.length; i++) {
      _conjos.add([]);
      for (int j = 0; j < _conjugations[i].length; j++) {

        _conjos[i].add([
          conjosFromArgs(widget.pos[i], _conjugations[i][j], false, false)
          .map((conjo) => 
            conjugate(words[i], conjo)
          ).toList().join(" / "),
          conjosFromArgs(widget.pos[i], _conjugations[i][j], true, false)
          .map((conjo) => 
            conjugate(words[i], conjo)
          ).toList().join(" / "),
          conjosFromArgs(widget.pos[i], _conjugations[i][j], false, true)
          .map((conjo) => 
            conjugate(words[i], conjo)
          ).toList().join(" / "),
          conjosFromArgs(widget.pos[i], _conjugations[i][j], true, true)
          .map((conjo) => 
            conjugate(words[i], conjo)
          ).toList().join(" / ")
        ]); 
      }
    }

    tabController = TabController(length: tabTitles.length, vsync: this);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      textColor: Theme.of(context).highlightColor,
      childrenPadding: EdgeInsets.all(16),
      title: const Text("Conjugation"),
      children: [
        TabBar(
          labelColor: Theme.of(context).highlightColor,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Theme.of(context).highlightColor,
          controller: tabController,
          tabs: tabTitles.map((e) => 
            Text(e)
          ).toList()
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.5,
          child: TabBarView(
            controller: tabController,
            children: List.generate(tabTitles.length, (i) =>
              SingleChildScrollView(
                clipBehavior: Clip.antiAlias,
                child: Column(
                  children: List.generate(_conjos[(i/2).floor()].length, (j) => 
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child: VerbConjugationEntry(
                        title: conjugationTitles[(i/2).floor()][j],
                        explanation: conjugationExplanations[(i/2).floor()][j],
                        conjugationType: i.isEven
                          ? ConjugationType.plain
                          : ConjugationType.polite,
                        plainFormPositive: _conjos[(i/2).floor()][j][0],
                        plainFormNegative: _conjos[(i/2).floor()][j][1],
                        politeFormPositive: _conjos[(i/2).floor()][j][2], 
                        politeFormNegative: _conjos[(i/2).floor()][j][3]
                      ),
                    ),
                  ),
                ),
              )
            ).toList(),
          ),
        )
      ]
    );
  }

}