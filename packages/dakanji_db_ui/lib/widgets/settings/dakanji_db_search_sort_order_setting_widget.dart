import 'package:dakanji_db_ui/model/dakanji_db_search_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:reorderables/reorderables.dart';

class DakanjiDbSearchSortOrderSettingWidget extends StatefulWidget {

  /// The search settings to modify.
  final DaKanjiDbSearchSettings settings;
  /// Whether this widget is for the 1st level sort order.
  final bool firstSortOrder;
  /// Whether this widget is for the 2nd level sort order.
  final bool secondSortOrder;
  /// The title of the setting.
  final String title;
  /// The info text to show in the info dialog (shown when pressing the i-btn).
  final String infoText;
  /// The names of the *user facing* options, in the order of the enum.
  final List<String> optionNames;


  DakanjiDbSearchSortOrderSettingWidget(
    {
      required this.settings,
      this.firstSortOrder = false,
      this.secondSortOrder = false,

      required this.title,
      required this.infoText,
      required this.optionNames,
      super.key
    }
  ){
    assert(
      firstSortOrder ^ secondSortOrder,
      "Only one of `firstSortOrder` or `secondSortOrder` can be true."
    );
  }

  @override
  State<DakanjiDbSearchSortOrderSettingWidget> createState() => _DakanjiDbSearchSortOrderSettingWidgetState();
}

class _DakanjiDbSearchSortOrderSettingWidgetState extends State<DakanjiDbSearchSortOrderSettingWidget> {
  
  @override
  Widget build(BuildContext context) {
    // Determine which list to use from settings
    // These are List<(Enum, bool)>
    final List<dynamic> currentList = widget.firstSortOrder
      ? widget.settings.firstSortOrder
      : widget.settings.secondSortOrder;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            IconButton(
              onPressed: _showInfoDialog,
              icon: Icon(Icons.info_outline)
            ),
            Text(
              widget.title,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
        ReorderableColumn(
          scrollController: ScrollController(),
          onReorder: (oldIndex, newIndex) {
            setState(() {
              final item = currentList.removeAt(oldIndex);
              currentList.insert(newIndex, item);
            });
          },
          children: [
            for (int i = 0; i < currentList.length; i++) 
              _buildListItem(currentList, i),
          ],
        ),
      ],
    );
  }
  
Widget _buildListItem(List<dynamic> list, int index) {
  // Access the record: $1 is the Enum, $2 is the boolean
  final record = list[index];
  final Enum option = record.$1;
  final bool isSelected = record.$2;

  // We wrap in a Card to give it a distinct "box" feel similar to a Chip,
  // but simpler (just ListTile) works too.
  return Card(
    key: ValueKey(option),
    margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 0),
    elevation: 2,
    child: ListTile(
      leading: const Icon(Icons.drag_handle, color: Colors.grey),

      title: Text(
        "${index + 1}. ${widget.optionNames[option.index]}",
        style: TextStyle(
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          color: isSelected ? null : Colors.grey, // Dim text if disabled
        ),
      ),

      trailing: Switch(
        value: isSelected,
        onChanged: (bool value) {
          setState(() {
            list[index] = (option, value);
          });
        },
      ),
      
      // Allow tapping the whole row to toggle
      onTap: () {
        setState(() {
          list[index] = (option, !isSelected);
        });
      },
    ),
  );
}

  Future<void> _showInfoDialog() async {
    await showGeneralDialog<DaKanjiDbSearchSettings>(
      context: context,
      barrierDismissible: true,
      barrierLabel: "Close",
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (context, animation, secondaryAnimation) {
        return ScaleTransition(
          scale: animation,
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.6,
                maxWidth: MediaQuery.of(context).size.width * 0.9,
              ),
              child: Card(
                elevation: 8,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Markdown(
                    data: widget.infoText,
                    shrinkWrap: true, 
                    padding: const EdgeInsets.all(8.0), 
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}