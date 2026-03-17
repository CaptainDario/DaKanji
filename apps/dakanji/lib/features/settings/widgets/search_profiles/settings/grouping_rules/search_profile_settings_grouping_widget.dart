import 'package:da_db/data/grouping_rules.dart';
import 'package:da_db/database/da_db.dart';
import 'package:da_db/database/search_profiles/search_profiles_entry.dart';
import 'package:da_kanji_mobile/features/settings/widgets/search_profiles/settings/grouping_rules/search_profile_settings_grouping_rule_card.dart';
import 'package:da_kanji_mobile/features/settings/widgets/search_profiles/settings//search_profile_settings_card_add_button.dart';
import 'package:da_kanji_mobile/features/settings/widgets/search_profiles/settings//search_profile_settings_info_widgets.dart';
import 'package:da_kanji_mobile/locales_keys.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';


final List<String> groupingOptions = [
  LocaleKeys.SettingsScreenSearchProfiles_grouping_options_no_grouping.tr(),
  LocaleKeys.SettingsScreenSearchProfiles_grouping_options_term.tr(),
  LocaleKeys.SettingsScreenSearchProfiles_grouping_options_term_reading.tr(),
  LocaleKeys.SettingsScreenSearchProfiles_grouping_options_sequence_number.tr(),
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

    var settings = context.watch<SearchProfilesEntry>();
    var rules = settings.groupingRules;

    return Column(
      crossAxisAlignment: .stretch,
      children: [

        InfoPopupButton(
          title: LocaleKeys.SettingsScreenSearchProfiles_configure_grouping_title.tr(),
          infoText: LocaleKeys.SettingsScreenSearchProfiles_grouping_explanation.tr()
        ),

        for (int i = 0; i < rules.length; i++) 
          SearchProfileSettingsGroupingRuleCard(i),

        // The add button
        SearchProfileSearchProfileCardAddButton(
          LocaleKeys.SettingsScreenSearchProfiles_add_rule.tr(),
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

