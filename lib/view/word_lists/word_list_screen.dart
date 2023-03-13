import 'package:flutter/material.dart';

import 'package:tuple/tuple.dart';
import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';

import 'package:da_kanji_mobile/provider/isars.dart';
import 'package:da_kanji_mobile/model/word_lists.dart';
import 'package:da_kanji_mobile/model/tree_node.dart';
import 'package:da_kanji_mobile/view/word_lists/word_list.dart';
import 'package:da_kanji_mobile/model/search_history.dart';



class WordListScreen extends StatefulWidget {

  /// the node of this word list
  final TreeNode<Tuple3<String, WordListNodeType, List<int>>> node;


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


    if(widget.node.value.item1 == WordListsDefaults.searchHistory.name &&
      wordListDefaultTypes.contains(widget.node.value.item2)){
      widget.node.value.item3.addAll(
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
      body: widget.node.value.item3.isEmpty
        ? Center(
          child: Text('No entries in this word list'),
        )
        : WordList(
          name: widget.node.value.item1,
          entryIds: widget.node.value.item3,
        )
    );
  }
}