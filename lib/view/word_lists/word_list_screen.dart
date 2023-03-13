import 'package:flutter/material.dart';

import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';

import 'package:da_kanji_mobile/provider/isars.dart';
import 'package:da_kanji_mobile/model/WordLists/word_lists.dart';
import 'package:da_kanji_mobile/model/WordLists/word_lists_data.dart';
import 'package:da_kanji_mobile/model/tree_node.dart';
import 'package:da_kanji_mobile/view/word_lists/word_list.dart';
import 'package:da_kanji_mobile/model/search_history.dart';



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
      body: widget.node.value.wordIds.isEmpty
        ? Center(
          child: Text('No entries in this word list'),
        )
        : WordList(
          name: widget.node.value.name,
          entryIds: widget.node.value.wordIds,
        )
    );
  }
}