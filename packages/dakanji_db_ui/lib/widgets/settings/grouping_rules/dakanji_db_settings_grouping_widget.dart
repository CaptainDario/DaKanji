import 'package:dakanji_db_core/database/db_queries/dictionary_search/grouping_rules.dart';
import 'package:dakanji_db_ui/model/dakanji_db_settings.dart';
import 'package:dakanji_db_ui/widgets/model/dakanji_db_localization.dart';
import 'package:dakanji_db_ui/widgets/settings/dakanji_db_settings_card_add_button.dart';
import 'package:dakanji_db_ui/widgets/settings/dakanji_db_settings_info_widgets.dart';
import 'package:dakanji_db_ui/widgets/settings/grouping_rules/dakanji_db_settings_grouping_rule_card.dart';
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
  usedInThisSource,
  usedInthisTarget,
  usedInOther
}

class DakanjiDbSettingsGroupingWidget extends StatefulWidget {

  const DakanjiDbSettingsGroupingWidget({super.key});

  @override
  State<DakanjiDbSettingsGroupingWidget> createState() => _DakanjiDbSettingsGroupingWidgetState();
}

class _DakanjiDbSettingsGroupingWidgetState extends State<DakanjiDbSettingsGroupingWidget> {

  @override
  Widget build(BuildContext context) {

    var loc = context.read<DakanjiDbLocalization>();
    var settings = context.read<DaKanjiDbSettings>();
    var rules = settings.s.groupingRules;

    return Column(
      crossAxisAlignment: .stretch,
      children: [

        ListTile(
          leading: IconButton(
            icon: Icon(Icons.info_outline),
            onPressed: () async {
              await showSettingsInfoPopup(loc.groupingExplanation, context);
            }
          ),
          title: Text(loc.configureGroupingTitle),
        ),

        for (int i = 0; i < rules.length; i++) 
          GroupingRuleCard(i, loc),

        // The add button
        DakanjiDbSettingsCardAddButton(
          loc.addRule,
          onPressed: () {
            settings.update(settings.s.copyWith(
              groupingRules: [...rules, NoGroupingRule()]
            ));
          }
        )
      ]
    );
  }
}

