// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:database_builder/database_builder.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';

// Project imports:
import 'package:da_kanji_mobile/entities/isar/isars.dart';
import 'package:da_kanji_mobile/entities/navigation_arguments.dart';
import 'package:da_kanji_mobile/entities/search_history/search_history.dart';
import 'package:da_kanji_mobile/entities/tree/tree_node.dart';
import 'package:da_kanji_mobile/entities/word_lists/word_list_types.dart';
import 'package:da_kanji_mobile/entities/word_lists/default_names.dart';
import 'package:da_kanji_mobile/entities/word_lists/word_lists_data.dart';
import 'package:da_kanji_mobile/locales_keys.dart';
import 'package:da_kanji_mobile/widgets/dictionary/search_result_list.dart';

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
  /// all entries of this list
  late List<JMdict?> entries;


  @override
  void initState() {

    if(wordListDefaultTypes.contains(widget.node.value.type)) {
      isDefault = true;
    }

    // search history (assure it is a default list and not a user created one)
    if(widget.node.value.name == DefaultNames.searchHistory.name &&
      wordListDefaultTypes.contains(widget.node.value.type)){

      List<int> searchHistoryIds = GetIt.I<Isars>().searchHistory.searchHistorys.where()
        .anyId()
        .sortByDateSearchedDesc()
        .dictEntryIdProperty()
        .findAllSync().toSet().toList();  
      entries = GetIt.I<Isars>().dictionary.jmdict.getAllSync(
        searchHistoryIds
      );
    }
    else if(widget.node.value.name.contains('jlpt') &&
      wordListDefaultTypes.contains(widget.node.value.type)){
      List<int> jlptIds = GetIt.I<Isars>().dictionary.jmdict.filter()
        .jlptLevelElementContains(widget.node.value.name.replaceAll("jlpt", ""))
        .sortByFrequencyDesc()
        .idProperty()
        .findAllSync().toSet().toList();  
      entries = GetIt.I<Isars>().dictionary.jmdict.getAllSync(
        jlptIds
      );
    }
    // user list
    else{
      entries = GetIt.I<Isars>().dictionary.jmdict.getAllSync(
      widget.node.value.wordIds
    );
    }

    super.initState();
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Align(
          alignment: Alignment.centerLeft,
          child: Text(widget.node.value.name)
        ),
      ),
      body: entries.isEmpty
        ? Center(
          child: Text(LocaleKeys.WordListsScreen_no_entries.tr()),
        )
        : SearchResultList(
          searchResults: entries,
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
                dictInitialEntryId: entry.id
              )
            );
          },
        )
    );
  }
}
