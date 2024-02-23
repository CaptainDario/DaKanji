// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:get_it/get_it.dart';

// Project imports:
import 'package:da_kanji_mobile/entities/word_lists/word_list_types.dart';
import 'package:da_kanji_mobile/entities/word_lists/word_lists_data.dart';
import 'package:da_kanji_mobile/entities/word_lists/word_lists_sql.dart';
import 'package:da_kanji_mobile/widgets/dictionary/dictionary_word_tab.dart';
import 'package:da_kanji_mobile/widgets/word_lists/word_lists.dart' as word_lists_ui;

// Project imports:
 import 'package:da_kanji_mobile/entities/tree/tree_node.dart';

/// [AwesomeDialog] to add a word to a wordlist
AwesomeDialog addToWordListDialog(BuildContext context, DictionaryWordTab widget){
  return AwesomeDialog(
    context: context,
    headerAnimationLoop: false,
    useRootNavigator: false,
    dialogType: DialogType.noHeader,
    body: SizedBox(
      height: MediaQuery.of(context).size.height * 0.8,
      width: MediaQuery.of(context).size.width * 0.8,
      child: word_lists_ui.WordLists(
        false,
        GetIt.I<WordListsSQLDatabase>(),
        showDefaults: false,
        onSelectionConfirmed: (selection) {
          
          // get all nodes to which the selected entry should be added
          List<TreeNode<WordListsData>> nodesToAddTo = selection.where(
            (sel) =>
              // assure this node is a word list
              wordListListypes.contains(sel.value.type) &&
              // assure that the word is not already in the list
              !sel.value.wordIds.contains(widget.entry!.id)
          ).toList();

          // update the lists
          GetIt.I<WordListsSQLDatabase>().addEntriesToWordLists(
            nodesToAddTo.map((e) => e.id).toList(),
            [widget.entry!.id]);

          // save to disk
          GetIt.I<WordListsSQLDatabase>().updateNodes(nodesToAddTo);

          Navigator.of(context, rootNavigator: false).pop();
        },
      ),
    )
  );
}


