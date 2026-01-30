import 'package:dakanji_db_core/data/dakanji_db_search_result_sort_order.dart';
import 'package:dakanji_db_core/database/dakanji_db.dart';
import 'package:dakanji_db_core/database/search_profiles/search_profiles_entry.dart';
import 'package:dakanji_db_ui/widgets/settings/dakanji_db_settings_info_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:reorderables/reorderables.dart';

class DakanjiDbSettingsSearchResultSortOrder extends StatefulWidget {

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


  DakanjiDbSettingsSearchResultSortOrder(
    {
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
  State<DakanjiDbSettingsSearchResultSortOrder> createState() => _DakanjiDbSettingsSearchResultSortOrderState();
}

class _DakanjiDbSettingsSearchResultSortOrderState extends State<DakanjiDbSettingsSearchResultSortOrder> {
  

  void _updateSettingsList(List<(dynamic, bool)> newList) {
    if (widget.firstSortOrder) {
      // Cast the list so Freezed accepts it
      GetIt.I<DaKanjiDB>().searchProfilesDao.updateProfile(
        context.read<SearchProfilesEntry>().copyWith(
          firstSortOrder: newList.cast<(DakanjiDbSearchResult1stSortOrder, bool)>().toList(),
        ),
      );
    }
    else {
      GetIt.I<DaKanjiDB>().searchProfilesDao.updateProfile(
        context.read<SearchProfilesEntry>().copyWith(
          secondSortOrder: newList.cast<(DakanjiDbSearchResult2ndSortOrder, bool)>().toList(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Determine which list to use from settings
    // These are List<(Enum, bool)>
    final List<(dynamic, bool)> currentList = [...widget.firstSortOrder
      ? context.read<SearchProfilesEntry>().firstSortOrder
      : context.read<SearchProfilesEntry>().secondSortOrder
    ];

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InfoPopupButton(
          title: widget.title,
          infoText: widget.infoText,
        ),
        ReorderableColumn(
          scrollController: ScrollController(),
          onReorder: (oldIndex, newIndex) {
            setState(() {
              final item = currentList.removeAt(oldIndex);
              currentList.insert(newIndex, item);
              _updateSettingsList(currentList);
            });
          },
          children: [
            for (int i = 0; i < currentList.length; i++) 
              SortOrderTile(
                key: ValueKey(currentList[i].$1), // Use the Enum as key
                index: i,
                label: widget.optionNames[currentList[i].$1.index],
                isSelected: currentList[i].$2,
                onToggle: (bool newValue) {
                  currentList[i] = (currentList[i].$1, newValue);
                  _updateSettingsList(currentList);
                },
              ),
          ],
        ),
      ],
    );
  }
}

class SortOrderTile extends StatelessWidget {
  final String label;
  final bool isSelected;
  final int index;
  final ValueChanged<bool> onToggle;

  const SortOrderTile({
    super.key,
    required this.label,
    required this.isSelected,
    required this.index,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 0),
      elevation: 2,
      child: ListTile(
        leading: const Icon(Icons.drag_handle, color: Colors.grey),
        title: Text(
          "${index + 1}. $label",
          style: TextStyle(
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            color: isSelected ? null : Colors.grey,
          ),
        ),
        trailing: Switch(
          value: isSelected,
          onChanged: onToggle,
        ),
        onTap: () => onToggle(!isSelected),
      ),
    );
  }
}