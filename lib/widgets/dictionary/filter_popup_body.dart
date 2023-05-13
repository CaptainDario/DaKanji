import 'package:flutter/material.dart';

import 'package:quiver/iterables.dart';

import 'package:da_kanji_mobile/data/dictionary_filters/filter_options.dart';



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
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 4, 0 ,0),
      child: Container(
        height: widget.height,
        child: GridView(
          clipBehavior: Clip.hardEdge,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: MediaQuery.of(context).size.width /
              (MediaQuery.of(context).size.height / 8),
            crossAxisSpacing: 4,
            mainAxisSpacing: 4
          ),
          children: [
            for(var pair in zip([jmDictFieldsSorted.entries, jmDictPosSorted.entries]))
              for (var item in pair)
                item.value != ""
                  ? ElevatedButton(
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Text(
                        item.value,
                        style: TextStyle(
                          fontSize: 14
                        ),
                      ),
                    ),
                    onPressed: () {
                      String newText = "#${item.key} ${widget.searchController.text}";
                      setState(() {
                        widget.searchController.text = newText;
                        //updateSearchResults(newText, widget.allowDeconjugation);
                      });
                    },
                  )
                  : Container(),
          ]
        ),
      ),
    );
  }
}