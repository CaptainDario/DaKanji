import 'package:dakanji_db_core/database/dakanji_db.dart';
import 'package:dakanji_db_core/database/index/index_table_entry.dart';
import 'package:dakanji_db_ui/widgets/model/dakanji_db_localization.dart';
import 'package:dakanji_db_ui/widgets/settings/dakanji_db_settings_card_add_button.dart';
import 'package:dakanji_db_ui/widgets/settings/dictionary_management/dakanji_db_dictionary_management_card.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:reorderables/reorderables.dart';

class DakanjiDbDictionaryManagementWidget extends StatefulWidget {

  const DakanjiDbDictionaryManagementWidget({super.key});

  @override
  State<DakanjiDbDictionaryManagementWidget> createState() =>
      _DakanjiDbDictionaryManagementWidgetState();
}

class _DakanjiDbDictionaryManagementWidgetState
    extends State<DakanjiDbDictionaryManagementWidget> {
  @override
  Widget build(BuildContext context) {

    var db = GetIt.I<DaKanjiDB>();
    var loc = GetIt.I<DakanjiDbLocalization>();

    return StreamBuilder<List<IndexEntry>>(
      stream: db.indexDao.watchAllIndexes(),
      builder: (context, asyncSnapshot) {
        if (asyncSnapshot.data == null || !asyncSnapshot.hasData) return Container();

        final dictsInOrder = List.generate(
          asyncSnapshot.data!.length,
          (index) => asyncSnapshot.data!
            .where((e) => e.currentSortingOrder == index+1).first,
        );

        return Column(
          children: [
            ReorderableColumn(
              onReorder: (oldIndex, newIndex) async {
                await reoderIndexes(oldIndex, newIndex, dictsInOrder);
              },
              children: [
                for (int i = 0; i < dictsInOrder.length; i++) 
                  DictionaryManagementCard(
                    dict: dictsInOrder[i],
                    index: i,
                    key: ValueKey(dictsInOrder[i].id),
                  )
              ]
            ),

            DakanjiDbSettingsCardAddButton(
              loc.importDictionary,
              // TODO add user import logic here
              disabledReason: "User import of dictionaries is currently disabled.",
              onPressed: true
                ? null
                : () {}
            )
          ],
        );
      },
    );
  }

  Future<void> reoderIndexes(
    int oldIndex, int newIndex, List<IndexEntry> dictsInOrder
  ) async {
  
    // Get just the IDs in their current order
    final ids = dictsInOrder.map((d) => d.id).toList();

    // Move the ID to the new position
    final movedId = ids.removeAt(oldIndex);
    ids.insert(newIndex, movedId);

    // Update DB: The new list index becomes the sorting order
    await GetIt.I<DaKanjiDB>().indexDao.setSortingOrders(
      ids, 
      List.generate(ids.length, (i) => i + 1),
    );
  }

}
