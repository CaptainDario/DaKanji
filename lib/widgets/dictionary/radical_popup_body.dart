// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:database_builder/database_builder.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:isar/isar.dart';

// Project imports:
import 'package:da_kanji_mobile/globals.dart';
import 'package:da_kanji_mobile/locales_keys.dart';
import 'package:da_kanji_mobile/repositories/radicals/radicals.dart' as radk;

/// Popup body of the popup to select radicals
class RadicalPopupBody extends StatefulWidget {

  /// height of the popup
  final double height;
  /// the isar instance with the kanji -> radicals data
  final IsarCollection<Radk> radkIsar;
  /// the isar instace with the radical -> kanji data
  final IsarCollection<Krad> kradIsar;
  /// the text controller of the search bar
  final TextEditingController searchController;
  
  const RadicalPopupBody(
    {
      required this.height,
      required this.radkIsar,
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
  List<List<String>> kanjisThatUseAllRadicals = [];
  /// temporary storage of kanjis when new radicals have been selected
  List<List<String>> newKanjisThatUseAllRadicals = [];
  /// radicals sorted by stroke order and returns a map of this
  late Map<int, List<String>> radicalsByStrokeOrder;
  /// Is the kanji part of the popup larger
  bool kanjiIsFullscreen = false;

  bool animateKanjiOut = false;


  @override
  void initState() {
    
    radicalsByStrokeOrder = radk.getRadicalsByStrokeOrder(widget.radkIsar);
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    int noKanjiButtons = MediaQuery.of(context).size.width~/80;

    return SizedBox(
      height: widget.height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 8,),
          /// all kanjis that use the selected radicals
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            onEnd: () {
              if(animateKanjiOut){
                setState(() {
                  kanjisThatUseAllRadicals = newKanjisThatUseAllRadicals;
                  animateKanjiOut = false;
                  newKanjisThatUseAllRadicals.clear();
                });
              }
            },
            height: !kanjiIsFullscreen
              ? kanjisThatUseAllRadicals.isEmpty || animateKanjiOut
                ? 0
                : (MediaQuery.of(context).size.width) / noKanjiButtons 
              : widget.height * 3/5,
            child: kanjisThatUseAllRadicals.isEmpty && !animateKanjiOut
              ? const SizedBox()
              : AnimationLimiter(
                child: MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  removeBottom: true,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: kanjisThatUseAllRadicals.length,
                    itemBuilder: (context, strokeIndex) {
                      return Column(
                        children: [
                          Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(16.0, 0, 0, 6),
                            child: Text(
                              "${strokeIndex+1}",
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                        ),
                          GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: noKanjiButtons,
                              //crossAxisSpacing: 8,
                              //mainAxisSpacing: 8
                            ),
                            itemCount: kanjisThatUseAllRadicals[strokeIndex].length,
                            itemBuilder: (context, index) {
                              return AnimationConfiguration.staggeredGrid(
                                position: index,
                                columnCount: noKanjiButtons,
                                child: ScaleAnimation(
                                  child: Card(
                                    child: InkWell(
                                      onTap: () {
                                        widget.searchController.text += kanjisThatUseAllRadicals[strokeIndex][index];
                                      },
                                      borderRadius: BorderRadius.circular(8),
                                      child: Center(
                                        child: Text(
                                          kanjisThatUseAllRadicals[strokeIndex][index],
                                          style: TextStyle(
                                            fontSize: 28,
                                            fontFamily: g_japaneseFontFamily,
                                            color: Theme.of(context).brightness == Brightness.dark ?
                                              Colors.white
                                              : Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      );
                    }
                  ),
                ),
              ),
          ),

          const SizedBox(height: 4),
          const Divider(),
          const SizedBox(height: 4),
          
          /// all radicals
          Expanded(
            child: AnimationLimiter(
              child: MediaQuery.removePadding(
                context: context,
                removeTop: true,
                removeBottom: true,
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
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                        ),
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
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
                              possibleRadicals.isEmpty)) {
                              return AnimationConfiguration.staggeredGrid(
                                position: index,
                                columnCount: MediaQuery.of(context).size.width~/50,
                                child: ScaleAnimation(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: selectedRadicals.contains(krad.value[index])
                                        ? g_Dakanji_green.withValues(alpha: 0.5)
                                        : null,
                                      border: Border.all(
                                        color: Colors.grey.withValues(alpha: 0.5),
                                      ),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: InkWell(
                                      onTap: possibleRadicals.contains(krad.value[index]) ||
                                        selectedRadicals.contains(krad.value[index]) ||
                                        possibleRadicals.isEmpty
                                      ? () {
                                        // mark this chip as selected
                                        if(selectedRadicals.contains(krad.value[index])){
                                          selectedRadicals.remove(krad.value[index]);
                                        }
                                        else {
                                          selectedRadicals.add(krad.value[index]);
                                        }
                                  
                                        updateKanjiWithRadicalSelection();
                                      }
                                      : null,
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          krad.value[index],
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontFamily: g_japaneseFontFamily,
                                            color: selectedRadicals.contains(krad.value[index])
                                              ? Theme.of(context).brightness == Brightness.dark
                                                ? Colors.white.withValues(alpha: 0.5)
                                                : Colors.black.withValues(alpha: 0.5)
                                              : Theme.of(context).brightness == Brightness.dark
                                                ? Colors.white
                                                : Colors.black
                                          )
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }
                            // radical that cannot be selected because there are no 
                            // kanjis that use this one + all selected
                            else {
                              return Center(
                                child: Text(
                                  krad.value[index],
                                  style: const TextStyle(color: Colors.grey),
                                ),
                              );
                            }
                          },
                        ),
                        const SizedBox(height: 16)
                      ]
                    );
                  },
                ),
              ),
            ),
          ),
        
          // ok / maximixe / clear / paste buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if(MediaQuery.of(context).size.width > 400)
                const Flexible(
                  flex: 1,
                  child: Center(
                    child: SizedBox(),
                  )
                ),
              // ok button
              Flexible(
                fit: FlexFit.tight,
                flex: 1,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
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
                          highlightColor: g_Dakanji_green.withValues(alpha: 0.2),
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
                )
              ),
              Flexible(
                flex: 1,
                child: Center(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // maximize button
                        IconButton(
                          onPressed: () {
                            setState(() {
                              kanjiIsFullscreen = !kanjiIsFullscreen;
                            });
                          },
                          icon: Icon(kanjiIsFullscreen ? Icons.fullscreen : Icons.fullscreen_exit)
                        ),
                        // paste button
                        IconButton(
                          icon: const Icon(Icons.paste),
                          onPressed: () async {
                            // get radicals in clipboard
                            String buffer = (await Clipboard.getData(Clipboard.kTextPlain))?.text ?? "";
                            List<String> availableRadicals = radk.getRadicalsString(widget.radkIsar);
                            List<String> bufferRadicals = buffer.split("")
                              .where((b) => availableRadicals.contains(b)).toList();
                            
                            if(bufferRadicals.isEmpty){
                              return;
                            }
                    
                            // set new selection
                            selectedRadicals = bufferRadicals;
                            updateKanjiWithRadicalSelection();
                          },
                        ),
                        // icons clear
                        IconButton(
                          onPressed: () {
                            setState(() {
                              animateKanjiOut = true;
                              possibleRadicals.clear();
                              selectedRadicals.clear();
                            });
                          },
                          icon: const Icon(Icons.clear)
                        ),
                      ],
                    ),
                  ),
                )
              ),
            ],
          )
        ],
      )
    );
  }

  /// Updates the currently found kanji using the currently selected radicals
  void updateKanjiWithRadicalSelection(){
    setState(() {
      possibleRadicals = radk.getPossibleRadicals(
        selectedRadicals, widget.kradIsar, widget.radkIsar
      );
      // find all kanji that use this
      newKanjisThatUseAllRadicals = radk.getKanjisByRadical(
          selectedRadicals, widget.kradIsar,
        );

      // if there are no kanjis, hide the kanji preview
      if(newKanjisThatUseAllRadicals.isEmpty){
        animateKanjiOut = true;
        kanjisThatUseAllRadicals = const [];
      }
      else{
        kanjisThatUseAllRadicals = newKanjisThatUseAllRadicals;
      }
    });
  }
}
