import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:isar/isar.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:da_kanji_mobile/globals.dart';
import 'package:da_kanji_mobile/application/radicals/radk.dart' as radk;
import 'package:da_kanji_mobile/locales_keys.dart';



/// Popup body of the popup to select radicals
class RadicalPopupBody extends StatefulWidget {

  /// height of the popup
  final double height;
  /// the isar instance with the radicals data
  final Isar kradIsar;
  /// the text controller of the search bar
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

  late Map<int, List<String>> radicalsByStrokeOrder;

  @override
  void initState() {
    
    radicalsByStrokeOrder = radk.getRadicalsByStrokeOrder(widget.kradIsar);
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    int noKanjiButtons = MediaQuery.of(context).size.width~/80;

    return Container(
      height: widget.height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 8,),
          /// all kanjis that use the selected radicals
          Container(
            height: (MediaQuery.of(context).size.width-(noKanjiButtons)*8) / noKanjiButtons,
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: noKanjiButtons,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8
              ),
              itemCount: kanjisThatUseAllRadicals.length,
              itemBuilder: (context, index) {
                return kanjisThatUseAllRadicals.length == 0 
                  ? Container()
                  : ElevatedButton(
                    onPressed: () {
                      widget.searchController.text += kanjisThatUseAllRadicals[index];
                    },
                    child: Text(
                      kanjisThatUseAllRadicals[index],
                      style: TextStyle(
                        fontSize: 28,
                        fontFamily: g_japaneseFontFamily,
                        color: Colors.white,
                      ),
                    ),
                  );
              },
            ),
          ),

          SizedBox(height: 4),
          Divider(),
          SizedBox(height: 4),
          
          /// all radicals
          Expanded(
            child: ListView.builder(
              
              itemCount: radicalsByStrokeOrder.entries.length,
              itemBuilder: (context, index) {

                var krad = radicalsByStrokeOrder.entries.toList()[index];

                return Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(16.0, 0, 0, 6),
                        child: Text(
                          krad.key.toString(),
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: MediaQuery.of(context).size.width~/50,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8
                      ),
                      itemCount: krad.value.length,
                      itemBuilder: (context, index) {
                        if(krad.value.length > index &&
                          (possibleRadicals.contains(krad.value[index]) ||
                          selectedRadicals.contains(krad.value[index]) ||
                          possibleRadicals.isEmpty))
                          return Container(
                            decoration: BoxDecoration(
                              color: selectedRadicals.contains(krad.value[index])
                                ? g_Dakanji_green.withOpacity(0.5)
                                : null,
                              border: Border.all(
                                color: Colors.grey.withOpacity(0.5),
                              ),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: InkWell(
                              onTap: possibleRadicals.contains(krad.value[index]) ||
                                selectedRadicals.contains(krad.value[index]) ||
                                possibleRadicals.isEmpty
                              ? () {
                                // mark this chip as selected
                                if(selectedRadicals.contains(krad.value[index]))
                                  selectedRadicals.remove(krad.value[index]);
                                else
                                  selectedRadicals.add(krad.value[index]);
                          
                                // find all kanji that use this
                                kanjisThatUseAllRadicals =
                                  radk.getKanjisByRadical(selectedRadicals, widget.kradIsar);
                          
                                possibleRadicals =
                                  radk.getPossibleRadicals(selectedRadicals, widget.kradIsar);
                          
                                setState(() {});
                              }
                              : null,
                              child: Center(
                                child: Text(
                                  krad.value[index],
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: g_japaneseFontFamily,
                                    color: selectedRadicals.contains(krad.value[index])
                                      ? Colors.grey
                                      : Theme.of(context).brightness == Brightness.dark
                                        ? Colors.white
                                        : Colors.black
                                  )
                                ),
                              ),
                            ),
                          );
                        // radical that cannot be selected because there are no 
                        // kanjis that use this one + all selected
                        else
                          return Container(
                            child: Center(
                              child: Text(
                                krad.value[index],
                                style: TextStyle(color: Colors.grey),
                              ),
                            )
                          );
                      },
                    ),
                    SizedBox(height: 16)
                  ]
                );
              },
            ),
          ),
        
          // ok / clear / paste buttons
          Stack(
            alignment: Alignment.center,
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    height: 30,
                    width: 100,
                    decoration: BoxDecoration(
                      color: g_Dakanji_green,
                      borderRadius: BorderRadius.circular(5000)
                    ),
                    child: Center(
                      child: Text(
                        LocaleKeys.DictionaryScreen_search_filter_ok.tr(),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 0,
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () async {
                        // get radicals in clipboard
                        String buffer = (await Clipboard.getData(Clipboard.kTextPlain))?.text ?? "";
                        List<String> availableRadicals = radk.getRadicalsString(widget.kradIsar);
                        List<String> bufferRadicals = buffer.split("")
                          .where((b) => availableRadicals.contains(b)).toList();
                        
                        // set new selection
                        selectedRadicals = bufferRadicals;
                        kanjisThatUseAllRadicals =
                          radk.getKanjisByRadical(selectedRadicals, widget.kradIsar);
                        possibleRadicals =
                          radk.getPossibleRadicals(selectedRadicals, widget.kradIsar);
                        
                        setState(() {});
                      },
                      icon: Icon(Icons.paste)
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          kanjisThatUseAllRadicals.clear();
                          possibleRadicals.clear();
                          selectedRadicals.clear();
                        });
                      },
                      icon: Icon(Icons.clear)
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      )
    );
  }
}