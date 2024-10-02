// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:da_kanji_mobile/entities/dojg/dojg_entry.dart';
import 'package:da_kanji_mobile/entities/dojg/dojg_search_provider.dart';
import 'package:da_kanji_mobile/entities/isar/isars.dart';
import 'package:da_kanji_mobile/entities/show_cases/tutorials.dart';
import 'package:da_kanji_mobile/globals.dart';
import 'package:da_kanji_mobile/locales_keys.dart';
import 'package:da_kanji_mobile/widgets/dojg/dojg_entry_card.dart';

class DojgEntryList extends StatefulWidget {

  /// A search term that should be the initial search
  final String? initialSearch;
  /// Should the first result of the initial search be openend (if one exists)
  final bool openFirstResult;
  /// should the tutorial be included
  final bool includeTutorial;
  /// should the filters for the volumes be included
  final bool includeVolumeTags;
  /// Callback that is called when the user taps on this card. provides
  /// the `this.dojgEntry` as parameter
  final Function(DojgEntry dojgEntry)? onTap;


  const DojgEntryList(
    {
      this.initialSearch,
      this.openFirstResult = false,
      this.includeTutorial = false,
      this.includeVolumeTags = true,
      this.onTap,
      super.key
    }
  );

  @override
  State<DojgEntryList> createState() => _DojgEntryListState();
}

class _DojgEntryListState extends State<DojgEntryList> {

  /// all dojg entries that are currently being shown
  List<DojgEntry> currentEntries = [];
  /// a list of the volume tags of the dojg volumes
  List<String> volumeTags = ["㊤", "㊥", "㊦"];
  /// the state of the shown / not shown volumes
  List<bool> currentVolumeSelection = [true, true, true];
  /// the text that is currently in the search bar
  String currentSearch = "";
  /// The text controller of the search text box
  TextEditingController searchTextEditingController = TextEditingController();
  /// Has the initial search been read
  bool readInitialSearch = false;


  @override
  void initState() {

    if(widget.initialSearch != null){
      currentSearch = widget.initialSearch!;
      searchTextEditingController.text = currentSearch;
    }

    updateSearchResults();

    if(widget.openFirstResult){
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        widget.onTap?.call(currentEntries[0]);
      });
      
    }

    super.initState();
  }

  @override
  void didUpdateWidget(covariant DojgEntryList oldWidget) {
    updateSearchResults();
    super.didUpdateWidget(oldWidget);
  }

  /// updates the DoJG search results
  void updateSearchResults() {
    // if no volume is selected do not show anything
    if(currentVolumeSelection.where((e) => e).isEmpty){
      currentEntries = [];
    }
    else{
      currentSearch = currentSearch.trim();
      currentEntries = GetIt.I<Isars>().dojg!.dojgEntrys.filter()
        // show only entries of currently selected volumes
        .anyOf(volumeTags.indexed.where((e) => currentVolumeSelection[e.$1]),
          (q, tag) => q.volumeTagEqualTo(tag.$2))
        //
        .optional(currentSearch != "", (q) => 
          q.grammaticalConceptContains(currentSearch, caseSensitive: false)
            .or()
          .usageContains(currentSearch, caseSensitive: false)
        )
        .findAllSync();
      // sort entries when no filter has been applied
      if(currentSearch.isEmpty){
        
      }
      // sort entries when a filter has been applied
      else {
        sortFilteredEntries();
      }
    }
  }

  /// Sorts all entries by the following rule
  /// 1. By first character
  /// 2. By DoJG volume tag
  /// 3. by DoJG page
  void sortAllEntries(){
    currentEntries.sort(((a, b) {
      // first by the starting kana
      if(a.grammaticalConcept[0].compareTo(b.grammaticalConcept[0]) != 0) {
        return a.grammaticalConcept[0].compareTo(b.grammaticalConcept[0]);
      }
      // then by tag
      else if (a.volumeTag.compareTo(b.volumeTag) != 0) {
        return a.volumeTag[0].compareTo(b.volumeTag[0]);
      // then by the page
      }
      else {
        return a.page.compareTo(b.page);
      }
    }));
  }

  /// Sorts entries when a filter has been applied. Sorts first by
  /// 1. Full match
  /// 2. Match starts at the beginning
  /// 3. Matches somwhere
  /// Then those are sorted by length
  void sortFilteredEntries(){
    List<DojgEntry> full = [], start = [], other = [];
    for (var i = 0; i < currentEntries.length; i++) {

      String gC = currentEntries[i].grammaticalConcept
        .replaceAll(RegExp(r"[(|（|)|）|～|~|\d|\s]"), "");
      List<String> gCs = gC.split(RegExp(r"[・|/|]／"));

      if(gCs.any((e) => e == currentSearch)){
        full.add(currentEntries[i]);
      }
      else if(gCs.any((e) => e.startsWith(currentSearch))){
        start.add(currentEntries[i]);
      }
      else {
        other.add(currentEntries[i]);
      }
    }
    currentEntries = 
      (full..sort(((a, b) {
        return a.grammaticalConcept.length.compareTo(b.grammaticalConcept.length);
      }))) +
      (start..sort(((a, b) {
        return a.grammaticalConcept.length.compareTo(b.grammaticalConcept.length);
      }))) + 
      (other..sort(((a, b) {
        return a.grammaticalConcept.length.compareTo(b.grammaticalConcept.length);
      })));
  }

  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider<DojgSearch>(
      create: (context) => DojgSearch(),
      builder: (context, child) {
        
        // get the initial search once
        if(!readInitialSearch && widget.initialSearch != null){
          readInitialSearch = true;
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            context.read<DojgSearch>().currentSearchTerm = currentSearch;
          });
        }
        // update the current search if it changed
        else if(searchTextEditingController.text != context.watch<DojgSearch>().currentSearchTerm){
          currentSearch = context.watch<DojgSearch>().currentSearchTerm;
          searchTextEditingController.text = currentSearch;
          updateSearchResults();
        }
        return Align(
          alignment: Alignment.topCenter,
          child: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                floating: true,
                title: Row(
                  children: [
                    Expanded(
                      child: Focus(
                        focusNode: widget.includeTutorial
                          ? GetIt.I<Tutorials>().dojgScreenTutorial.focusNodes![1]
                          : null,
                        child: TextField(
                          controller: searchTextEditingController,
                          autocorrect: false,
                          maxLines: 1,
                          style: const TextStyle(
                            fontFamily: g_japaneseFontFamily,
                            color: Colors.white
                          ),
                          decoration: InputDecoration(
                            hintText: LocaleKeys.DojgScreen_dojg_search.tr(),
                            hintStyle: const TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          onChanged: (value) {
                            context.read<DojgSearch>().currentSearchTerm = value;
                            currentSearch = value;
                            setState(() {
                              updateSearchResults();
                            });
                          },
                        ),
                      )
                    ),
                    const SizedBox(width: 50,),
                    Focus(
                      focusNode: widget.includeTutorial
                        ? GetIt.I<Tutorials>().dojgScreenTutorial.focusNodes![2]
                        : null,
                      child: widget.includeVolumeTags
                        ? SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              ToggleButtons(
                                renderBorder: false,
                                isSelected: currentVolumeSelection,
                                fillColor: Colors.transparent,
                                hoverColor: Colors.grey.withOpacity(0.2),
                                selectedColor: Colors.white,
                                color: Colors.grey.withOpacity(0.4),
                                onPressed: (index) {
                                  setState(() {
                                    currentVolumeSelection[index] = !currentVolumeSelection[index];
                                    updateSearchResults();
                                  });
                                },
                                children: [
                                  for (int i = 0; i < 3; i++)
                                    Text(
                                      volumeTags[i],
                                      textScaler: const TextScaler.linear(1.25),
                                    )
                                ],
                              ),
                            ],
                          ),
                        )
                        : const SizedBox(),
                    )
                  ]
                )
              ),
              SliverList.separated(
                itemCount: currentEntries.length,
                separatorBuilder: (context, i) {
                  // hide separators when the user searched smth
                  if(currentSearch.isNotEmpty) return const SizedBox();
                  
                  if(i < currentEntries.length && currentEntries[i].grammaticalConcept[0] !=
                    currentEntries[i+1].grammaticalConcept[0]) {
                    return Text(
                      " ${currentEntries[i+1].grammaticalConcept[0]}",
                      textScaler: const TextScaler.linear(1.5),
                    );
                  } else {
                    return const SizedBox();
                  }
                },
                itemBuilder: (context, i) {
                  return Focus(
                    focusNode: widget.includeTutorial && i == 0
                      ? GetIt.I<Tutorials>().dojgScreenTutorial.focusNodes![3]
                      : null,
                    child: DojgEntryCard(
                      currentEntries[i],
                      onTap: (entry) {
                        widget.onTap?.call(currentEntries[i]);
                      },
                    ),
                  );
                }
              )
            ],
          ),
        );
      },
    );
  }
}
