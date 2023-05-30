import 'package:flutter/material.dart';

import 'package:easy_localization/easy_localization.dart';

import 'package:da_kanji_mobile/data/conjugation/conjos.dart';
import 'package:da_kanji_mobile/data/conjugation/kwpos.dart';
import 'package:da_kanji_mobile/widgets/dictionary/verb_conjugation_entry.dart';
import 'package:da_kanji_mobile/data/conjugation/conj.dart';
import 'package:da_kanji_mobile/application/conjugation/conjugate.dart';
import 'package:da_kanji_mobile/data/conjugation/conjugation_descriptions.dart';
import 'package:da_kanji_mobile/locales_keys.dart';



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
  with TickerProviderStateMixin {

  /// A list containing the titles of the conjugations
  final List<List<String>> conjugationTitles = [];
  /// A list containing the explanations of the conjugation forms
  final List<List<String>> conjugationExplanations = [];
  /// Nested list that contains all conjugations of `widget.word`
  final List<List<List<String>>> _conjos = [];
  /// List of titles for the conjugation tabs
  final List<String> tabTitles = [];
  /// List of all conjugation forms that should be displayed
  final List<String> words = [];
  /// Controller for handling the conjugation tabs
  TabController? tabController;
  /// The conjugated word that is displayed currently
  String conjugatedWord = "";
  /// The part of speech of the word so the conjugation patterns can be determined
  List<Pos> pos = [];


  @override
  void initState() {
    initConjugations();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant ConjugationExpansionTile oldWidget) {
    initConjugations();
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {

    return conjugationTitles.isEmpty
      ? Container()
      : ExpansionTile(
        textColor: Theme.of(context).highlightColor,
        childrenPadding: EdgeInsets.all(16),
        title: Text(LocaleKeys.DictionaryScreen_word_conjugation.tr()),
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

  /// Conjugates the current word and stores the results in the class members
  void initConjugations(){
    /// list containing all part of speech
    final List<List<Conj>> _conjugations = [];
    // reset all conjugation variables
    conjugationTitles.clear(); conjugationExplanations.clear(); _conjos.clear();
    tabTitles.clear(); words.clear();
    pos = widget.pos;
    // do not conjugate "な" adjectives that can be nouns twice
    if(pos.contains(Pos.adj_na) && pos.contains(Pos.n)){
      pos.remove(Pos.adj_na);
    }
    // remove all PoS types that do now have conjugations
    pos.removeWhere((element) => !conjos.any((conjo) => conjo.pos == element));
    
    for (int i = 0; i < pos.length; i++){

      // add "だ" coplua for noun and "な" adjectives
      if(pos[i] == Pos.n || pos[i] == Pos.adj_na){
        pos[i] = Pos.cop;
        words.add(widget.word + "だ");
      }
      // add "する" to words that conjugate with "する" 
      else if(pos[i] == Pos.vs){
        pos[i] = Pos.vs_i;
        words.add(widget.word + "する");
      }
      else{
        words.add(widget.word);
      }

      // add conjugation titles and descriptions matching the POS
      if(posEnumToPosDescription[pos[i]]!.contains(" verb")){
        conjugationTitles.add(verbConjugations.map((e) => e.item1).toList());
        conjugationExplanations.add(verbConjugations.map((e) => e.item2).toList());
        _conjugations.add(verbConjugations.map((e) => e.item3).toList());
        tabTitles.add("${LocaleKeys.DictionaryScreen_word_conj_verb.tr()} - ${LocaleKeys.DictionaryScreen_word_conj_plain.tr()}");
        tabTitles.add("${LocaleKeys.DictionaryScreen_word_conj_verb.tr()} - ${LocaleKeys.DictionaryScreen_word_conj_polite.tr()}");
      }
      else if(posEnumToPosDescription[pos[i]]!.contains("adjective")){
        conjugationTitles.add(adjectiveConjugations.map((e) => e.item1).toList());
        conjugationExplanations.add(adjectiveConjugations.map((e) => e.item2).toList());
        _conjugations.add(adjectiveConjugations.map((e) => e.item3).toList());
        tabTitles.add("${LocaleKeys.DictionaryScreen_word_conj_adjective.tr()} - ${LocaleKeys.DictionaryScreen_word_conj_plain.tr()}");
        tabTitles.add("${LocaleKeys.DictionaryScreen_word_conj_adjective.tr()} - ${LocaleKeys.DictionaryScreen_word_conj_polite.tr()}");
      }
      else if (pos.contains(Pos.cop)){
        conjugationTitles.add(adjectiveConjugations.map((e) => e.item1).toList());
        conjugationExplanations.add(adjectiveConjugations.map((e) => e.item2).toList());
        _conjugations.add(adjectiveConjugations.map((e) => e.item3).toList());
        tabTitles.add("${LocaleKeys.DictionaryScreen_word_conj_copula.tr()} - ${LocaleKeys.DictionaryScreen_word_conj_plain.tr()}");
        tabTitles.add("${LocaleKeys.DictionaryScreen_word_conj_copula.tr()} - ${LocaleKeys.DictionaryScreen_word_conj_polite.tr()}");
      }
    }

    // Conjugate this word matching a verb; adjective or noun pattern
    for (int i = 0; i < _conjugations.length; i++) {
      _conjos.add([]);
      for (int j = 0; j < _conjugations[i].length; j++) {

        _conjos[i].add([
          conjosFromArgs(pos[i], _conjugations[i][j], false, false)
          .map((conjo) => 
            conjugate(words[i], conjo)
          ).toList().join(" / "),
          conjosFromArgs(pos[i], _conjugations[i][j], true, false)
          .map((conjo) => 
            conjugate(words[i], conjo)
          ).toList().join(" / "),
          conjosFromArgs(pos[i], _conjugations[i][j], false, true)
          .map((conjo) => 
            conjugate(words[i], conjo)
          ).toList().join(" / "),
          conjosFromArgs(pos[i], _conjugations[i][j], true, true)
          .map((conjo) => 
            conjugate(words[i], conjo)
          ).toList().join(" / ")
        ]); 
      }
    }
    conjugatedWord = widget.word;
    
    tabController = TabController(length: tabTitles.length, vsync: this);
  }

}