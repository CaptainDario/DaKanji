import 'package:flutter/material.dart';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:get_it/get_it.dart';

import 'package:da_kanji_mobile/widgets/dictionary/dictionary_word_tab.dart';
import 'package:da_kanji_mobile/widgets/word_lists/word_lists.dart' as WordListsUI;
import 'package:da_kanji_mobile/domain/word_lists/word_lists.dart';


AwesomeDialog AddToWordListDialog(BuildContext context, DictionaryWordTab widget){
  return AwesomeDialog(
    context: context,
    headerAnimationLoop: false,
    useRootNavigator: false,
    dialogType: DialogType.noHeader,
    body: SizedBox(
      height: MediaQuery.of(context).size.height * 0.8,
      width: MediaQuery.of(context).size.width * 0.8,
      child: WordListsUI.WordLists(
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

