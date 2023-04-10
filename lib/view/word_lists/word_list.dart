import 'package:flutter/material.dart';

import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';
import 'package:database_builder/database_builder.dart';

import 'package:da_kanji_mobile/model/navigation_arguments.dart';
import 'package:da_kanji_mobile/provider/isars.dart';
import 'package:da_kanji_mobile/view/dictionary/search_result_list.dart';


/// A widget to show a word list, i.e.: the actual entries
class WordList extends StatelessWidget {

  /// The name of this list
  final String name;
  /// A list containing the ids of the database entries to show
  final List<int> entryIds;
  /// A list matching `entryIds` with the sources of the entries
  final List<DatabaseType> entrySources;


  const WordList(
    {
      required this.name,
      required this.entryIds,
      required this.entrySources,
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
        onSearchResultPressed: (entry) async {
          await Navigator.pushNamed(
            context, 
            '/dictionary', 
            //(route) => false,
            arguments: NavigationArguments(
              false, dictSearch: entry.kanjis.first
            )
          );
        },
        onDismissed: (DismissDirection direction, JMdict entry, int idx) {

        },
      )
    );
  }
}