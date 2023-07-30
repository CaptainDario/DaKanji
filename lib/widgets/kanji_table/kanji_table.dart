import 'package:da_kanji_mobile/domain/settings/settings.dart';
import 'package:flutter/material.dart';

import 'package:database_builder/database_builder.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get_it/get_it.dart';
import 'package:onboarding_overlay/onboarding_overlay.dart';
import 'package:isar/isar.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:da_kanji_mobile/locales_keys.dart';
import 'package:da_kanji_mobile/domain/user_data/user_data.dart';
import 'package:da_kanji_mobile/globals.dart';
import 'package:da_kanji_mobile/widgets/kanji_table/kanji_details_page.dart';
import 'package:da_kanji_mobile/domain/isar/isars.dart';
import 'package:da_kanji_mobile/data/show_cases/tutorials.dart';
import 'package:da_kanji_mobile/domain/kanji_table/kanji_category.dart';
import 'package:da_kanji_mobile/domain/kanji_table/kanji_sorting.dart';



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
    KanjiSorting.STROKES_ASC : "Strokes ↑", KanjiSorting.STROKES_DSC : "Strokes ↓",
    KanjiSorting.FREQ_ASC    : "${LocaleKeys.DictionaryScreen_kanji_frequency.tr()} ↑"  , KanjiSorting.FREQ_DSC : "${LocaleKeys.DictionaryScreen_kanji_frequency.tr()} ↓",
    KanjiSorting.RTK_ASC     : "RTK ↑"    , KanjiSorting.RTK_DSC : "RTK ↓",
    KanjiSorting.KLC_ASC     : "KLC ↑"    , KanjiSorting.KLC_DSC : "KLC ↓"
  };
  /// [DropdownMenuItem]s for the sorting selction
  List<DropdownMenuItem> sortingDropDowns = [];
  /// The currently selected sorting order
  KanjiSorting sortingSelection = KanjiSorting.STROKES_ASC;
  /// has the user changed the category
  bool changedCategories = false;


  @override
  void initState() {
    // load settings
    categorySelection      = GetIt.I<Settings>().kanjiTable.kanjiCategory;
    categoryLevelSelection = GetIt.I<Settings>().kanjiTable.kanjiCategoryLevel;
    sortingSelection       = GetIt.I<Settings>().kanjiTable.kanjiSorting;

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
        categoryLevels = List.generate(30, (i) => "${1+i*100}-${i*100+100}");
        break;
      case KanjiCategory.SCHOOL:
        query = k.where().distinctByGrade().gradeProperty();
        break;
      case KanjiCategory.FREQ:
        categoryLevels = List.generate(26, (i) => "${1+i*100}-${i*100+100}");
        break;
      case KanjiCategory.KLC:
        categoryLevels = List.generate(23, (i) => "${1+i*100}-${i*100+100}");
        break;
      case KanjiCategory.KENTEI:
        categoryLevels = ["1", "1.5", "2", "2.5", "3", "4", "5", "6", "7", "8", "9", "10"];
        break;
      case KanjiCategory.WANIKANI:
        query = k.where().distinctByWanikani().wanikaniProperty();
        break;
    }
    if(query != null){
      categoryLevels = (query.findAllSync()..sort((b, a) => a.compareTo(b))).map((e) => e.toString()).toList();
      categoryLevels.remove(-1);
    }
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
      .optional(categorySelection == KanjiCategory.FREQ, (q) => q.frequencyBetween(
        int.parse(categoryLevelSelection.substring(0, categoryLevelSelection.indexOf("-"))),
        int.parse(categoryLevelSelection.substring(categoryLevelSelection.indexOf("-")+1))
      ))
      .optional(categorySelection == KanjiCategory.KLC, (q) => q.klcBetween(
        int.parse(categoryLevelSelection.substring(0, categoryLevelSelection.indexOf("-"))),
        int.parse(categoryLevelSelection.substring(categoryLevelSelection.indexOf("-")+1))
      ))
      .optional(categorySelection == KanjiCategory.KENTEI, (q) => q.kankenEqualTo(double.parse(categoryLevelSelection)))
      .optional(categorySelection == KanjiCategory.WANIKANI, (q) => q.wanikaniEqualTo(int.parse(categoryLevelSelection)))
    // apply sorting
    .optional(sortingSelection == KanjiSorting.STROKES_ASC, (q) => q.sortByStrokeCount())
    .optional(sortingSelection == KanjiSorting.STROKES_DSC, (q) => q.thenByStrokeCountDesc())
    .optional(sortingSelection == KanjiSorting.FREQ_ASC,    (q) => q.thenByFrequency())
    .optional(sortingSelection == KanjiSorting.FREQ_DSC,    (q) => q.thenByFrequencyDesc())
    .optional(sortingSelection == KanjiSorting.RTK_ASC,     (q) => q.thenByRtkNew())
    .optional(sortingSelection == KanjiSorting.RTK_DSC,     (q) => q.thenByRtkNewDesc())
    .optional(sortingSelection == KanjiSorting.KLC_ASC,     (q) => q.thenByKlc())
    .optional(sortingSelection == KanjiSorting.KLC_DSC,     (q) => q.thenByKlcDesc())
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

  ///
  Future<void> saveCurrentConfig() async {
    GetIt.I<Settings>().kanjiTable.kanjiCategory      = categorySelection;
    GetIt.I<Settings>().kanjiTable.kanjiCategoryLevel = categoryLevelSelection;
    GetIt.I<Settings>().kanjiTable.kanjiSorting       = sortingSelection;
    GetIt.I<Settings>().save();
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
                  ? GetIt.I<Tutorials>().kanjiTableScreenTutorial.focusNodes![2]
                  : null,
                child: DropdownButton(
                  value: categorySelection,
                  items: categoryDropDowns,
                  onChanged: (value) async {
                    setState(() {
                      categorySelection = value;
                      changedCategories = true;
                      updateKanjisAndCategories();
                      initDropDowns();
                    });
                    await saveCurrentConfig();
                  },
                ),
              ),
              // actual level from the category ie.: JLPT 1, 2, 3, 4, 5, ...
              Focus(
                focusNode: widget.includeTutorial
                  ? GetIt.I<Tutorials>().kanjiTableScreenTutorial.focusNodes![3]
                  : null,
                child: DropdownButton(
                  value: categoryLevelSelection,
                  items: categoryLevelDropDowns,
                  onChanged: (value) async {
                    setState(() {
                      categoryLevelSelection = value;
                      updateKanjisAndCategories();
                    });
                    await saveCurrentConfig();
                  },
                ),
              ),
              // the way of sorting the shown kanji
              Focus(
                focusNode: widget.includeTutorial
                  ? GetIt.I<Tutorials>().kanjiTableScreenTutorial.focusNodes![4]
                  : null,
                child: DropdownButton(
                  value: sortingSelection,
                  items: sortingDropDowns,
                  onChanged: (value) async {
                    setState(() {
                      sortingSelection = value;
                      updateKanjisAndCategories();
                    });
                    await saveCurrentConfig();
                  },
                ),
              ),
              Spacer(),
              // Amount of kanji in the current selection
              Focus(
                focusNode: widget.includeTutorial
                  ? GetIt.I<Tutorials>().kanjiTableScreenTutorial.focusNodes![5]
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
              return Focus(
                focusNode: widget.includeTutorial && i == 0
                  ? GetIt.I<Tutorials>().kanjiTableScreenTutorial.focusNodes![1]
                  : null,
                child: AnimationConfiguration.staggeredGrid(
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
                ),
              );
            }
          ),
        ),
          
      ],
    );
  }
}