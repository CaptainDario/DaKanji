import 'package:da_kanji_mobile/globals.dart';
import 'package:flutter/material.dart';

import 'package:isar/isar.dart';

import 'package:da_kanji_mobile/application/radicals/radk.dart' as radk;



/// Popup body of the popup to select radicals
class RadicalPopupBody extends StatefulWidget {

  /// height of the popup
  final double height;
  /// the isar instance with the radicals data
  final Isar kradIsar;

  final TextEditingController searchController;
  
  const RadicalPopupBody(
    {
      required this.height,
      required this.kradIsar,
      required this.searchController,
      super.key
    }
  );

  @override
  State<RadicalPopupBody> createState() => _RadicalPopupBodyState();
}

class _RadicalPopupBodyState extends State<RadicalPopupBody> {

  /// all radicals that are currently selected
  List<String> selectedRadicals = [];
  /// all radicals that are possible to select (they can be used to build a kanji)
  List<String> possibleRadicals = [];
  /// all kanjis that use all selected radicals
  List<String> kanjisThatUseAllRadicals = [];


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: widget.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// all kanjis that use the selected radicals
            Container(
              height: widget.height/4,
              child: SingleChildScrollView(
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    for (String kanji in kanjisThatUseAllRadicals)
                      ElevatedButton(
                        onPressed: () {
                          widget.searchController.text += kanji;
                        },
                        child: Text(
                          kanji,
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      )
                  ],
                ),
              ),
            ),

            SizedBox(height: 8),
            Divider(),
            SizedBox(height: 8),
            
            /// all radicals
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    for (MapEntry krad in radk.getRadicalsByStrokeOrder(widget.kradIsar).entries)
                      ...[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16.0, 0, 0, 4),
                          child: Text(
                            krad.key.toString(),
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                        Wrap(
                          spacing: 4,
                          runSpacing: 4,
                          crossAxisAlignment: WrapCrossAlignment.start,
                          alignment: WrapAlignment.start,
                          runAlignment: WrapAlignment.start,
                          children: [
                            for (String radical in krad.value)
                              if(possibleRadicals.contains(radical) ||
                                selectedRadicals.contains(radical) ||
                                possibleRadicals.isEmpty)
                                InputChip(
                                  label: Text(radical),
                                  selectedColor: g_Dakanji_green,
                                  selected: selectedRadicals.contains(radical),
                                  showCheckmark: false,
                                  isEnabled: possibleRadicals.contains(radical) ||
                                    selectedRadicals.contains(radical) ||
                                    possibleRadicals.isEmpty,
                                  disabledColor: Colors.grey[800],
                                  onSelected: (bool value) {
                                    // mark this chip as selected
                                    if(selectedRadicals.contains(radical))
                                      selectedRadicals.remove(radical);
                                    else
                                      selectedRadicals.add(radical);

                                    // find all kanji that use this
                                    kanjisThatUseAllRadicals =
                                      radk.getKanjisByRadical(selectedRadicals, widget.kradIsar);

                                    possibleRadicals =
                                      radk.getPossibleRadicals(selectedRadicals, widget.kradIsar);

                                    setState(() {});
                                  },
                                )
                          ]
                        ),
                        SizedBox(height: 16)
                      ]
                  ],
                ),
              ),
            ),
          ],
        )
      ),
    );
  }
}