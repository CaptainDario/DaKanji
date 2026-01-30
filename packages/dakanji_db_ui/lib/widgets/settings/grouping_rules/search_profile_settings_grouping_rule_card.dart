import 'package:collection/collection.dart';
import 'package:dakanji_db_core/data/dictionary_types.dart';
import 'package:dakanji_db_core/database/dakanji_db.dart';
import 'package:dakanji_db_core/database/db_queries/dictionary_search/grouping_rules.dart';
import 'package:dakanji_db_core/database/index/index_table_entry.dart';
import 'package:dakanji_db_core/database/search_profiles/search_profiles_entry.dart';
import 'package:dakanji_db_ui/model/dakanji_db_localization.dart';
import 'package:dakanji_db_ui/widgets/settings/grouping_rules/search_profile_settings_grouping_widget.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

/// A card representing a single grouping rule
/// 
/// Note: This REQUIRES a [DaKanjiDbSettings] provider in the widget tree.
class SearchProfileSettingsGroupingRuleCard extends StatefulWidget {

  final int i;

  final DakanjiDbLocalization localization;

  const SearchProfileSettingsGroupingRuleCard(
    this.i,
    this.localization,
    {
      super.key
    }
  );

  @override
  State<SearchProfileSettingsGroupingRuleCard> createState() => _SearchProfileSettingsGroupingRuleCardState();
}

class _SearchProfileSettingsGroupingRuleCardState extends State<SearchProfileSettingsGroupingRuleCard> {

  /// Returns all indexes with a flag indicating their usage in any rule
  Future<List<({IndexEntry index, IndexGroupingUsage usage,})>>
    _allAvaibleIndexes(bool onlySequenced) async {

    List<IndexEntry> allIndexes =
      await GetIt.I<DaKanjiDB>().indexDao.getAllIndexes();

    return allIndexes.nonNulls
      .where((index) => index.dictionaryType == DictionaryTypes.yomitan
        && (!onlySequenced || (onlySequenced && index.sequenced == true)))
      .map((allIndex) =>
        (
          index: allIndex,
          usage: _indexUsage(allIndex.id)
        )
      ).toList();

  }

  /// Determines how an index is used across grouping rules
  IndexGroupingUsage _indexUsage(int indexId) {
    var rules = context.read<SearchProfilesEntry>().groupingRules;

    Set<int> usedIndexes = rules
      .map((e) => e.dictionaryIds)
      .flattened.toSet();

    if (rules[widget.i].targetDictIds.contains(indexId)) {
      return IndexGroupingUsage.usedInthisTarget;
    }
    else if (rules[widget.i].dictionaryIds.contains(indexId)) {
      return IndexGroupingUsage.usedInThisSource;
    }
    else if (usedIndexes.contains(indexId)) {
      return IndexGroupingUsage.usedInOther;
    } 
    else {
      return IndexGroupingUsage.unused;
    }
  }

  void _updateRuleAt(int index, DictionaryGroupingRule newRule) {
    // 1. Create a modified copy of the list
    final newRules = List<DictionaryGroupingRule>.from(
      context.read<SearchProfilesEntry>().groupingRules
    );
    newRules[index] = newRule;

    // 2. Update global settings
    GetIt.I<DaKanjiDB>().searchProfilesDao.updateProfile(
      context.read<SearchProfilesEntry>().copyWith(groupingRules: newRules)
    );
  }

  void _deleteRule(int index) {
    final currentRules = context.read<SearchProfilesEntry>().groupingRules;
    
    // Create a new list excluding the item at the current index
    final newRules = List<DictionaryGroupingRule>.from(currentRules)
      ..removeAt(index);

    GetIt.I<DaKanjiDB>().searchProfilesDao.updateProfile(
      context.read<SearchProfilesEntry>().copyWith(groupingRules: newRules)
    );
  }

  @override
  Widget build(BuildContext context) {

    var rules = context.read<SearchProfilesEntry>().groupingRules;
    int i = widget.i;
    var rule = rules[i];
    DakanjiDbLocalization loc = widget.localization;

    return Card(
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
        child: Column(
          children: [
            Table(
              defaultVerticalAlignment: .middle,
              children: [
                // Dropdown to select grouping rule type
                RuleTypeRow(
                  rule: rule,
                  loc: loc,
                  onChanged: (value) {
                    if (value != null) {
                      _updateRuleAt(i, groupingRuleStringToInstance[value]!());
                    }
                  },
                ),
                
                // Only SequenceGroupingRule: sequence source selector
                if (rule is SequenceGroupingRule) ...[
                  SourceSelectorRow(
                    rule: rule,
                    loc: loc,
                    availableIndexesFuture: _allAvaibleIndexes(true),
                    onChanged: (value) => _updateRuleAt(i, (rule.copyWith(sourceDictId: value)))
                  )
                ],
            
                // target dictionaries
                if(rule is! NoGroupingRule)
                  TargetSelectorRow(
                    rule: rule,
                    loc: loc,
                    onSelectPressed: () async {
                      await showAvailableIndexesDialog(
                        onSelected:(List<int> result) {
                          _updateRuleAt(i, (rule as dynamic).copyWith(targetDictIds: result.toSet()));
                        }
                      );
                    },
                  )
              ],
            ),
          
            Divider(),

            // Delete button
            OutlinedButton(
              onPressed: () => _deleteRule(i),
              child: Row(
                mainAxisSize: .min,
                children: [
                  Icon(Icons.delete),
                  SizedBox(width: 4,),
                  Text(widget.localization.delteRule),
                ],
              ),
            ),
            SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  Future<void> showAvailableIndexesDialog({
    required Function(List<int>) onSelected,
  }) async {
    
    // 1. Trigger the Future ONCE before opening the dialog.
    // This prevents the FutureBuilder from re-firing every time you tap a checkbox.
    Future<List<({IndexEntry index, IndexGroupingUsage usage})>> dataFuture
      = _allAvaibleIndexes(false);

    // 2. Track selections locally
    final Set<int> tempSelectedIds = {};
    bool isInitialized = false; // Flag to ensure we only pre-fill selections once

    return showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text(widget.localization.targetDictSelectDialogTitle),
              content: SizedBox(
                width: double.maxFinite,
                child: FutureBuilder<List<({IndexEntry index, IndexGroupingUsage usage})>>(
                  future: dataFuture,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const SizedBox(height: 50, child: Center(child: CircularProgressIndicator()));
                    }

                    final data = snapshot.data!;
                    
                    if (data.isEmpty) {
                      return Text(widget.localization.targetDictSelectDialogNoIndexes);
                    }

                    // 3. One-time Initialization: 
                    // Pre-fill checkboxes for items that are ALREADY used in this rule.
                    if (!isInitialized) {
                      final preSelected = data
                        .where((e) => e.usage == IndexGroupingUsage.usedInthisTarget)
                        .map((e) => e.index.id);
                      tempSelectedIds.addAll(preSelected);
                      isInitialized = true;
                    }

                    return ListView.separated(
                      shrinkWrap: true,
                      itemCount: data.length,
                      separatorBuilder: (_, _) => const Divider(height: 1),
                      itemBuilder: (context, i) {
                        final itemRecord = data[i];
                        final indexObj = itemRecord.index;
                        final usage = itemRecord.usage;

                        // Logic: 
                        // - 'usedInOther' -> DISABLED (Grey)
                        // - 'usedInThis' or 'unused' -> ENABLED (Selectable)
                        final isDisabled = usage == IndexGroupingUsage.usedInOther;

                        return CheckboxListTile(
                          title: Text(indexObj.title),
                          
                          // Show explanation if disabled
                          subtitle: isDisabled 
                              ? Text(
                                widget.localization.targetDictSelectDialogUsedInOtherRule,
                                style: TextStyle(color: Colors.grey, fontSize: 12)
                              ) 
                              : null,
                          
                          // Check if it is in our local set
                          value: tempSelectedIds.contains(indexObj.id),
                          
                          // 4. DISABLE LOGIC:
                          // Passing null to onChanged disables the tile
                          onChanged: isDisabled 
                              ? null 
                              : (bool? value) {
                                setState(() {
                                  if (value == true) {
                                    tempSelectedIds.add(indexObj.id);
                                  } else {
                                    tempSelectedIds.remove(indexObj.id);
                                  }
                                });
                              },
                        );
                      },
                    );
                  },
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(widget.localization.targetDictSelectDialogCancel),
                ),
                TextButton(
                  onPressed: () {
                    onSelected(tempSelectedIds.toList());
                    Navigator.pop(context);
                  },
                  child: Text(widget.localization.targetDictSelectDialogOK),
                ),
              ],
            );
          },
        );
      },
    );
  }

}

class RuleTypeRow extends TableRow {
  RuleTypeRow({
    required DictionaryGroupingRule rule,
    required DakanjiDbLocalization loc,
    required ValueChanged<String?> onChanged,
  }) : super(
          children: [
            Text(loc.groupby, style: const TextStyle(fontSize: 16)),
            DropdownButton<String>(
              value: getRuleString(rule),
              items: groupingOptions.map((opt) => 
                DropdownMenuItem(value: opt, child: Text(opt))
              ).toList(),
              onChanged: onChanged,
            ),
          ],
        );
}

class SourceSelectorRow extends TableRow {
  SourceSelectorRow({
    required SequenceGroupingRule rule,
    required DakanjiDbLocalization loc,
    required Future<List<({IndexEntry index, IndexGroupingUsage usage})>> availableIndexesFuture,
    required ValueChanged<int?> onChanged,
  }) : super(
          children: [
            Text(loc.source, style: const TextStyle(fontSize: 16)),
            FutureBuilder<List<({IndexEntry index, IndexGroupingUsage usage})>>(
              future: availableIndexesFuture,
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const SizedBox();
                return DropdownButton<int?>(
                  isExpanded: true,
                  value: rule.sourceDictId,
                  items: snapshot.data!.map((e) => DropdownMenuItem(
                    value: e.index.id,
                    child: Text(e.index.title, overflow: TextOverflow.ellipsis),
                  )).toList(),
                  onChanged: onChanged,
                );
              },
            ),
          ],
        );
}

class TargetSelectorRow extends TableRow {
  TargetSelectorRow({
    required DictionaryGroupingRule rule,
    required DakanjiDbLocalization loc,
    required VoidCallback onSelectPressed,
  }) : super(
          children: [
            Text(
              "${loc.targets} (${rule.targetDictIds.length})",
              style: const TextStyle(fontSize: 16),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                onPressed: onSelectPressed,
                child: Text(loc.select),
              ),
            ),
          ],
        );
}