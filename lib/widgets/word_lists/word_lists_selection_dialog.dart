// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:get_it/get_it.dart';

// Project imports:
import 'package:da_kanji_mobile/entities/word_lists/word_lists_data.dart';
import 'package:da_kanji_mobile/entities/word_lists/word_lists_sql.dart';
import 'package:da_kanji_mobile/widgets/word_lists/word_lists.dart' as word_lists_ui;

// Project imports:
 import 'package:da_kanji_mobile/entities/tree/tree_node.dart';



/// Shows a dialog to the user where word lists can be selected, returns the
/// selection. [wordLists] should contain all words that should be displayed
/// and if [selectedItems] is not null it indicates which items should be 
/// checked initially (given by their ID). [onSelectionConfirmed] is a callaback
/// that is triggered after the user confirms the selection and provides the
/// user's selection as arugment
Future<List<TreeNode<WordListsData>>> showWordListSelectionDialog(BuildContext context,
  {
    WordListsSQLDatabase? wordlists,
    List<int>? selectedItems,
    Function(List<TreeNode<WordListsData>> selection)? onSelectionConfirmed,
    bool includeDefaults = false
  }) async {

  List<TreeNode<WordListsData>> selection = [];

  await AwesomeDialog(
    context: context,
    headerAnimationLoop: false,
    useRootNavigator: false,
    dialogType: DialogType.noHeader,
    body: SizedBox(
      height: MediaQuery.of(context).size.height * 0.8,
      width: MediaQuery.of(context).size.width * 0.8,
      child: word_lists_ui.WordLists(
        false,
        wordlists ?? GetIt.I<WordListsSQLDatabase>(),
        selectedItems: selectedItems,
        includeDefaults: includeDefaults,
        onSelectionConfirmed: onSelectionConfirmed,
      ),
    )
  ).show();

  return selection;

}