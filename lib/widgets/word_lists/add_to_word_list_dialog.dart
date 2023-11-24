// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:get_it/get_it.dart';

// Project imports:
import 'package:da_kanji_mobile/entities/word_lists/word_lists.dart';
import 'package:da_kanji_mobile/widgets/dictionary/dictionary_word_tab.dart';
import 'package:da_kanji_mobile/widgets/word_lists/word_lists.dart' as word_lists_ui;
import 'package:da_kanji_mobile/entities/word_lists/word_list_types.dart';



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
        GetIt.I<WordLists>().root,
        showDefaults: false,
        onSelectionConfirmed: (selection) {
          
          selection.where(
            (sel) =>
              // assure this node is a word list
              wordListListypes.contains(sel.value.type) &&
              // assure that the word is not already in the list
              !sel.value.wordIds.contains(widget.entry!.id)
          ).forEach(
            (sel) => sel.value.wordIds.add(widget.entry!.id)
          );
          Navigator.of(context, rootNavigator: false).pop();
        },
      ),
    )
  );
}


