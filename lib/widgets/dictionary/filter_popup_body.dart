import 'package:flutter/material.dart';

import 'package:quiver/iterables.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:da_kanji_mobile/data/dictionary_filters/filter_options.dart';
import 'package:da_kanji_mobile/globals.dart';
import 'package:da_kanji_mobile/locales_keys.dart';



class FilterPopupBody extends StatefulWidget {

  /// height of the popup
  final double height;
  /// the text controller of the search bar
  final TextEditingController searchController;

  const FilterPopupBody(
    {
      required this.height,
      required this.searchController,
      super.key
    }
  );

  @override
  State<FilterPopupBody> createState() => _FilterPopupBodyState();
}

class _FilterPopupBodyState extends State<FilterPopupBody> {

  /// List of all selected filters
  List<String> selectedFilters = [];
  /// Are currently all filters being shown
  bool showMore = false;
  /// The map of currently selectable filters
  Map<String, String> currentFilter = jmDictPosGeneralSorted; 


  @override
  void initState() {
    
    // get current filters from search bar
    selectedFilters = widget.searchController.text.split(" ")
      .where((e) => e.startsWith("#"))
      .map((e) => e.replaceAll("#", ""))
      .toList();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    int crossAxisCount = max([MediaQuery.of(context).size.width ~/ 200, 1])!;

    return Container(
      height: widget.height,
      child: Column(
        children: [
          const SizedBox(height: 8,),
          Expanded(
            child: AnimationLimiter(
              child: GridView.builder(
                clipBehavior: Clip.hardEdge,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  childAspectRatio: (MediaQuery.of(context).size.width / crossAxisCount) /
                    (MediaQuery.of(context).size.height / 10),
                  crossAxisSpacing: 4,
                  mainAxisSpacing: 4
                ),
                itemCount: currentFilter.length+1,
                itemBuilder: (context, index) {
            
                  MapEntry<String, String> item = const MapEntry("", "");
            
                  int cnt = 0;
                  for (MapEntry<String, String> i in currentFilter.entries) {
                    if (cnt == index) {
                      item = i;
                      break;
                    }
                    cnt++;
                  }
          
                  if(item .key != "") {
                    return AnimationConfiguration.staggeredGrid(
                      position: index, 
                      columnCount: crossAxisCount, 
                      child: ScaleAnimation(
                        key: Key(item.key),
                        child: Container(
                          decoration: BoxDecoration(
                            color: selectedFilters.contains(item.key)
                              ? g_Dakanji_green.withOpacity(0.5)
                              : null,
                            border: Border.all(
                              color: Colors.grey.withOpacity(0.5),
                            ),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: InkWell(
                            onTap: selectedFilters.contains(item.key)
                              // deselect a filter
                              ? () {
                                widget.searchController.text = widget.searchController.text
                                  .replaceAll("#${item.key} ", "");
                                setState(() {
                                  selectedFilters.remove(item.key);
                                });
                              }
                              // select a filter
                              : () {
                                String newText = "#${item.key} ${widget.searchController.text}";
                                selectedFilters.add(item.key);
                                setState(() {
                                  widget.searchController.text = newText;
                                });
                              },
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  item.value,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: selectedFilters.contains(item.key)
                                      ? Theme.of(context).brightness == Brightness.dark
                                        ? Colors.white.withOpacity(0.5)
                                        : Colors.black.withOpacity(0.5)
                                      : Theme.of(context).brightness == Brightness.dark
                                        ? Colors.white
                                        : Colors.black
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    );
                  }
                  return null;
                }
              ),
                
            ),
          ),
          Row(
            children: [
              const Flexible(
                flex: 1,
                child: Center(child: SizedBox())
              ),
              Flexible(
                flex: 1,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Material(
                      color: Colors.transparent,
                      child: Ink(
                        decoration: BoxDecoration(
                          color: g_Dakanji_green,
                          borderRadius: BorderRadius.circular(5000)
                        ),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          borderRadius: BorderRadius.circular(5000),
                          highlightColor: g_Dakanji_green.withOpacity(0.2),
                          child: SizedBox(
                            height: 24,
                            width: 100,
                            child: Center(
                              child: Text(
                                LocaleKeys.DictionaryScreen_search_filter_ok.tr(),
                                style: const TextStyle(
                                  color: Colors.white
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        showMore = !showMore;
                        currentFilter = showMore
                          ? jmDictAllFiltersSorted
                          : jmDictPosGeneralSorted;
                      });
                    },
                    icon: Icon(showMore ? Icons.expand_less : Icons.expand_more)
                  ),
                ),
              ),
            ]
          ),
        ],
      ),
    );
  }
}