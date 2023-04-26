import 'package:flutter/material.dart';

import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';
import 'package:database_builder/database_builder.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:da_kanji_mobile/provider/isars.dart';
import 'package:da_kanji_mobile/model/WordLists/word_lists.dart';
import 'package:da_kanji_mobile/model/WordLists/word_lists_data.dart';
import 'package:da_kanji_mobile/model/tree/tree_node.dart';
import 'package:da_kanji_mobile/model/search_history.dart';
import 'package:da_kanji_mobile/widgets/dictionary/search_result_list.dart';
import 'package:da_kanji_mobile/locales_keys.dart';
import 'package:da_kanji_mobile/model/navigation_arguments.dart';



class WordListScreen extends StatefulWidget {

  /// the node of this word list
  final TreeNode<WordListsData> node;


  const WordListScreen(
    this.node,
    {
      super.key
    }
  );

  @override
  State<WordListScreen> createState() => _WordListScreenState();
}

class _WordListScreenState extends State<WordListScreen> {
 
  /// is this a default list
  bool isDefault = false;

  @override
  void initState() {

    // if this list is the search history list, add all the search history
    if(widget.node.value.name == WordListsDefaults.searchHistory.name &&
      wordListDefaultTypes.contains(widget.node.value.type)){
      widget.node.value.wordIds.addAll(
        GetIt.I<Isars>().searchHistory.searchHistorys.where()
          .sortByDateSearchedDesc()
          .dictEntryIdProperty()
          .findAllSync()
      );
    }
    if(widget.node.value.type.name.contains("Default"))
      isDefault = true;

    super.initState();
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Align(
          alignment: Alignment.centerLeft,
          child: Text(widget.node.value.name)
        ),
      ),
      body: widget.node.value.wordIds.isEmpty
        ? Center(
          child: Text(LocaleKeys.WordListsScreen_no_entries.tr()),
        )
        : SearchResultList(
          searchResults: GetIt.I<Isars>().dictionary.jmdict.where()
            .anyOf(widget.node.value.wordIds, (q, element) => q.idEqualTo(element))
            .findAllSync(),
          onDismissed: isDefault
            ? null
            : (direction, entry, listIndex) {
              setState(() {
                widget.node.value.wordIds.remove(entry.id);
              });
            },
          onSearchResultPressed: (entry){
            Navigator.of(context).pushNamed(
              '/dictionary',
              arguments: NavigationArguments(
                false,
                initialEntryId: entry.id
              )
            );
          },
        )
    );
  }
}