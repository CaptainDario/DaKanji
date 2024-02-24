// Flutter imports:
import 'package:da_kanji_mobile/entities/iso/iso_table.dart';
import 'package:da_kanji_mobile/entities/settings/settings.dart';
import 'package:da_kanji_mobile/entities/word_list/word_list_action.dart';
import 'package:da_kanji_mobile/entities/word_list/word_list_sorting.dart';
import 'package:da_kanji_mobile/widgets/word_lists/word_lists_selection_dialog.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:collection/collection.dart';
import 'package:database_builder/database_builder.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';

// Project imports:
import 'package:da_kanji_mobile/entities/isar/isars.dart';
import 'package:da_kanji_mobile/entities/search_history/search_history_sql.dart';
import 'package:da_kanji_mobile/entities/tree/tree_node.dart';
import 'package:da_kanji_mobile/entities/word_lists/default_names.dart';
import 'package:da_kanji_mobile/entities/word_lists/word_list_types.dart';
import 'package:da_kanji_mobile/entities/word_lists/word_lists_data.dart';
import 'package:da_kanji_mobile/entities/word_lists/word_lists_sql.dart';
import 'package:da_kanji_mobile/locales_keys.dart';
import 'package:da_kanji_mobile/screens/word_lists/word_list_view_entry_screen.dart';
import 'package:da_kanji_mobile/widgets/dictionary/search_result_list.dart';

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
  late Stream<Iterable<JMdict>> entriesStream;

  /// [FocusNode] of the search field
  FocusNode searchInputFocusNode = FocusNode();
  /// The [TextEditingController] to handle the search inputs
  TextEditingController searchTextEditingController = TextEditingController();

  /// The current sorting order
  WordListSorting currentSorting = WordListSorting.dateDesc;


  @override
  void initState() {

    // init stream when the text controller changes
    searchTextEditingController.addListener(() => setState((){
      initStream();
    }));

    initStream();

    super.initState();
  }

  void initStream(){

    // is this a default list
    if(widget.node.value.type == WordListNodeType.wordListDefault) {

      isDefault = true;

      // search history (assure it is a default list and not a user created one)
      if(widget.node.value.name == DefaultNames.searchHistory.name){

        entriesStream = searchHistoryStream();
      }
      // default list (JLPT)
      else if(widget.node.value.name.contains('jlpt')){

        entriesStream = jlptListStream();
      }
    }    
    // user list
    else{
      entriesStream = userListStream();
    }

    String searchTerm = searchTextEditingController.text;
    entriesStream = entriesStream
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
      // apply sorting
      .map((event) =>
        event.sorted((b, a) => a.frequency.compareTo(b.frequency)));

  }

  Stream<Iterable<JMdict>> searchHistoryStream(){
    return GetIt.I<SearchHistorySQLDatabase>().watchAllUniqueSearchHistoryIDs()
      .map((e) => GetIt.I<Isars>().dictionary.jmdict.getAllSync(
        e.whereNotNull().toList())
        .whereNotNull()
      );
  }

  /// Returns a stream that yields a list with the elements of a JLPT word list
  Stream<Iterable<JMdict>> jlptListStream(){

    Query<int> jlptIdsQuery = GetIt.I<Isars>().dictionary.jmdict.filter()
      .jlptLevelElementContains(widget.node.value.name.replaceAll("jlpt", ""))
      .sortByFrequencyDesc()
      .idProperty()
      .build();
    
    return jlptIdsQuery.watch(fireImmediately: true)
      .map((event) => 
        GetIt.I<Isars>().dictionary.jmdict.getAllSync(event)
        .whereNotNull()
      ); 

  }
 
  Stream<Iterable<JMdict>> userListStream(){

    // listen to changes of this word list
    return GetIt.I<WordListsSQLDatabase>().watchWordlistEntries(widget.node.id)
      // on change
      .map((e) {
        return GetIt.I<Isars>().dictionary.jmdict
          .getAllSync(
            e.map((e) => e.dictEntryID).toList())
          .whereNotNull();
      });

  }

  @override
  void dispose() {
    searchTextEditingController.removeListener(() => setState((){}));
    super.dispose();
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
                      decoration: searchInputFocusNode.hasPrimaryFocus
                        ? const InputDecoration()
                        : const InputDecoration.collapsed(hintText: ""),
                    )
                  ),
                  const SizedBox(width: 16,),
                  // search list
                  DropdownButton<WordListSorting>(
                    onChanged: (value) {
                      if(value == null) return;

                      setState(() {
                        currentSorting = value;
                      });
                    },
                    value: currentSorting,
                    items: List.generate(WordListSorting.values.length, (i) =>
                      DropdownMenuItem<WordListSorting>(
                        value: WordListSorting.values[i],
                        child: Text(wordListSortingTranslations[WordListSorting.values[i]]!()),
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
        
            if(snapshot.data == null || !snapshot.hasData || snapshot.data!.isEmpty){
              return Center(
                child: Text(LocaleKeys.WordListsScreen_no_entries.tr()),
              );
            }
        
            return SearchResultList(
              searchResults: snapshot.data!.whereNotNull().toList(),
              onDismissed: isDefault 
                ? null
                : (direction, entry, listIndex) {
                  widget.onDelete?.call(entry);
                },
              showWordFrequency: true,
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

    await showWordListSelectionDialog(context, (selection) async {

      await GetIt.I<WordListsSQLDatabase>().copyEntriesFromListsToList(
        selection.map((e) => e.id),
        widget.node.id);
        
      // ignore: use_build_context_synchronously
      Navigator.of(context, rootNavigator: false).pop();
    });

  }

}
