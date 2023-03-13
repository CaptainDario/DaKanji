import 'package:flutter/material.dart';

import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';
import 'package:database_builder/database_builder.dart';

import 'package:da_kanji_mobile/provider/isars.dart';
import 'package:da_kanji_mobile/view/dictionary/search_result_list.dart';


/// A widget to show a word list
class WordList extends StatelessWidget {

  /// The name of this list
  final String name;
  /// A list containing the ids of the database entries to show
  final List<int> entryIds;


  const WordList(
    {
      required this.name,
      required this.entryIds,
      super.key
    }
  );

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
          child: Text(name)
        ),
      ),
      body: SearchResultList(
        searchResults: GetIt.I<Isars>().dictionary.jmdict.where()
          .anyOf(entryIds, (q, element) => q.idEqualTo(element))
          .findAllSync(),
        onSearchResultPressed: (entry){

        },
      )
    );
  }
}