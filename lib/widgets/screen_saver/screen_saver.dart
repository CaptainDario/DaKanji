import 'package:collection/collection.dart';
import 'package:da_kanji_mobile/entities/isar/isars.dart';
import 'package:da_kanji_mobile/entities/tree/tree_node.dart';
import 'package:da_kanji_mobile/entities/word_lists/word_lists_data.dart';
import 'package:da_kanji_mobile/entities/word_lists/word_lists_sql.dart';
import 'package:da_kanji_mobile/widgets/dictionary/dictionary_word_card.dart';
import 'package:database_builder/database_builder.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';



/// Shows a screen saver that iterates through different dictionary entries
class ScreenSaver extends StatefulWidget {
  
  /// The dictionary entries to show
  final List<TreeNode<WordListsData>> wordLists;

  const ScreenSaver(
    this.wordLists,
    {
      super.key
    }
  );

  @override
  State<ScreenSaver> createState() => _ScreenSaverState();
}

class _ScreenSaverState extends State<ScreenSaver> {


  /// all entries that are shown in this screen saver
  List<JMdict> entries = [];


  @override
  void initState() {
    
    super.initState();

  }

  Future<bool> getWordListEntries () async {

    for (var wordList in widget.wordLists) {
      final entryIDs = await GetIt.I<WordListsSQLDatabase>()
        .getEntryIDsOfWordList(wordList.id);
      entries.addAll(
        GetIt.I<Isars>().dictionary.jmdict.getAllSync(entryIDs).whereNotNull()
      );
    }

    return true;

  }

  @override
  Widget build(BuildContext context) {

    // get the current screen dimensions
    Size s = MediaQuery.sizeOf(context);
    double w = s.width;
    double h = s.height;

    return GestureDetector(
      onTap: () => Navigator.of(context).pop(),
      child: Container(
        height: h,
        width:  w,
        color: Colors.transparent,
        child: FutureBuilder(
          future: getWordListEntries(),
          builder: (context, snapshot) {
        
            // if word lists are not read yet, show nothing
            if(!snapshot.hasData) return Container();
        
            return Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  width : w * 0.6,
                  height: h * 0.5,
                  child: SingleChildScrollView(
                    child: DictionaryWordCard(
                      entries.first,
                      showConjugationTable: false,
                      showImageSearch: false,
                    ),
                  ),
                ),
              ],
            );
          }
        ),
      ),
    );
  }
}