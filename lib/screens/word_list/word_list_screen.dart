// Flutter imports:
import 'package:da_kanji_mobile/globals.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:collection/collection.dart';
import 'package:database_builder/database_builder.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get_it/get_it.dart';
import 'package:tuple/tuple.dart';

// Project imports:
import 'package:da_kanji_mobile/entities/isar/isars.dart';
import 'package:da_kanji_mobile/entities/iso/iso_table.dart';
import 'package:da_kanji_mobile/entities/settings/settings.dart';
import 'package:da_kanji_mobile/entities/tree/tree_node.dart';
import 'package:da_kanji_mobile/entities/word_list/word_list_action.dart';
import 'package:da_kanji_mobile/entities/word_list/word_list_sorting.dart';
import 'package:da_kanji_mobile/entities/word_lists/word_list_types.dart';
import 'package:da_kanji_mobile/entities/word_lists/word_lists_data.dart';
import 'package:da_kanji_mobile/entities/word_lists/word_lists_queries.dart';
import 'package:da_kanji_mobile/entities/word_lists/word_lists_sql.dart';
import 'package:da_kanji_mobile/locales_keys.dart';
import 'package:da_kanji_mobile/screens/word_list/word_list_view_entry_screen.dart';
import 'package:da_kanji_mobile/widgets/dictionary/search_result_list.dart';
import 'package:da_kanji_mobile/widgets/word_lists/word_lists_selection_dialog.dart';

class WordListScreen extends StatefulWidget {

  /// the node of this word list
  final TreeNode<WordListsData> node;
  /// callback that is triggered when the user deletes a node
  final Function(JMdict entry)? onDelete;


  const WordListScreen(
    this.node,
    {
      required this.onDelete,
      super.key
    }
  );

  @override
  State<WordListScreen> createState() => _WordListScreenState();
}

class _WordListScreenState extends State<WordListScreen> {

  /// is this a default list
  bool isDefault = false;
  /// all entries of this list
  Stream<Iterable<JMdict>>? entriesStream;

  /// [FocusNode] of the search field
  FocusNode searchInputFocusNode = FocusNode();
  /// The [TextEditingController] to handle the search inputs
  TextEditingController searchTextEditingController = TextEditingController();
  /// Should the list be animated (slide in)
  bool animate = true;
  /// The current sorting order
  WordListSorting currentSorting = WordListSorting.dateDesc;


  @override
  void initState() {

    Future.delayed(
      const Duration(milliseconds: 200),
      () => setState(() {initStream();}));

    super.initState();
  }


  /// Returns the correct stream based on the current parameters
  Stream<Iterable<Tuple2<DateTime, int>>> getStream(){

    late Stream<Iterable<Tuple2<DateTime, int>>> idStream;

    // is this a default list
    if(widget.node.value.type == WordListNodeType.wordListDefault) {
      isDefault = true;
      idStream = const Stream.empty();
    }    
    // user list
    else{
      idStream = userListStream(widget.node.id);
    }

    return idStream;
  }

  /// Initializes the stream from which the elements of this word list are read
  void initStream() {

    String searchTerm = searchTextEditingController.text;
    entriesStream = getStream()
      // sort by date time if set
      .map((event) {

        if([WordListSorting.dateAsc, WordListSorting.dateDesc].contains(currentSorting)){
          event = event.sorted((a, b) {
            if(currentSorting == WordListSorting.dateDesc) (b, a) = (a, b);

            int comp = a.item1.compareTo(b.item1);
            if(comp == 0) comp = a.item2.compareTo(b.item2);

            return comp;
          });
        }

        return event;
      })
      // get all entries from the dictionary
      .map((e) {
        return GetIt.I<Isars>().dictionary.jmdict
          .getAllSync(e.map((e) => e.item2).toList())
          .nonNulls;
      })
      // apply search term
      .map((event) => 
        event.where((element) => 
          element.kanjis.any((kanji) => kanji.contains(searchTerm)) ||
          element.readings.any((reading) => reading.contains(searchTerm)) ||
          element.meanings.any((meaning) =>
            GetIt.I<Settings>().dictionary.selectedTranslationLanguages.contains(
              isoToiso639_1[meaning.language]!.name) && 
            meaning.meanings
              .any((m) =>
                m.attributes.any((a) => a?.contains(searchTerm) ?? false)
          )
        )
      ))
      // sort by frequency if set
      .map((event) {

        if([WordListSorting.freqAsc, WordListSorting.freqDesc].contains(currentSorting)){
          event = event.sorted((a, b) {
            if(currentSorting == WordListSorting.freqDesc) (b, a) = (a, b);

            return a.frequency.compareTo(b.frequency);
          });
        }

        return event;
      });
  }


  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(widget.node.value.name),
      ),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              automaticallyImplyLeading: false,
              floating: true,
              pinned: false,
              snap: true,
              title: Row(
                children: [
                  // search icon
                  IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      animate = false;
                      searchInputFocusNode.requestFocus();
                      setState(() {});
                    },
                  ),
                  const SizedBox(width: 16,),
                  // text input for searching
                  Expanded(
                    child: TextField(
                      controller: searchTextEditingController,
                      focusNode: searchInputFocusNode,
                      style: const TextStyle(color: Colors.white),
                      cursorColor: Colors.white,
                      decoration: const InputDecoration(
                        hintText: "Search...",
                        focusColor: Colors.white,
                        hoverColor: Colors.white,
                        hintStyle: TextStyle(color: Colors.grey),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)
                        ),
                        focusedErrorBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          animate = true;
                          initStream();
                        });
                      },
                    )
                  ),
                  const SizedBox(width: 16,),
                  // sort list
                  DropdownButton<WordListSorting>(
                    onChanged: (value) {
                      if(value == null) return;

                      setState(() {
                        animate = true;
                        currentSorting = value;
                        initStream();
                        animate = true;
                      });
                    },
                    value: currentSorting,
                    selectedItemBuilder: (context) {
                      return List.generate(WordListSorting.values.length, (i) =>
                        Container(
                          alignment: Alignment.centerLeft,
                          constraints: const BoxConstraints(minWidth: 50),
                          child: Text(
                            wordListSortingTranslations[WordListSorting.values[i]]!(),
                            style: const TextStyle(color: Colors.white,),
                          ),
                        )
                      );
                    },
                    items: List.generate(WordListSorting.values.length, (i) =>
                      DropdownMenuItem<WordListSorting>(
                        value: WordListSorting.values[i],
                        child: Text(
                          wordListSortingTranslations[WordListSorting.values[i]]!(),
                          style: TextStyle(
                            color: Theme.of(g_NavigatorKey.currentContext!).brightness == Brightness.dark
                              ? Colors.white
                              : Colors.black
                          ),
                        ),
                      )
                    ),
                  ),
                  // actions
                  if(widget.node.value.type != WordListNodeType.wordListDefault)
                    // add button
                    PopupMenuButton<WordListAction>(
                      icon: const Icon(Icons.add),
                      itemBuilder: (context) {
                        return [
                          PopupMenuItem<WordListAction>(
                            value: WordListAction.copyFromOther,
                            child: Text(LocaleKeys.WordListScreen_word_list_copy_other_list.tr()),
                          )
                        ];
                      },
                      onSelected: (value) {
                        switch (value) {
                          case WordListAction.copyFromOther:
                            copyEntriesFromOtherList();
                            break;
                          default:
                        }
                      },
                    ),
                ]
              ),
            )
          ];
        },
        body: StreamBuilder<Iterable<JMdict>>(
          stream: entriesStream,
          builder: (context, snapshot) {
        
            // stream didnt return anything yet
            if (snapshot.data == null || !snapshot.hasData){
              return const SizedBox();
            }
            // stream returned empty list
            if(snapshot.data!.isEmpty){
              return Center(
                child: Text(LocaleKeys.WordListsScreen_no_entries.tr()),
              );
            }
        
            return SearchResultList(
              searchResults: snapshot.data!.toList(),
              alwaysAnimateIn: animate,
              onDismissed: isDefault 
                ? null
                : (direction, entry, listIndex) {
                  // do NOT reanimate the list tiles in when deleting
                  animate = false;
                  widget.onDelete?.call(entry);
                  initStream();
                },
              showWordFrequency: GetIt.I<Settings>().wordLists.showWordFruequency,
              onSearchResultPressed: (entry){
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => 
                    WordListViewEntryScreen(entry)
                  )
                );
              },
            );
          }
        ),
        
      )
    );
  }

  /// Copies the entries from another list
  void copyEntriesFromOtherList() async {

    await showWordListSelectionDialog(context,
    includeDefaults: true,
    onSelectionConfirmed: (selection) async {

      await GetIt.I<WordListsSQLDatabase>().copyEntriesFromListsToList(
        selection.map((e) => e.id),
        widget.node.id);

      // ignore: use_build_context_synchronously
      Navigator.of(context, rootNavigator: false).pop();

    });

  }

}
