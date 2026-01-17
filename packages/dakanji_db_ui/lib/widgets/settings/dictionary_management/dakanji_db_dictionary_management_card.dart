import 'package:dakanji_db_core/database/dakanji_db.dart';
import 'package:dakanji_db_ui/widgets/settings/dictionary_management/dakanji_db_dictionary_management_details_table.dart';
import 'package:flutter/material.dart';

class DictionaryManagementCard extends StatefulWidget {
  
  final DaKanjiDB db;

  final IndexTableData dict;

  final int index;
  
  const DictionaryManagementCard({
    super.key,
    required this.db,
    required this.dict,
    required this.index,
  });

  @override
  State<DictionaryManagementCard> createState() => _DictionaryManagementCardState();
}

class _DictionaryManagementCardState extends State<DictionaryManagementCard> {

  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
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
          "${widget.dict.currentSortingOrder}: ${widget.dict.title}",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
          
        // Switch on the Right
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Switch(
              value: widget.dict.enabled,
              // enable/disable dictionaries
              onChanged: (value) async {
                await widget.db.indexDao.setEnabled(widget.dict.id, value);
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
          TextButton(
            onPressed: () {
              // TODO check for updates
            },
            child: Text("Check for updates"),
          ),
          // TODO DELETE
          // ALL the info about the dictionary
          ExpansionTile(
            title: Text("Details"),
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.3,
                ),
                child: SingleChildScrollView(
                  primary: false,
                  child: DictionaryManagementDetailsTable(widget.dict,),
                ),
              ),
            ]
          ),
        ],
      ),
    );
  }


}
