// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:database_builder/database_builder.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';
import 'package:onboarding_overlay/onboarding_overlay.dart';

// Project imports:
import 'package:da_kanji_mobile/entities/show_cases/tutorials.dart';
import 'package:da_kanji_mobile/entities/isar/isars.dart';
import 'package:da_kanji_mobile/entities/kanji_table/kanji_category.dart';
import 'package:da_kanji_mobile/entities/kanji_table/kanji_sorting.dart';
import 'package:da_kanji_mobile/entities/settings/settings.dart';
import 'package:da_kanji_mobile/entities/user_data/user_data.dart';
import 'package:da_kanji_mobile/globals.dart';
import 'package:da_kanji_mobile/locales_keys.dart';
import 'package:da_kanji_mobile/widgets/kanji_table/kanji_details_page.dart';

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
    KanjiCategory.jlpt     : "JLPT",
    KanjiCategory.rtk      : "RTK",
    KanjiCategory.school   : "School",
    KanjiCategory.freq     : "Freq",
    KanjiCategory.klc      : "KLC",
    KanjiCategory.kentei   : "漢字検定",
    KanjiCategory.wanikani : "Wanikani"
  };
  /// [DropdownMenuItem]s for the catgeroy selction
  List<DropdownMenuItem> categoryDropDowns = [];
  /// The currently selected category
  KanjiCategory categorySelection = KanjiCategory.jlpt;

  /// the available categories matching `categorySelection`
  List<String> categoryLevels = [];
  /// [DropdownMenuItem]s for the catgeroy level selction
  List<DropdownMenuItem> categoryLevelDropDowns = [];
  /// The currently selected category level
  String categoryLevelSelection = "5";
  /// the available sorting orders
  Map<KanjiSorting, String> kanjiSortingToString = {
    KanjiSorting.strokesAsc : "Strokes ↑", KanjiSorting.strokesDsc : "Strokes ↓",
    KanjiSorting.freqAsc    : "${LocaleKeys.DictionaryScreen_kanji_frequency.tr()} ↑"  , KanjiSorting.freqDsc : "${LocaleKeys.DictionaryScreen_kanji_frequency.tr()} ↓",
    KanjiSorting.rtkAsc     : "RTK ↑"    , KanjiSorting.rtkDsc : "RTK ↓",
    KanjiSorting.klcAsc     : "KLC ↑"    , KanjiSorting.klcDsc : "KLC ↓"
  };
  /// [DropdownMenuItem]s for the sorting selction
  List<DropdownMenuItem> sortingDropDowns = [];
  /// The currently selected sorting order
  KanjiSorting sortingSelection = KanjiSorting.strokesAsc;
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

    // get the available levels for the current category
    var k = GetIt.I<Isars>().dictionary.kanjidic2s; QueryBuilder<Kanjidic2, int, QQueryOperations>? query;
    switch (categorySelection) {
      case KanjiCategory.jlpt:
        query = k.where().distinctByJlptNew().jlptNewProperty();
        break;
      case KanjiCategory.rtk:
        categoryLevels = List.generate(30, (i) => "${1+i*100}-${i*100+100}");
        break;
      case KanjiCategory.school:
        query = k.where().distinctByGrade().gradeProperty();
        break;
      case KanjiCategory.freq:
        categoryLevels = List.generate(26, (i) => "${1+i*100}-${i*100+100}");
        break;
      case KanjiCategory.klc:
        categoryLevels = List.generate(23, (i) => "${1+i*100}-${i*100+100}");
        break;
      case KanjiCategory.kentei:
        categoryLevels = ["1", "1.5", "2", "2.5", "3", "4", "5", "6", "7", "8", "9", "10"];
        break;
      case KanjiCategory.wanikani:
        query = k.where().distinctByWanikani().wanikaniProperty();
        break;
    }
    if(query != null){
      categoryLevels = (query.findAllSync()..sort((b, a) => a.compareTo(b))).map((e) => e.toString()).toList();
    }
    if(changedCategories){
      categoryLevelSelection = categoryLevels.first;
      changedCategories = false;
    }
    categoryLevels.remove("-1");

    // find all kanji for the current selection
    kanjis = GetIt.I<Isars>().dictionary.kanjidic2s.filter()
      .optional(categorySelection == KanjiCategory.jlpt, (q) => q.jlptNewEqualTo(int.parse(categoryLevelSelection)))
      .optional(categorySelection == KanjiCategory.rtk, (q) => q.rtkNewBetween(
        int.parse(categoryLevelSelection.substring(0, categoryLevelSelection.indexOf("-"))),
        int.parse(categoryLevelSelection.substring(categoryLevelSelection.indexOf("-")+1))
      ))
      .optional(categorySelection == KanjiCategory.school, (q) => q.gradeEqualTo(int.parse(categoryLevelSelection)))
      .optional(categorySelection == KanjiCategory.freq, (q) => q.frequencyBetween(
        int.parse(categoryLevelSelection.substring(0, categoryLevelSelection.indexOf("-"))),
        int.parse(categoryLevelSelection.substring(categoryLevelSelection.indexOf("-")+1))
      ))
      .optional(categorySelection == KanjiCategory.klc, (q) => q.klcBetween(
        int.parse(categoryLevelSelection.substring(0, categoryLevelSelection.indexOf("-"))),
        int.parse(categoryLevelSelection.substring(categoryLevelSelection.indexOf("-")+1))
      ))
      .optional(categorySelection == KanjiCategory.kentei, (q) => q.kankenEqualTo(double.parse(categoryLevelSelection)))
      .optional(categorySelection == KanjiCategory.wanikani, (q) => q.wanikaniEqualTo(int.parse(categoryLevelSelection)))
    // apply sorting
    .optional(sortingSelection == KanjiSorting.strokesAsc, (q) => q.sortByStrokeCount())
    .optional(sortingSelection == KanjiSorting.strokesDsc, (q) => q.thenByStrokeCountDesc())
    .optional(sortingSelection == KanjiSorting.freqAsc,    (q) => q.thenByFrequency())
    .optional(sortingSelection == KanjiSorting.freqDsc,    (q) => q.thenByFrequencyDesc())
    .optional(sortingSelection == KanjiSorting.rtkAsc,     (q) => q.thenByRtkNew())
    .optional(sortingSelection == KanjiSorting.rtkDsc,     (q) => q.thenByRtkNewDesc())
    .optional(sortingSelection == KanjiSorting.klcAsc,     (q) => q.thenByKlc())
    .optional(sortingSelection == KanjiSorting.klcDsc,     (q) => q.thenByKlcDesc())
    .findAllSync();
  }

  /// Init the dropdowns for filtering / sorting the kanji tables
  void initDropDowns(){
    // categories the user can select
    categoryDropDowns = List.generate(KanjiCategory.values.length, (index) => 
      DropdownMenuItem<KanjiCategory>(
        value: KanjiCategory.values[index],
        child: Text("${kanjiCategoryToString[KanjiCategory.values[index]]}",)
      )
    );

    // the levels of the categories
    categoryLevelDropDowns = List.generate(categoryLevels.length, (index) => 
      DropdownMenuItem(
        value: categoryLevels[index],
        child: Text(categoryLevels[index])
      )
    );

    // sortings
    sortingDropDowns = List.generate(KanjiSorting.values.length, (index) => 
      DropdownMenuItem(
        value: KanjiSorting.values[index],
        child: Text("${kanjiSortingToString[KanjiSorting.values[index]]}")
      )
    );
  }

  /// Save the current settings to disk
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
                  style: TextStyle(
                    color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black
                  ),
                  onChanged: (value) async {
                    setState(() {
                      categorySelection = value;
                      changedCategories = true;
                      updateKanjisAndCategories();
                      initDropDowns();
                    });
                    await saveCurrentConfig();
                  },
                  selectedItemBuilder: (context) {
                    return KanjiCategory.values.map<Widget>((KanjiCategory item) {
                      return Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          kanjiCategoryToString[item]!,
                          style: const TextStyle(color: Colors.white,),
                        ),
                      );
                    }).toList();
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
                  selectedItemBuilder: (context) {
                    return categoryLevels.map<Widget>((String item) {
                      return Container(
                        alignment: Alignment.centerLeft,
                        constraints: const BoxConstraints(minWidth: 50),
                        child: Text(
                          item,
                          style: const TextStyle(color: Colors.white,),
                        ),
                      );
                    }).toList();
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
                  selectedItemBuilder: (context) {
                    return KanjiSorting.values.map<Widget>((KanjiSorting item) {
                      return Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          kanjiSortingToString[item]!,
                          style: const TextStyle(color: Colors.white,),
                        ),
                      );
                    }).toList();
                  },
                ),
              ),
              const Spacer(),
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
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
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
                  duration: const Duration(milliseconds: 300),
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
                              style: const TextStyle(
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
