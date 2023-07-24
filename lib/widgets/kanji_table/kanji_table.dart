import 'package:flutter/material.dart';

import 'package:database_builder/database_builder.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';

import 'package:da_kanji_mobile/globals.dart';
import 'package:da_kanji_mobile/widgets/kanji_table/kanji_details_page.dart';
import 'package:da_kanji_mobile/domain/isar/isars.dart';


enum KanjiCategory {
  JLPT,
  RTK,
  SCHOOL,
  FREQ,
  KLC,
  OFFICIAL,
  KENTEI
}

enum KanjiSorting{
  STROKES_ASC, STROKES_DSC
}


class KanjiTable extends StatefulWidget {



  const KanjiTable(
    {
      super.key
    }
   );

  @override
  State<KanjiTable> createState() => _KanjiTableState();
}

class _KanjiTableState extends State<KanjiTable> {

  /// all the kanji that should be shown when `categorySelection` and
  /// `categoryLevelSelection` are applied. Sorted matching `sortingSelection`.
  List<Kanjidic2> kanjis = [];

  Map<KanjiCategory, String> kanjiCategoryToString = {
    KanjiCategory.JLPT     : "JLPT",
    KanjiCategory.RTK      : "RTK",
    KanjiCategory.SCHOOL   : "School",
    KanjiCategory.FREQ     : "Freq",
    KanjiCategory.KLC      : "KLC",
    KanjiCategory.OFFICIAL : "Official",
    KanjiCategory.KENTEI   : "漢字検定",
  };
  /// [DropdownMenuItem]s for the catgeroy selction
  List<DropdownMenuItem> categoryDropDowns = [];
  /// The currently selected category
  KanjiCategory categorySelection = KanjiCategory.JLPT;

  /// the available categories matching `categorySelection`
  List<int> categoryLevels = [];
  /// [DropdownMenuItem]s for the catgeroy level selction
  List<DropdownMenuItem> categoryLevelDropDowns = [];
  /// The currently selected category level
  int categoryLevelSelection = 4;

  /// the available sorting orders
  Map<KanjiSorting, String> KanjiSortingToString = {
    KanjiSorting.STROKES_ASC : "Strokes ↑", KanjiSorting.STROKES_DSC : "Strokes ↓"
  };
  /// [DropdownMenuItem]s for the sorting selction
  List<DropdownMenuItem> sortingDropDowns = [];
  /// The currently selected sorting order
  KanjiSorting sortingSelection = KanjiSorting.STROKES_ASC;
  

  bool changedCategories = false;


  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant KanjiTable oldWidget) {
    init();
    super.didUpdateWidget(oldWidget);
  }

  void init() {

    updateKanjisAndCategories();
    
    initDropDowns();
  }

  /// find all kanji that belong to one of the `categories` 
  void updateKanjisAndCategories(){

    kanjis = GetIt.I<Isars>().dictionary.kanjidic2s.filter()
      .optional(categorySelection == KanjiCategory.JLPT, (q) => q.jlptEqualTo(categoryLevelSelection))
      .optional(categorySelection == KanjiCategory.SCHOOL, (q) => q.gradeEqualTo(categoryLevelSelection))
    // apply sorting
    .optional(sortingSelection == KanjiSorting.STROKES_ASC, (q) => q.sortByStrokeCount())
    .optional(sortingSelection == KanjiSorting.STROKES_DSC, (q) => q.thenByStrokeCountDesc())
    .findAllSync();

    var k = GetIt.I<Isars>().dictionary.kanjidic2s; QueryBuilder<Kanjidic2, int, QQueryOperations> query;
    switch (categorySelection) {
      case KanjiCategory.JLPT:
        query = k.where().distinctByJlpt().jlptProperty();
        break;
      case KanjiCategory.RTK:
        throw Exception("Illegal category");
      case KanjiCategory.SCHOOL:
        query = k.where().distinctByGrade().gradeProperty();
        break;
      case KanjiCategory.FREQ:
        throw Exception("Illegal category");
      case KanjiCategory.KLC:
        throw Exception("Illegal category");
      case KanjiCategory.OFFICIAL:
        throw Exception("Illegal category");
      case KanjiCategory.KENTEI:
        throw Exception("Illegal category");
    }
    categoryLevels = query.findAllSync()..sort((b, a) => a.compareTo(b));
    if(changedCategories){
      categoryLevelSelection = categoryLevels.first;
      changedCategories = false;
    }
  }

  /// Init the dropdowns for filtering / sorting the kanji tables
  void initDropDowns(){
    // categories the user can select
    categoryDropDowns = List.generate(KanjiCategory.values.length, (index) => 
      DropdownMenuItem<KanjiCategory>(
        value: KanjiCategory.values[index],
        child: Text("${kanjiCategoryToString[KanjiCategory.values[index]]}")
      )
    );

    // the levels of the categories
    categoryLevelDropDowns = List.generate(categoryLevels.length, (index) => 
      DropdownMenuItem(
        value: categoryLevels[index],
        child: Text("${categoryLevels[index]}")
      )
    );

    // sortings
    sortingDropDowns = List.generate(KanjiSorting.values.length, (index) => 
      DropdownMenuItem(
        value: KanjiSorting.values[index],
        child: Text("${KanjiSortingToString[KanjiSorting.values[index]]}")
      )
    );
  }

  @override
  Widget build(BuildContext context) {

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          floating: true,
          title: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Show: "
                  ),
                ),
              ),
              // category ie: JLPT, RTK, etc
              DropdownButton(
                value: categorySelection,
                items: categoryDropDowns,
                onChanged: (value) {
                  setState(() {
                    categorySelection = value;
                    changedCategories = true;
                    updateKanjisAndCategories();
                    initDropDowns();
                  });
                },
              ),
              // actual level from the category ie.: JLPT 1, 2, 3, 4, 5, ...
              DropdownButton(
                value: categoryLevelSelection,
                items: categoryLevelDropDowns,
                onChanged: (value) {
                  setState(() {
                    categoryLevelSelection = value;
                    updateKanjisAndCategories();
                  });
                },
              ),
              // second level of sorting defaults to stroke oder based sorting
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Sort: "
                  ),
                ),
              ),
              // the way of sorting the shown kanji
              DropdownButton(
                value: sortingSelection,
                items: sortingDropDowns,
                onChanged: (value) {
                  setState(() {
                    sortingSelection = value;
                    updateKanjisAndCategories();
                  });
                },
              ),
              // Amount of kanji in the current selection
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "No.: ${kanjis.length}"
                  ),
                ),
              ),
            ]
          ),
        ),

        AnimationLimiter(
          key: UniqueKey(),
          child: SliverGrid.builder(
            itemCount: kanjis.length,
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 60
            ),
            itemBuilder: (context, i) {
              return AnimationConfiguration.staggeredGrid(
                columnCount: (MediaQuery.of(context).size.width / 60).ceil(),
                position: i,
                duration: Duration(milliseconds: 300),
                child: ScaleAnimation(
                  child: Card(
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => 
                            const KanjiDetailsPage()
                          )
                        );
                      },
                      child: Center(
                        child: FittedBox(
                          child: Text(
                            kanjis[i].character,
                            style: TextStyle(
                              fontSize: 500,
                              fontFamily: g_japaneseFontFamily
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }
          ),
        ),
          
      ],
    );
  }
}