import 'package:dakanji_db_core/database/dakanji_db.dart';
import 'package:dakanji_db_core/database/search_profiles/search_profiles_entry.dart';
import 'package:dakanji_db_ui/model/dakanji_db_localization.dart';
import 'package:dakanji_db_ui/widgets/settings/dictionary_management/dakanji_db_dictionary_management_widget.dart';
import 'package:dakanji_db_ui/widgets/settings/grouping_rules/search_profile_settings_grouping_widget.dart';
import 'package:dakanji_db_ui/widgets/settings/search_profile_management_widget.dart';
import 'package:dakanji_db_ui/widgets/settings/search_profile_settings_category_separator.dart';
import 'package:dakanji_db_ui/widgets/settings/search_profile_settings_frequency_dictionary_dropdown.dart';
import 'package:dakanji_db_ui/widgets/settings/search_profile_settings_heading.dart';
import 'package:dakanji_db_ui/widgets/settings/search_profile_settings_info_widgets.dart';
import 'package:dakanji_db_ui/widgets/settings/search_profile_settings_search_result_sort_order.dart';
import 'package:dakanji_db_ui/widgets/settings/search_profile_settings_toggle_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class SearchProfileSettingsWidget extends StatefulWidget {

  const SearchProfileSettingsWidget({super.key});

  @override
  State<SearchProfileSettingsWidget> createState() => _SearchProfileSettingsWidgetState();
}

class _SearchProfileSettingsWidgetState extends State<SearchProfileSettingsWidget> {
  @override
  Widget build(BuildContext context) {

    final loc = GetIt.I<DakanjiDbLocalization>();

    return Column(
      mainAxisAlignment: .start,
      crossAxisAlignment: .start,
      mainAxisSize: .min,
      children: [
        // TODO localization
        SearchProfileSettingsHeading("Search Profiles"),
        InfoPopupButton(
          title: "Search Profiles",
          infoText:
"""
**What are search profiles?**

Search profiles allow you to customize how searches are performed.
You can create multiple profiles for different use cases, such as reading, or listening.
For example, you might want the spellfix disabled when reading, but enabled when listening to catch misheard words.
Once you have setup your profiles, you can switch between them using the dropdown menu in the app bar of each screen that uses the dictionary.
""",
        ),
        SearchProfileManagementWidget(),

        SearchProfileSettingsHeading(loc.dictionariesHeader),
        InfoPopupButton(
          title: "Global frequency dictionary",
          infoText:
"""
**Global Frequency Sorting**

Uses this dictionary to sort all search results by popularity. 

This merges your dictionaries together, showing the most common words first regardless of which dictionary they come from.
"""
        ),
        SearchProfileSettingsFrequencyDictionaryDropdown(),

        InfoPopupButton(
          // TODO localization
          title: "Dictionary Management",
          infoText:
"""
**How to configure your dictionaries**

The order of this list determines which definitions you see first.
Drag and drop your favorite dictionaries to the top so their results appear before others.

**Note on Frequency:** If you have set a "Frequency Sort Source" above, results will be sorted by popularity instead.
This manual list order is then used only when words are equally popular.

You can also toggle specific dictionaries off to hide them without deleting them.
Custom dictionaries can be imported to further expand your library.
"""
        ),
        DaKanjiDbDictionaryManagementWidget(),
    
        SearchProfileSettingsHeading(loc.displayHeader),
        SearchProfileSettingsToggleListTile(
          title: loc.showSeparatorsTitle,
          subtitle: loc.showSeparatorsSubtitle,
          value: context.watch<SearchProfilesEntry>().showSearchResultSeparationHeaders,
          onChanged: (v) => GetIt.I<DaKanjiDB>().searchProfilesDao.updateProfile(
            context.read<SearchProfilesEntry>().copyWith(showSearchResultSeparationHeaders: v)
          )
        ),
        SearchProfileSettingsToggleListTile(
          // TODO localization
          title: "Show Kanji Entries",
          subtitle: "Should Kanji entries be shown in search results when searching for single characters",
          value: context.watch<SearchProfilesEntry>().showKanjiEntriesInSearchResults,
          onChanged: (v) => GetIt.I<DaKanjiDB>().searchProfilesDao.updateProfile(
            context.read<SearchProfilesEntry>().copyWith(showKanjiEntriesInSearchResults: v)
          )
        ),
        SearchProfileSettingsToggleListTile(
          title: loc.showTagsTitle,
          subtitle: loc.showTagsSubtitle,
          value: context.watch<SearchProfilesEntry>().showTags,
          onChanged: (v) => GetIt.I<DaKanjiDB>().searchProfilesDao.updateProfile(
            context.read<SearchProfilesEntry>().copyWith(showTags: v)
          )
        ),
        SearchProfileSettingsToggleListTile(
          title: loc.showMetaEntriesTitle,
          subtitle: loc.showMetaEntriesSubtitle,
          value: context.watch<SearchProfilesEntry>().showMetaEntries,
          onChanged: (v) => GetIt.I<DaKanjiDB>().searchProfilesDao.updateProfile(
            context.read<SearchProfilesEntry>().copyWith(showMetaEntries: v)
          )
        ),

        // TODO: switch to spinningbox and use the set value directly
        SearchProfileSettingsToggleListTile(
          title: loc.useCompactDefinitionsTitle,
          subtitle: loc.useCompactDefinitionsSubtitle,
          value: context.watch<SearchProfilesEntry>().definitionsMaxHeight > 0,
          onChanged: (v) => GetIt.I<DaKanjiDB>().searchProfilesDao.updateProfile(
            context.read<SearchProfilesEntry>().copyWith(definitionsMaxHeight: v ? 60.0 : 0.0)
          )
        ),
        SearchProfileSettingsToggleListTile(
          // TODO localization
          title: loc.useKatakanaForFuriganaTitle,
          subtitle: "Should katakana be used for furigana readings regardless of the defined reading",
          value: context.watch<SearchProfilesEntry>().useKatakanaForFurigana,
          onChanged: (v) => GetIt.I<DaKanjiDB>().searchProfilesDao.updateProfile(
            context.read<SearchProfilesEntry>().copyWith(useKatakanaForFurigana: v)
          )
        ),
        SearchProfileSettingsToggleListTile(
          // TODO localization
          title: "Flexible Search Converts Romaji",
          subtitle: "Should romaji input also be converted to hiragana for flexible search matching",
          value: context.watch<SearchProfilesEntry>().normalizeSearchConvertsRomajiToHiragana,
          onChanged: (v) => GetIt.I<DaKanjiDB>().searchProfilesDao.updateProfile(
            context.read<SearchProfilesEntry>().copyWith(normalizeSearchConvertsRomajiToHiragana: v)
          )
        ),
          
        SearchProfileSettingsCategorySeparator(),
        SearchProfileSettingsHeading(loc.sortOrderTitle),
        SearchProfileSettingsSearchResultSortOrder(
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
        SearchProfileSettingsSearchResultSortOrder(
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
          
        SearchProfileSettingsCategorySeparator(),
        SearchProfileSettingsHeading(loc.groupingTitle),
        SearchProfileSettingsGroupingWidget(),
      
        SearchProfileSettingsCategorySeparator(),
        SearchProfileSettingsHeading(loc.miscTitle),

        // TODO Search result limit

        // TODO: spellfix max results
        // TODO: spellfix max cost

        // TODO: Export dictionaries
        // TODO: Import dictionaries
      ],
    );
  
  }
}