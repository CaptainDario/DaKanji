import 'package:flutter/material.dart';

import 'package:quiver/iterables.dart';

import 'package:da_kanji_mobile/data/dictionary_filters/filter_options.dart';
import 'package:da_kanji_mobile/globals.dart';



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
      height: widget.height*3/4,
      child: GridView.builder(
        clipBehavior: Clip.hardEdge,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          childAspectRatio: (MediaQuery.of(context).size.width / crossAxisCount) /
            (MediaQuery.of(context).size.height / 10),
          crossAxisSpacing: 4,
          mainAxisSpacing: 4
        ),
        itemCount: jmDictAllFiltersSorted.length+1,
        itemBuilder: (context, index) {

          MapEntry<String, String> item = MapEntry("", "");

          int cnt = 0;
          for (MapEntry<String, String> i in jmDictAllFiltersSorted.entries) {
            if (cnt == index) {
              item = i;
              break;
            }
            cnt++;
          }

          if(item.value != "")
            return Container(
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
                  ? () {
                    widget.searchController.text = widget.searchController.text
                      .replaceAll("#${item.key} ", "");
                    setState(() {
                      selectedFilters.remove(item.key);
                    });
                  }
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
                          ? Colors.grey
                          : Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black
                      ),
                    ),
                  ),
                ),
              ),
            );
        },
      ),
    );
  }
}