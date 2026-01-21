import 'package:dakanji_db_ui/model/dakanji_db_settings.dart';
import 'package:dakanji_db_ui/widgets/model/dakanji_db_localization.dart';
import 'package:dakanji_db_ui/widgets/settings/dakanji_db_settings_category_separator.dart';
import 'package:dakanji_db_ui/widgets/settings/dakanji_db_settings_heading.dart';
import 'package:dakanji_db_ui/widgets/settings/dakanji_db_settings_search_result_sort_order.dart';
import 'package:dakanji_db_ui/widgets/settings/dakanji_db_settings_toggle_list_tile.dart';
import 'package:dakanji_db_ui/widgets/settings/dictionary_management/dakanji_db_dictionary_management_widget.dart';
import 'package:dakanji_db_ui/widgets/settings/grouping_rules/dakanji_db_settings_grouping_widget.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class DakanjiDbSettingsWidget extends StatefulWidget {

  const DakanjiDbSettingsWidget({super.key});

  @override
  State<DakanjiDbSettingsWidget> createState() => _DakanjiDbSettingsWidgetState();
}

class _DakanjiDbSettingsWidgetState extends State<DakanjiDbSettingsWidget> {
  @override
  Widget build(BuildContext context) {

    final loc = GetIt.I<DakanjiDbLocalization>();
    final s = context.watch<DaKanjiDbSettings>();
    final si = s.settings;

    return Column(
      mainAxisAlignment: .start,
      crossAxisAlignment: .start,
      mainAxisSize: .min,
      children: [
        DakanjiDbSettingsHeading(loc.dictionariesHeader),
        DakanjiDbDictionaryManagementWidget(),
    
        DakanjiDbSettingsHeading(loc.displayHeader),
        DakanjiDbSettingsToggleListTile(
          title: loc.showSeparatorsTitle,
          subtitle: loc.showSeparatorsSubtitle,
          value: si.showSearchResultSeparationHeaders,
          onChanged: (v) => s.update(si.copyWith(
            showSearchResultSeparationHeaders: v))
        ),
        DakanjiDbSettingsToggleListTile(
          title: loc.showTagsTitle,
          subtitle: loc.showTagsSubtitle,
          value: si.showTags,
          onChanged: (v) => s.update(si.copyWith(showTags: v))
        ),
        DakanjiDbSettingsToggleListTile(
          title: loc.showMetaEntriesTitle,
          subtitle: loc.showMetaEntriesSubtitle,
          value: si.showMetaEntries,
          onChanged: (v) => s.update(si.copyWith(
              showMetaEntries: v
            ))
        ),
        DakanjiDbSettingsToggleListTile(
          title: loc.useCompactDefinitionsTitle,
          subtitle: loc.useCompactDefinitionsSubtitle,
          value: si.definitionsMaxHeight > 0,
          onChanged: (v) => s.update(si.copyWith(
              definitionsMaxHeight: v ? 60.0 : 0.0
            ))
        ),
        DakanjiDbSettingsToggleListTile(
          title: loc.useKatakanaForFuriganaTitle,
          value: si.useKatakanaForFurigana,
          onChanged: (v) => s.update(si.copyWith(
              useKatakanaForFurigana: v
            ))
        ),
          
        DakanjiDbSettingsCategorySeparator(),
        DakanjiDbSettingsHeading(loc.sortOrderTitle),
        DakanjiDbSettingsSearchResultSortOrder(
          firstSortOrder: true,
          
          title: loc.sortByTitle,
          infoText: loc.sortByText,
          optionNames: [
            loc.sortByDirectMatch,
            loc.sortByFlexibleMatch,
            loc.sortBySmartGrammarMatch,
            loc.sortByTypoCorrectionMatch,
          ],
        ),
        DakanjiDbSettingsSearchResultSortOrder(
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
        DakanjiDbSettingsGroupingWidget(),
      
        DakanjiDbSettingsCategorySeparator(),
        DakanjiDbSettingsHeading(loc.miscTitle),

        // TODO Search result limit

        // TODO: spellfix max results
        // TODO: spellfix max cost

        // TODO: Export dictionaries
        // TODO: Import dictionaries
      ],
    );
  
  }
}