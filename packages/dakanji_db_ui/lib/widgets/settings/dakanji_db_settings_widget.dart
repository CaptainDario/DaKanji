import 'package:dakanji_db_core/database/dakanji_db.dart';
import 'package:dakanji_db_core/database/db_queries/dictionary_search/grouping_rules.dart';
import 'package:dakanji_db_ui/model/dakanji_db_settings.dart';
import 'package:dakanji_db_ui/widgets/model/dakanji_db_settings_localization.dart';
import 'package:dakanji_db_ui/widgets/settings/dakanji_db_settings_category_separator.dart';
import 'package:dakanji_db_ui/widgets/settings/dakanji_db_settings_grouping_widget.dart';
import 'package:dakanji_db_ui/widgets/settings/dakanji_db_settings_heading.dart';
import 'package:dakanji_db_ui/widgets/settings/dakanji_db_settings_search_result_sort_order.dart';
import 'package:dakanji_db_ui/widgets/settings/dakanji_db_settings_toggle_list_tile.dart';
import 'package:dakanji_db_ui/widgets/settings/dictionary_management/dakanji_db_dictionary_management_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DakanjiDbSettingsWidget extends StatelessWidget {

  final DaKanjiDB db;

  final DaKanjiDbSettings settings;

  final DakanjiDbSettingsLocalization localization;

  const DakanjiDbSettingsWidget(
    this.db,
    this.settings,
    this.localization,
    {
      super.key
    }
  );

  @override
  Widget build(BuildContext context) {
    final loc = localization;
    return Provider<DaKanjiDbSettings>.value(
      value: settings,
      child: Column(
        mainAxisAlignment: .start,
        crossAxisAlignment: .start,
        mainAxisSize: .min,
        children: [
          DakanjiDbSettingsHeading(loc.dictionariesHeader),
          DakanjiDbDictionaryManagementWidget(db, localization),
      
          DakanjiDbSettingsHeading(loc.displayHeader),
          DakanjiDbSettingsToggleListTile(
            title: loc.showSeparatorsTitle,
            subtitle: loc.showSeparatorsSubtitle,
            value: settings.showSearchResultSeparationHeaders,
            onChanged: (v)
              => settings.showSearchResultSeparationHeaders = v,
          ),
          DakanjiDbSettingsToggleListTile(
            title: loc.showTagsTitle,
            subtitle: loc.showTagsSubtitle,
            value: settings.showTags,
            onChanged: (v) => settings.showTags = v,
          ),
          DakanjiDbSettingsToggleListTile(
            title: loc.showMetaEntriesTitle,
            subtitle: loc.showMetaEntriesSubtitle,
            value: settings.showMetaEntries,
            onChanged: (v) => settings.showMetaEntries = v,
          ),
          DakanjiDbSettingsToggleListTile(
            title: loc.useCompactDefinitionsTitle,
            subtitle: loc.useCompactDefinitionsSubtitle,
            value: settings.definitionsMaxHeight > 0,
            onChanged: (v) => settings.definitionsMaxHeight = v ? 60.0 : 0.0,
          ),
            
          DakanjiDbSettingsCategorySeparator(),
          DakanjiDbSettingsHeading(loc.sortOrderTitle),
          DakanjiDbSettingsSearchResultSortOrder(
            settings: settings,
            firstSortOrder: true,
            
            title: loc.sortByTitle,
            infoText: loc.sortByText,
            optionNames: [
              loc.sortByExactMatch,
              loc.sortByFlexibleMatch,
              loc.sortBySmartGrammarMatch,
              loc.sortByTypoCorrectionMatch,
            ],
          ),
          DakanjiDbSettingsSearchResultSortOrder(
            settings: settings,
            secondSortOrder: true,
            
            title: loc.thenByTitle,
            infoText: loc.thenByText,
            optionNames: [
              loc.thenByExactMatch,
              loc.thenByStartsWithMatch,
              loc.thenBySubwordMatch,
              loc.thenByWildcardMatch,
            ],
          ),
            
          DakanjiDbSettingsCategorySeparator(),
          DakanjiDbSettingsHeading(loc.groupingTitle),
          DakanjiDbSettingsGroupingWidget(
            
          ),

          DakanjiDbSettingsToggleListTile(
            title: "Group by term",
            subtitle: "Group identical entries (term only) together",
            value: settings.groupingRule is TermAndReadingGroupingRule,
            onChanged: (v) => 
              settings.groupingRule = v
                ? [TermAndReadingGroupingRule({3, 4})]
                : [NoGroupingRule()],
          ),
          DakanjiDbSettingsToggleListTile(
            title: "Group by term and reading",
            subtitle: "Group identical entries (term + reading) together",
            value: settings.groupingRule is TermGroupingRule,
            onChanged: (v) =>
              settings.groupingRule = v
                ? [TermGroupingRule({3, 4})]
                : [NoGroupingRule()],
          ),
          DakanjiDbSettingsToggleListTile(
            title: "Group by Sequence",
            subtitle: "Group results by their sequence id",
            value: settings.groupingRule is SequenceGroupingRule,
            onChanged: (v) =>
              settings.groupingRule = v
                ? [SequenceGroupingRule(
                  sourceDictId: 3,
                  targetDictIds: {3, 4}
                )]
                : [NoGroupingRule()],
          ),
        
          DakanjiDbSettingsCategorySeparator(),
          DakanjiDbSettingsHeading(loc.miscTitle),
        ],
      ),
    );
  }
}