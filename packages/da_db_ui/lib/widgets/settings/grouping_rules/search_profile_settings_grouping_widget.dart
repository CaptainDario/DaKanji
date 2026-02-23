import 'package:da_db/database/da_db.dart';
import 'package:da_db/database/db_queries/dictionary_search/grouping_rules.dart';
import 'package:da_db/database/search_profiles/search_profiles_entry.dart';
import 'package:da_db_ui/model/da_db_localization.dart';
import 'package:da_db_ui/widgets/settings/grouping_rules/search_profile_settings_grouping_rule_card.dart';
import 'package:da_db_ui/widgets/settings/search_profile_settings_card_add_button.dart';
import 'package:da_db_ui/widgets/settings/search_profile_settings_info_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
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

class SearchProfileSettingsGroupingWidget extends StatefulWidget {

  const SearchProfileSettingsGroupingWidget({super.key});

  @override
  State<SearchProfileSettingsGroupingWidget> createState() => _SearchProfileSettingsGroupingWidgetState();
}

class _SearchProfileSettingsGroupingWidgetState extends State<SearchProfileSettingsGroupingWidget> {

  @override
  Widget build(BuildContext context) {

    var loc = GetIt.I<DaDbLocalization>();
    var settings = context.watch<SearchProfilesEntry>();
    var rules = settings.groupingRules;

    return Column(
      crossAxisAlignment: .stretch,
      children: [

        InfoPopupButton(
          title: loc.configureGroupingTitle,
          infoText: loc.groupingExplanation
        ),

        for (int i = 0; i < rules.length; i++) 
          SearchProfileSettingsGroupingRuleCard(i, loc),

        // The add button
        SearchProfileSearchProfileCardAddButton(
          loc.addRule,
          onPressed: () {
            GetIt.I<DaDb>().searchProfilesDao.updateProfile(
              settings.copyWith(
                groupingRules: [...rules, NoGroupingRule()]
              )
            );
          }
        )
      ]
    );
  }
}

