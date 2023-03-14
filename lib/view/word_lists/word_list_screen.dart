import 'package:flutter/material.dart';

import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';
import 'package:database_builder/database_builder.dart';

import 'package:da_kanji_mobile/provider/isars.dart';
import 'package:da_kanji_mobile/model/WordLists/word_lists.dart';
import 'package:da_kanji_mobile/model/WordLists/word_lists_data.dart';
import 'package:da_kanji_mobile/model/tree_node.dart';
import 'package:da_kanji_mobile/model/search_history.dart';
import 'package:da_kanji_mobile/view/dictionary/search_result_list.dart';



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
 
  @override
  void initState() {


    if(widget.node.value.name == WordListsDefaults.searchHistory.name &&
      wordListDefaultTypes.contains(widget.node.value.type)){
      widget.node.value.wordIds.addAll(
        GetIt.I<Isars>().searchHistory.searchHistorys.where()
          .sortByDateSearchedDesc()
          .dictEntryIdProperty()
          .findAllSync()
      );
    }

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
          child: Text('No entries in this word list'),
        )
        : SearchResultList(
          searchResults: GetIt.I<Isars>().dictionary.jmdict.where()
            .anyOf(widget.node.value.wordIds, (q, element) => q.idEqualTo(element))
            .findAllSync(),
          onSearchResultPressed: (entry){
            // TODO open dictionary screen with this entry
          },
        )
    );
  }
}