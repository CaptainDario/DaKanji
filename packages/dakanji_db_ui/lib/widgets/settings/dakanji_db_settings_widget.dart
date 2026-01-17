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

class DakanjiDbSettingsWidget extends StatefulWidget {

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
  State<DakanjiDbSettingsWidget> createState() => _DakanjiDbSettingsWidgetState();
}

class _DakanjiDbSettingsWidgetState extends State<DakanjiDbSettingsWidget> {
  @override
  Widget build(BuildContext context) {
    final loc = widget.localization;
    return Provider<DaKanjiDbSettings>.value(
      value: widget.settings,
      child: Column(
        mainAxisAlignment: .start,
        crossAxisAlignment: .start,
        mainAxisSize: .min,
        children: [
          DakanjiDbSettingsHeading(loc.dictionariesHeader),
          DakanjiDbDictionaryManagementWidget(widget.db, widget.localization),
      
          DakanjiDbSettingsHeading(loc.displayHeader),
          DakanjiDbSettingsToggleListTile(
            title: loc.showSeparatorsTitle,
            subtitle: loc.showSeparatorsSubtitle,
            value: widget.settings.showSearchResultSeparationHeaders,
            onChanged: (v) => setState(() {
                widget.settings.showSearchResultSeparationHeaders = v;
              }) 
          ),
          DakanjiDbSettingsToggleListTile(
            title: loc.showTagsTitle,
            subtitle: loc.showTagsSubtitle,
            value: widget.settings.showTags,
            onChanged: (v) => setState(() {
              widget.settings.showTags = v;
            })
          ),
          DakanjiDbSettingsToggleListTile(
            title: loc.showMetaEntriesTitle,
            subtitle: loc.showMetaEntriesSubtitle,
            value: widget.settings.showMetaEntries,
            onChanged: (v) => setState(() {
              widget.settings.showMetaEntries = v;
            })
          ),
          DakanjiDbSettingsToggleListTile(
            title: loc.useCompactDefinitionsTitle,
            subtitle: loc.useCompactDefinitionsSubtitle,
            value: widget.settings.definitionsMaxHeight > 0,
            onChanged: (v) => setState(() {
              widget.settings.definitionsMaxHeight = v ? 60.0 : 0.0;
            })
          ),
          DakanjiDbSettingsToggleListTile(
            title: loc.useKatakanaForFuriganaTitle,
            value: widget.settings.useKatakanaForFurigana,
            onChanged: (v) => setState(() {
              widget.settings.useKatakanaForFurigana = v;
            })
          ),
            
          DakanjiDbSettingsCategorySeparator(),
          DakanjiDbSettingsHeading(loc.sortOrderTitle),
          DakanjiDbSettingsSearchResultSortOrder(
            settings: widget.settings,
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
            settings: widget.settings,
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
            value: widget.settings.groupingRule is TermAndReadingGroupingRule,
            onChanged: (v) => 
              widget.settings.groupingRule = v
                ? [TermAndReadingGroupingRule({3, 4})]
                : [NoGroupingRule()],
          ),
          DakanjiDbSettingsToggleListTile(
            title: "Group by term and reading",
            subtitle: "Group identical entries (term + reading) together",
            value: widget.settings.groupingRule is TermGroupingRule,
            onChanged: (v) =>
              widget.settings.groupingRule = v
                ? [TermGroupingRule({3, 4})]
                : [NoGroupingRule()],
          ),
          DakanjiDbSettingsToggleListTile(
            title: "Group by Sequence",
            subtitle: "Group results by their sequence id",
            value: widget.settings.groupingRule is SequenceGroupingRule,
            onChanged: (v) =>
              widget.settings.groupingRule = v
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