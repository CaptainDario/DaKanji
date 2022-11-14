import 'package:da_kanji_mobile/view/dictionary/search_result_list.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:database_builder/src/jm_enam_and_dict_to_Isar/data_classes.dart' as isar_jm;

import 'package:da_kanji_mobile/model/DictionaryScreen/search_isolate.dart';
import 'package:da_kanji_mobile/view/dictionary/search_result_card.dart';
import 'package:da_kanji_mobile/provider/dict_search_result.dart';




class DictionarySearchTab extends StatefulWidget {

  const DictionarySearchTab(
    {
      this.onSearchResultPressed,
      Key? key
    }
  ) : super(key: key);

  /// callback when on a search result was pressed
  final Function(isar_jm.Entry selection)? onSearchResultPressed;

  @override
  State<DictionarySearchTab> createState() => _DictionarySearchTabState();
}

class _DictionarySearchTabState extends State<DictionarySearchTab> {


  @override
  Widget build(BuildContext context) {
    
    return Expanded(
      child: Container(color: Colors.green,)//SearchResultList()
    );
  }

  
}