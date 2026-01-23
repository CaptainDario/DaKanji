import 'package:dakanji_db_core/database/dakanji_db.dart';
import 'package:dakanji_db_core/database/index/index_table_entry.dart';
import 'package:dakanji_db_ui/model/dakanji_db_localization.dart';
import 'package:dakanji_db_ui/widgets/settings/dakanji_db_settings_info_widgets.dart';
import 'package:dakanji_db_ui/widgets/settings/dictionary_management/dakanji_db_dictionary_management_details_table.dart';
import 'package:dakanji_db_ui/widgets/settings/dictionary_management/dakanji_db_dictionary_update_popup.dart';
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

    var db = GetIt.I<DaKanjiDB>();
    var loc = GetIt.I<DakanjiDbLocalization>();

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
                  // TODO localization
                  : () => showInfoSnackbar("This dictionary does not provide updates.", context),
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
                              child: DaKanjiDbDictionaryUpdatePopup(widget.entry),
                            ),
                          ),
                        );
                      });
                    }
                    : null,
                  child: Row(
                    children: [
                      Icon(Icons.update),
                      Text(loc.updateDictionary)
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: widget.entry.isDefaultDictionary
                  // TODO localization
                  ? () => showInfoSnackbar("Default dictionaries cannot be deleted.", context)
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
                      Text(loc.deleteDictionary)
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
