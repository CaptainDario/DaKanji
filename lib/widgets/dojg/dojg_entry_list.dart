import 'package:da_kanji_mobile/application/dojg/dojg_search_provider.dart';
import 'package:flutter/material.dart';

import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:da_kanji_mobile/domain/dojg/dojg_entry.dart';
import 'package:da_kanji_mobile/domain/isar/isars.dart';
import 'package:da_kanji_mobile/widgets/dojg/dojg_entry_card.dart';
import 'package:da_kanji_mobile/globals.dart';



class DojgEntryList extends ConsumerStatefulWidget {

  /// Callback that is called when the user taps on this card. provides
  /// the `this.dojgEntry` as parameter
  final Function(DojgEntry dojgEntry)? onTap;


  const DojgEntryList(
    {
      this.onTap,
      super.key
    }
  );

  @override
  ConsumerState<DojgEntryList> createState() => _DojgEntryListState();
}

class _DojgEntryListState extends ConsumerState<DojgEntryList> {

  /// all dojg entries that are currently being shown
  List<DojgEntry> currentEntries = [];
  /// a list of the volume tags of the dojg volumes
  List<String> volumeTags = ["㊤", "㊥", "㊦"];
  /// the state of the shown / not shown volumes
  List<bool> currentVolumeSelection = [true, true, true];
  /// the text that is currently in the search bar
  String currentSearch = "";

  TextEditingController searchTextEditingController = TextEditingController();


  @override
  void initState() {
    updateSearchResults();
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
      String _currentSearch = currentSearch.trim();
      currentEntries = GetIt.I<Isars>().dojg!.dojgEntrys.filter()
        // show only entries of currently selected volumes
        .anyOf(volumeTags.indexed.where((e) => currentVolumeSelection[e.$1]),
          (q, tag) => q.volumeTagEqualTo(tag.$2))
        //
        .optional(_currentSearch != "", (q) => 
          q.grammaticalConceptContains(_currentSearch, caseSensitive: false)
            .or()
          .usageContains(_currentSearch, caseSensitive: false)
        )
        .findAllSync()
      // sort found entries
      ..sort(((a, b) {
        // first by the starting kana
        if(a.grammaticalConcept[0].compareTo(b.grammaticalConcept[0]) != 0) {
          return a.grammaticalConcept[0].compareTo(b.grammaticalConcept[0]);
        } else if (a.volumeTag.compareTo(b.volumeTag) != 0) {
          return a.volumeTag[0].compareTo(b.volumeTag[0]);
        // then by the page
        } else {
          return a.page.compareTo(b.page);
        }
      }));
    }
  }


  @override
  Widget build(BuildContext context) {

    currentSearch = ref.watch(dojgSearchProvider);
    
    if(searchTextEditingController.text != ref.watch(dojgSearchProvider)){
      currentSearch = ref.watch(dojgSearchProvider);
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
                  child: TextField(
                    controller: searchTextEditingController,
                    autocorrect: false,
                    maxLines: 1,
                    style: const TextStyle(
                      fontFamily: g_japaneseFontFamily
                    ),
                    decoration: InputDecoration(
                      hintText: "Search...",
                      hintStyle: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    onChanged: (value) {
                      ref.read(dojgSearchProvider.notifier).setCurrentSearchTerm(value);
                      setState(() {
                        updateSearchResults();
                      });
                    },
                  )
                ),
                const SizedBox(width: 50,),
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
                        textScaleFactor: 1.25,
                      )
                  ],
                )
              ]
            )
          ),
          SliverList.separated(
            itemCount: currentEntries.length,
            separatorBuilder: (context, i) {
              if(i < currentEntries.length && currentEntries[i].grammaticalConcept[0] !=
                currentEntries[i+1].grammaticalConcept[0]) {
                return Text(currentEntries[i+1].grammaticalConcept[0]);
              } else {
                return const SizedBox();
              }
            },
            itemBuilder: (context, i) {
              return DojgEntryCard(
                currentEntries[i],
                onTap: (entry) {
                  widget.onTap?.call(currentEntries[i]);
                },
              );
            }
          )
            
        ],
      ),
    );
  }
}