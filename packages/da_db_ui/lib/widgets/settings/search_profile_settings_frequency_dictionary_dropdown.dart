import 'package:da_db/data/dictionary_types.dart';
import 'package:da_db/database/da_db.dart';
import 'package:da_db/database/index/index_table_entry.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart'; 



class SearchProfileSettingsFrequencyDictionaryDropdown extends StatelessWidget {
  const SearchProfileSettingsFrequencyDictionaryDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    final indexDao = GetIt.I<DaDb>().indexDao;

    return StreamBuilder<List<IndexEntry>>(
      stream: indexDao.watchAllIndexes(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const SizedBox.shrink();

        final allIndexes = snapshot.data!;

        // 1. Filter for Yomitan dictionaries
        final yomitanDicts = allIndexes
            .where((e) => e.dictionaryType == DictionaryTypes.yomitan)
            .toList();

        // 2. Determine the currently active override ID
        int? activeId;
        try {
          final activeEntry = allIndexes.firstWhere(
            (e) => e.currentFrequencyDictionary == true
          );
          // Only show as active if it's actually in our filtered list
          if (yomitanDicts.any((e) => e.id == activeEntry.id)) {
            activeId = activeEntry.id;
          }
        } catch (_) {
          activeId = null; 
        }

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(
                color: Theme.of(context).dividerColor.withValues(alpha: 0.5),
              ),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<int?>(
                value: activeId,
                isExpanded: true,
                icon: const Icon(Icons.arrow_drop_down),
                dropdownColor: Theme.of(context).cardColor,
                style: Theme.of(context).textTheme.bodyMedium,
                // TODO localization
                hint: const Text("-"),
                items: [
                  const DropdownMenuItem<int?>(
                    value: null,
                    child: Text(
                      // TODO localization
                      "-",
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                  ...yomitanDicts.map((e) {
                    return DropdownMenuItem<int?>(
                      value: e.id,
                      child: Text(
                        e.title,
                        overflow: TextOverflow.ellipsis,
                      ),
                    );
                  }),
                ],
                onChanged: (int? newId) {
                  if (newId == null) {
                    indexDao.clearFrequencyOverride();
                  } else {
                    indexDao.updateFrequencyOverride(newId);
                  }
                },
              ),
            ),
          ),
        );
      },
    );
  }
}