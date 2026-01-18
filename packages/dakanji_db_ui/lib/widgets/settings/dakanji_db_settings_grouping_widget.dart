import 'package:collection/collection.dart';
import 'package:dakanji_db_core/data/dictionary_types.dart';
import 'package:dakanji_db_core/database/dakanji_db.dart';
import 'package:dakanji_db_core/database/db_queries/dictionary_search/grouping_rules.dart';
import 'package:dakanji_db_ui/model/dakanji_db_settings.dart';
import 'package:dakanji_db_ui/widgets/model/dakanji_db_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


final List<String> groupingOptions = [
  "No Grouping",
  "Term",
  "Term + Reading",
  "Sequence Number",
];

String getRuleString(DictionaryGroupingRule rule) {
  if (rule is NoGroupingRule) return groupingOptions[0];
  if (rule is TermGroupingRule) return groupingOptions[1];
  if (rule is TermAndReadingGroupingRule) return groupingOptions[2];
  if (rule is SequenceGroupingRule) return groupingOptions[3];
  return groupingOptions[0];
}

final Map<String, Function> groupingRuleStringToInstance = {
  groupingOptions[0] : () => NoGroupingRule(),
  groupingOptions[1] : () => TermGroupingRule({}),
  groupingOptions[2] : () => TermAndReadingGroupingRule({}),
  groupingOptions[3] : () => SequenceGroupingRule(sourceDictId: null, targetDictIds: {}),
};

enum IndexGroupingUsage {
  unused,
  usedInThis,
  usedInOther
}

class DakanjiDbSettingsGroupingWidget extends StatefulWidget {

  final DakanjiDbLocalization localization;

  const DakanjiDbSettingsGroupingWidget(
    this.localization,
    {
      super.key
    }
  );

  @override
  State<DakanjiDbSettingsGroupingWidget> createState() => _DakanjiDbSettingsGroupingWidgetState();
}

class _DakanjiDbSettingsGroupingWidgetState extends State<DakanjiDbSettingsGroupingWidget> {

  @override
  Widget build(BuildContext context) {

    var settings = context.read<DaKanjiDbSettings>();
    var rules = settings.s.groupingRules;

    return Column(
      crossAxisAlignment: .stretch,
      children: [

        ListTile(
          leading: IconButton(
            icon: Icon(Icons.info_outline),
            onPressed: () {}
          ),
          title: Text(widget.localization.configureGroupingTitle),
        ),

        for (int i = 0; i < rules.length; i++) ...[
          GroupingRuleCard(i, widget.localization)
        ],

        // The add button
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Align(
            alignment: .centerRight,
            child: IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                settings.update(settings.s.copyWith(
                  groupingRules: [...rules, NoGroupingRule()]
                ));
              }
            ),
          ),
        )
      ]
    );
  }
}

/// A card representing a single grouping rule
/// 
/// Note: This REQUIRES a [DaKanjiDbSettings] provider in the widget tree.
class GroupingRuleCard extends StatefulWidget {

  final int i;

  final DakanjiDbLocalization localization;

  const GroupingRuleCard(
    this.i,
    this.localization,
    {
      super.key
    }
  );

  @override
  State<GroupingRuleCard> createState() => _GroupingRuleCardState();
}

class _GroupingRuleCardState extends State<GroupingRuleCard> {

  /// Returns all indexes with a flag indicating their usage in any rule
  Future<List<({IndexTableData index, IndexGroupingUsage usage})>> _allAvaibleIndexes() async {

    List<IndexTableData> allIndexes =
      await context.read<DaKanjiDB>().indexDao.getAllIndexes();

    return allIndexes.nonNulls
      .where((index) => index.dictionaryType == DictionaryTypes.yomitan)
      .map((allIndex) =>
        (
          index: allIndex,
          usage: _indexUsage(allIndex.id)
        )
      ).toList();

  }

  /// Determines how an index is used across grouping rules
  IndexGroupingUsage _indexUsage(int indexId) {
    var rules = context.read<DaKanjiDbSettings>().s.groupingRules;

    Set<int> usedIndexes = rules
      .map((e) => e.dictionaryIds)
      .flattened.toSet();

    if (rules[widget.i].dictionaryIds.contains(indexId)) {
      return IndexGroupingUsage.usedInThis;
    } else if (usedIndexes.contains(indexId)) {
      return IndexGroupingUsage.usedInOther;
    } else {
      return IndexGroupingUsage.unused;
    }
  }

  void _updateRuleAt(int index, DictionaryGroupingRule newRule) {
    // 1. Create a modified copy of the list
    final newRules = List<DictionaryGroupingRule>.from(
      context.read<DaKanjiDbSettings>().s.groupingRules
    );
    newRules[index] = newRule;

    // 2. Update global settings
    context.read<DaKanjiDbSettings>().update(
      context.read<DaKanjiDbSettings>().s.copyWith(groupingRules: newRules)
    );
  }

  @override
  Widget build(BuildContext context) {

    var rules = context.read<DaKanjiDbSettings>().s.groupingRules;
    int i = widget.i;
    var rule = rules[i];
    DakanjiDbLocalization loc = widget.localization;

    return Card(
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
        child: Table(
          defaultVerticalAlignment: .middle,
          children: [
            // Dropdown to select grouping rule type
            TableRow(
              children: [
                Text(loc.groupby, style: TextStyle(fontSize: 16),),
                DropdownButton<String>(
                  value: getRuleString(rule),
                  items: List.generate(groupingOptions.length, (int i) =>
                    DropdownMenuItem<String>(
                      value: groupingOptions[i],
                      child: Text(groupingOptions[i]),
                    ),
                  ),
                  onChanged: (value) {
                    if (value != null) {
                      _updateRuleAt(i, groupingRuleStringToInstance[value]!());
                    }
                  },
                ),
              ],
            ),
            
            // Only SequenceGroupingRule: sequence source selector
            if (rule is SequenceGroupingRule) ...[
              TableRow(
                children: [
                  Text(loc.source, style: TextStyle(fontSize: 16),),
                  FutureBuilder(
                    future: _allAvaibleIndexes(),
                    builder: (context, asyncSnapshot) {

                      if(!asyncSnapshot.hasData && asyncSnapshot.data != null) return SizedBox();

                      return DropdownButton<int?>(
                        isExpanded: true,
                        value: rule.sourceDictId,
                        items: asyncSnapshot.data?.map((e) =>
                          DropdownMenuItem<int?>(
                            value: e.index.id,
                            child: Text(e.index.title, overflow: .ellipsis,),
                          )
                        ).toList(),
                        onChanged: (value) {
                          _updateRuleAt(
                            i, (rule.copyWith(sourceDictId: value)));
                        }
                      );
                    }
                  ),
                ]
              )
            ],

            // target dictionaries
            if(rule is! NoGroupingRule)
              TableRow(
                children: [
                  Text(
                    "${loc.targets} (${rule.targetDictIds.length})",
                    style: TextStyle(fontSize: 16),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(
                      onPressed: () async {
                        await showAvailableIndexesDialog(
                          onSelected:(List<int> result) {
                            _updateRuleAt(
                              i, 
                              (rule as dynamic).copyWith(targetDictIds: result.toSet())
                            );
                          }
                        );
                      },
                      child: Text(loc.select)
                    ),
                  )
                ]
              ),
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
    final Future<List<({IndexTableData index, IndexGroupingUsage usage})>> dataFuture = _allAvaibleIndexes();

    // 2. Track selections locally
    final Set<int> tempSelectedIds = {};
    bool isInitialized = false; // Flag to ensure we only pre-fill selections once

    return showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text("Select Sources"),
              content: SizedBox(
                width: double.maxFinite,
                child: FutureBuilder<List<({IndexTableData index, IndexGroupingUsage usage})>>(
                  future: dataFuture,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const SizedBox(height: 50, child: Center(child: CircularProgressIndicator()));
                    }

                    final data = snapshot.data!;
                    
                    if (data.isEmpty) {
                      return const Text("No indexes found.");
                    }

                    // 3. One-time Initialization: 
                    // Pre-fill checkboxes for items that are ALREADY used in this rule.
                    if (!isInitialized) {
                      final preSelected = data
                          .where((e) => e.usage == IndexGroupingUsage.usedInThis)
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
                              ? const Text("Used in another rule", style: TextStyle(color: Colors.grey, fontSize: 12)) 
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
                  child: const Text("Cancel"),
                ),
                TextButton(
                  onPressed: () {
                    onSelected(tempSelectedIds.toList());
                    Navigator.pop(context);
                  },
                  child: const Text("OK"),
                ),
              ],
            );
          },
        );
      },
    );
  }

}
