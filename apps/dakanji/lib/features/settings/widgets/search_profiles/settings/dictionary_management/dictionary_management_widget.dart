import 'package:da_db/database/da_db.dart';
import 'package:da_db/database/index/index_table_entry.dart';
import 'package:da_kanji_mobile/features/settings/widgets/search_profiles/settings/dictionary_management/dictionary_management_card.dart';
import 'package:da_kanji_mobile/features/settings/widgets/search_profiles/settings/search_profile_settings_card_add_button.dart';
import 'package:da_kanji_mobile/locales_keys.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:reorderables/reorderables.dart';

class DictionaryManagementWidget extends StatefulWidget {

  const DictionaryManagementWidget({super.key});

  @override
  State<DictionaryManagementWidget> createState() =>
      _DictionaryManagementWidgetState();
}

class _DictionaryManagementWidgetState
    extends State<DictionaryManagementWidget> {
  @override
  Widget build(BuildContext context) {

    var db = GetIt.I<DaDb>();

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
                    entry: dictsInOrder[i],
                    index: i,
                    key: ValueKey(dictsInOrder[i].id),
                  )
              ]
            ),

            SearchProfileSearchProfileCardAddButton(
              LocaleKeys.SettingsScreenSearchProfiles_import_dictionary.tr(),
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
    await GetIt.I<DaDb>().indexDao.setSortingOrders(
      ids, 
      List.generate(ids.length, (i) => i + 1),
    );
  }

}
