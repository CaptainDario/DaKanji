import 'package:flutter/material.dart';

import 'package:database_builder/database_builder.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get_it/get_it.dart';
import 'package:onboarding_overlay/onboarding_overlay.dart';
import 'package:isar/isar.dart';

import 'package:da_kanji_mobile/domain/user_data/user_data.dart';
import 'package:da_kanji_mobile/globals.dart';
import 'package:da_kanji_mobile/widgets/kanji_table/kanji_details_page.dart';
import 'package:da_kanji_mobile/domain/isar/isars.dart';
import 'package:da_kanji_mobile/data/show_cases/tutorials.dart';


enum KanjiCategory {
  JLPT,
  RTK,
  SCHOOL,
  FREQ,
  KLC,
  KENTEI,
  WANIKANI
}

enum KanjiSorting{
  STROKES_ASC, STROKES_DSC
}


class KanjiTable extends StatefulWidget {
  /// should the focus nodes for the tutorial be included
  final bool includeTutorial;

  const KanjiTable(
    this.includeTutorial,
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

  /// Lookup to convert the [KanjiCategory] to a localized string
  Map<KanjiCategory, String> kanjiCategoryToString = {
    KanjiCategory.JLPT     : "JLPT",
    KanjiCategory.RTK      : "RTK",
    KanjiCategory.SCHOOL   : "School",
    KanjiCategory.FREQ     : "Freq",
    KanjiCategory.KLC      : "KLC",
    KanjiCategory.KENTEI   : "漢字検定",
    KanjiCategory.WANIKANI : "Wanikani"
  };
  /// [DropdownMenuItem]s for the catgeroy selction
  List<DropdownMenuItem> categoryDropDowns = [];
  /// The currently selected category
  KanjiCategory categorySelection = KanjiCategory.JLPT;

  /// the available categories matching `categorySelection`
  List<String> categoryLevels = [];
  /// [DropdownMenuItem]s for the catgeroy level selction
  List<DropdownMenuItem> categoryLevelDropDowns = [];
  /// The currently selected category level
  String categoryLevelSelection = "5";
  /// the available sorting orders
  Map<KanjiSorting, String> KanjiSortingToString = {
    KanjiSorting.STROKES_ASC : "Strokes ↑", KanjiSorting.STROKES_DSC : "Strokes ↓"
  };
  /// [DropdownMenuItem]s for the sorting selction
  List<DropdownMenuItem> sortingDropDowns = [];
  /// The currently selected sorting order
  KanjiSorting sortingSelection = KanjiSorting.STROKES_ASC;
  /// has the user changed the category
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

    // after first frame
    WidgetsBinding.instance.addPostFrameCallback((Duration timeStamp) async {

      // init tutorial
      final OnboardingState? onboarding = Onboarding.of(context);
      if (onboarding != null && widget.includeTutorial && 
        GetIt.I<UserData>().showTutorialKanjiTable) {
        onboarding.showWithSteps(
          GetIt.I<Tutorials>().kanjiTableScreenTutorial.indexes![0],
          GetIt.I<Tutorials>().kanjiTableScreenTutorial.indexes!
        );
      }
    });

  }

  /// find all kanji that belong to one of the `categories` 
  void updateKanjisAndCategories(){

    // get the available levels for the current category
    var k = GetIt.I<Isars>().dictionary.kanjidic2s; QueryBuilder<Kanjidic2, int, QQueryOperations>? query;
    switch (categorySelection) {
      case KanjiCategory.JLPT:
        query = k.where().distinctByJlptNew().jlptNewProperty();
        break;
      case KanjiCategory.RTK:
        categoryLevels = List.generate(25, (i) => "${1+i*100}-${i*100+100}");
        break;
      case KanjiCategory.SCHOOL:
        query = k.where().distinctByGrade().gradeProperty();
        break;
      case KanjiCategory.FREQ:
        throw Exception("Illegal category");
        query = k.where().distinctByFrequency().frequencyProperty();
      case KanjiCategory.KLC:
        throw Exception("Illegal category");
      case KanjiCategory.KENTEI:
        throw Exception("Illegal category");
        //query = k.where().distinctByKanken().kankenProperty();
        break;
      case KanjiCategory.WANIKANI:
        throw Exception("Illegal category");
    }
    if(query != null)
      categoryLevels = (query.findAllSync()..sort((b, a) => a.compareTo(b))).map((e) => e.toString()).toList();
    if(changedCategories){
      categoryLevelSelection = categoryLevels.first;
      changedCategories = false;
    }

    // find all kanji for the current selection
    kanjis = GetIt.I<Isars>().dictionary.kanjidic2s.filter()
      .optional(categorySelection == KanjiCategory.JLPT, (q) => q.jlptNewEqualTo(int.parse(categoryLevelSelection)))
      .optional(categorySelection == KanjiCategory.RTK, (q) => q.rtkNewBetween(
        int.parse(categoryLevelSelection.substring(0, categoryLevelSelection.indexOf("-"))),
        int.parse(categoryLevelSelection.substring(categoryLevelSelection.indexOf("-")+1))
      ))
      .optional(categorySelection == KanjiCategory.SCHOOL, (q) => q.gradeEqualTo(int.parse(categoryLevelSelection)))
    // apply sorting
    .optional(sortingSelection == KanjiSorting.STROKES_ASC, (q) => q.sortByStrokeCount())
    .optional(sortingSelection == KanjiSorting.STROKES_DSC, (q) => q.thenByStrokeCountDesc())
    .findAllSync();
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
              // category ie: JLPT, RTK, etc
              Focus(
                focusNode: widget.includeTutorial
                  ? GetIt.I<Tutorials>().kanjiTableScreenTutorial.focusNodes![1]
                  : null,
                child: DropdownButton(
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
              ),
              // actual level from the category ie.: JLPT 1, 2, 3, 4, 5, ...
              Focus(
                focusNode: widget.includeTutorial
                  ? GetIt.I<Tutorials>().kanjiTableScreenTutorial.focusNodes![2]
                  : null,
                child: DropdownButton(
                  value: categoryLevelSelection,
                  items: categoryLevelDropDowns,
                  onChanged: (value) {
                    setState(() {
                      categoryLevelSelection = value;
                      updateKanjisAndCategories();
                    });
                  },
                ),
              ),
              // the way of sorting the shown kanji
              Focus(
                focusNode: widget.includeTutorial
                  ? GetIt.I<Tutorials>().kanjiTableScreenTutorial.focusNodes![3]
                  : null,
                child: DropdownButton(
                  value: sortingSelection,
                  items: sortingDropDowns,
                  onChanged: (value) {
                    setState(() {
                      sortingSelection = value;
                      updateKanjisAndCategories();
                    });
                  },
                ),
              ),
              Spacer(),
              // Amount of kanji in the current selection
              Focus(
                focusNode: widget.includeTutorial
                  ? GetIt.I<Tutorials>().kanjiTableScreenTutorial.focusNodes![4]
                  : null,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "${kanjis.length}"
                    ),
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
                            KanjiDetailsPage(kanjis[i].character)
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