import 'package:dakanji_db_core/database/db_queries/kanji_dictionary_search/kanji_dictionary_search_result.dart';
import 'package:dakanji_db_core/database/kanji/kanji_bank_v3_entry_stat.dart';
import 'package:dakanji_db_ui/widgets/kanji_search/kanji_match_stats_widget.dart';
import 'package:dakanji_db_ui/widgets/kanji_search/kanji_meta_bank_widget.dart';
import 'package:dakanji_db_ui/widgets/search_results/dictionary_match_tag_bank_widget.dart';
import 'package:flutter/material.dart';



class KanjiDictionarySearchResultWidget extends StatefulWidget {

  final KanjiDictionarySearchResult result;

  const KanjiDictionarySearchResultWidget(
    this.result,
    {
      super.key
    }
  );

  @override
  State<KanjiDictionarySearchResultWidget> createState() => _KanjiDictionarySearchResultWidgetState();
}

class _KanjiDictionarySearchResultWidgetState extends State<KanjiDictionarySearchResultWidget> {

  List<KanjiBankV3EntryStat> statistics = [];

  List<({String text, List<String> values})> readingAndMeaning = [];

  late Map<String, List<KanjiBankV3EntryStat>> otherCategories = {};


  @override
  void initState() {
    super.initState();

    // statisticcs that should be shown next to the kanji
    statistics = widget.result.kanjiBankEntry.stats
      .where((e) => e.tag.category == "misc").toList();
    // On, Kun, Meanings shown below kanji
    readingAndMeaning = [
      (text: "Kun", values: widget.result.kanjiBankEntry.kunyomis),
      (text: "On", values: widget.result.kanjiBankEntry.onyomis),
      (text: "Meanings", values: widget.result.kanjiBankEntry.definitions),
    ];
    // get all the other categories and their data from the stat entries
    for (var stat in widget.result.kanjiBankEntry.stats) {
      if (stat.tag.category != "misc") {
        otherCategories.putIfAbsent(stat.tag.category, () => []);
        otherCategories[stat.tag.category]!.add(stat);
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    final kanjiEntry = widget.result.kanjiBankEntry;
    final kanjiMetaEntries = widget.result.kanjiMetaBankEntries;

    return Card(
      child: SelectionArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: .start,
            crossAxisAlignment: .start,
            children: [
              Row(
                children: [
                  // kanji
                  // TODO when migrating to DaKanji keep a text version of the kanji
                  // to allow for selection/copying
                  Expanded(
                    child: Align(
                      alignment: .center,
                      child: SizedBox(
                        height: 200,
                        width: 200,
                        child: FittedBox(
                          child: Text(
                            widget.result.kanjiBankEntry.kanji,
                          ),
                        ),
                      ),
                    ),
                  ),
                  // kanji statistics
                  Expanded(child: KanjiMatchStatsWidget(statistics))
                ],
              ),
              DictionaryMatchTagBankWidget([kanjiEntry.tags]),

              SizedBox(height: 8),

              // meta entries
              KanjiMetaBankWidget(kanjiMetaEntries),
        
              SizedBox(height: 8),

              // on, kun, definitions
              Table(
                columnWidths: const {
                  0: IntrinsicColumnWidth(), // as wide as needed
                  1: FlexColumnWidth(), // take remaining space
                },
                children: [
                  for (final (:text, :values) in readingAndMeaning)
                    // kun readings
                    TableRow(
                      children: [
                        Text("$text:  "),
                        Text(
                          values.join(", "),
                          style: TextStyle(color: Colors.grey),
                        ),
                      ]
                    ),
                ],
              ),

              SizedBox(height: 8),
        
              // show the other stat entries as collapsibles
              for (var category in otherCategories.entries)
                ExpansionTile(
                  title: Text(category.key),
                  children: [
                    KanjiMatchStatsWidget(category.value)
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}