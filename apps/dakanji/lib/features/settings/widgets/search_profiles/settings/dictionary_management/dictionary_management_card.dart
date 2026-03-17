import 'package:da_db/database/da_db.dart';
import 'package:da_db/database/index/index_table_entry.dart';
import 'package:da_kanji_mobile/features/settings/widgets/search_profiles/settings/dictionary_management/dictionary_management_details_table.dart';
import 'package:da_kanji_mobile/features/settings/widgets/search_profiles/settings/dictionary_management/dictionary_update_popup.dart';
import 'package:da_kanji_mobile/features/settings/widgets/search_profiles/settings/search_profile_settings_info_widgets.dart';
import 'package:da_kanji_mobile/locales_keys.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class DictionaryManagementCard extends StatefulWidget {
  
  final IndexEntry entry;

  final int index;
  
  const DictionaryManagementCard({
    super.key,
    required this.entry,
    required this.index,
  });

  @override
  State<DictionaryManagementCard> createState() => _DictionaryManagementCardState();
}

class _DictionaryManagementCardState extends State<DictionaryManagementCard> {

  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {

    var db = GetIt.I<DaDb>();

    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: ExpansionTile(
        onExpansionChanged: (value) => setState(() {
          isExpanded = value;
        }),
        clipBehavior: Clip.antiAlias, 
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide.none, 
        ),
        collapsedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide.none,
        ),
        // Drag Handle on the Left
        leading: ReorderableDragStartListener(
          index: widget.index,
          child: const Icon(Icons.drag_handle),
        ),
          
        // Title in the Middle
        title: Text(
          "${widget.entry.currentSortingOrder}: ${widget.entry.title}",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
          
        // Switch on the Right
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Switch(
              value: widget.entry.enabled,
              // enable/disable dictionaries
              onChanged: (value) async {
                await db.indexDao.setEnabled(widget.entry.id, value);
              },
            ),
            const SizedBox(width: 8,),
            AnimatedSwitcher(
              duration: Duration(milliseconds: 200),
              child: Icon(
                key: ValueKey(isExpanded),
                isExpanded ? Icons.expand_less : Icons.expand_more,
                color: Colors.grey
              )
            )
          ],
        ),
        children: [
          SizedBox(height: 8),
          // ALL the info about the dictionary
          ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: 200,
            ),
            child: SingleChildScrollView(
              primary: false,
              child: DictionaryManagementDetailsTable(widget.entry,),
            ),
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: .spaceEvenly,
            children: [
              GestureDetector(
                onTap: widget.entry.dictCanBeUpdated
                  ? null
                  : () => showInfoSnackbar(LocaleKeys.SettingsScreenSearchProfiles_update_dictionary_no_update_infos.tr(), context),
                child: OutlinedButton(
                  onPressed: widget.entry.dictCanBeUpdated
                    ? () async {
                      await showGeneralDialog(
                        context: context,
                        barrierDismissible: true,
                        barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
                        pageBuilder: (context, animation, secondaryAnimation) {
                        return ScaleTransition(
                          scale: animation,
                          child: Center(
                            child: Material(
                              color: Colors.transparent,
                              child: DictionaryUpdatePopup(widget.entry),
                            ),
                          ),
                        );
                      });
                    }
                    : null,
                  child: Row(
                    children: [
                      Icon(Icons.update),
                      Text(LocaleKeys.SettingsScreenSearchProfiles_update_dictionary.tr())
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: widget.entry.isDefaultDictionary
                  ? () => showInfoSnackbar(LocaleKeys.SettingsScreenSearchProfiles_delete_dictionary_default_cannot.tr(), context)
                  : null,
                child: OutlinedButton(
                  onPressed: widget.entry.isDefaultDictionary
                    ? null
                    : () {
                      // TODO delete dictionary
                    },
                  child: Row(
                    children: [
                      Icon(Icons.delete),
                      Text(LocaleKeys.SettingsScreenSearchProfiles_delete_dictionary.tr())
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
        ],
      ),
    );
  }

}
