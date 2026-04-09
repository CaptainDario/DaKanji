import 'package:da_db/database/da_db.dart';
import 'package:da_db/database/search_profiles/search_profiles_entry.dart';
import 'package:da_kanji_mobile/features/settings/widgets/search_profiles/settings//grouping_rules/search_profile_settings_grouping_widget.dart';
import 'package:da_kanji_mobile/features/settings/widgets/search_profiles/settings//search_profile_management_widget.dart';
import 'package:da_kanji_mobile/features/settings/widgets/search_profiles/settings//search_profile_settings_category_separator.dart';
import 'package:da_kanji_mobile/features/settings/widgets/search_profiles/settings//search_profile_settings_frequency_dictionary_dropdown.dart';
import 'package:da_kanji_mobile/features/settings/widgets/search_profiles/settings//search_profile_settings_heading.dart';
import 'package:da_kanji_mobile/features/settings/widgets/search_profiles/settings//search_profile_settings_info_widgets.dart';
import 'package:da_kanji_mobile/features/settings/widgets/search_profiles/settings//search_profile_settings_search_result_sort_order.dart';
import 'package:da_kanji_mobile/features/settings/widgets/search_profiles/settings//search_profile_settings_toggle_list_tile.dart';
import 'package:da_kanji_mobile/features/settings/widgets/search_profiles/settings/dictionary_management/dictionary_management_widget.dart';
import 'package:da_kanji_mobile/locales_keys.dart';
import 'package:easy_localization/easy_localization.dart';
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

    return Column(
      mainAxisAlignment: .start,
      crossAxisAlignment: .start,
      mainAxisSize: .min,
      children: [
        // --- Search Profile Management ---
        SearchProfileSettingsHeading(LocaleKeys.SettingsScreenSearchProfiles_search_profiles_title.tr()),
        InfoPopupButton(
          title: LocaleKeys.SettingsScreenSearchProfiles_search_profiles_title.tr(),
          infoText: LocaleKeys.SettingsScreenSearchProfiles_search_profiles_info_text.tr(),
        ),
        SearchProfileManagementWidget(),

        SearchProfileSettingsHeading(LocaleKeys.SettingsScreenSearchProfiles_dictionaries_header.tr()),
        InfoPopupButton(
          title: LocaleKeys.SettingsScreenSearchProfiles_search_profiles_global_frequency_dictionary_title.tr(),
          infoText: LocaleKeys.SettingsScreenSearchProfiles_search_profiles_global_frequency_dictionary_info_text.tr()
        ),
        SearchProfileSettingsFrequencyDictionaryDropdown(),

        InfoPopupButton(
          title: LocaleKeys.SettingsScreenSearchProfiles_search_profiles_dictionary_management_title.tr(),
          infoText: LocaleKeys.SettingsScreenSearchProfiles_search_profiles_dictionary_management_info_text.tr()
        ),
        DictionaryManagementWidget(),

        // --- Search Settings ---
        SearchProfileSettingsHeading(LocaleKeys.SettingsScreenSearchProfiles_dictionary_search_header.tr()),
        SearchProfileSettingsToggleListTile(
          title: LocaleKeys.SettingsScreenSearchProfiles_flexible_search_converts_romaji_title.tr(),
          subtitle: LocaleKeys.SettingsScreenSearchProfiles_flexible_search_converts_romaj_subtitle.tr(),
          value: context.watch<SearchProfilesEntry>().normalizeSearchConvertsRomajiToHiragana,
          onChanged: (v) => GetIt.I<DaDb>().searchProfilesDao.updateProfile(
            context.read<SearchProfilesEntry>().copyWith(normalizeSearchConvertsRomajiToHiragana: v)
          )
        ),
    
        // --- UI Settings ---
        SearchProfileSettingsHeading(LocaleKeys.SettingsScreenSearchProfiles_display_header.tr()),
        SearchProfileSettingsToggleListTile(
          title: LocaleKeys.SettingsScreenSearchProfiles_show_separators_title.tr(),
          subtitle: LocaleKeys.SettingsScreenSearchProfiles_show_separators_subtitle.tr(),
          value: context.watch<SearchProfilesEntry>().showSearchResultSeparationHeaders,
          onChanged: (v) => GetIt.I<DaDb>().searchProfilesDao.updateProfile(
            context.read<SearchProfilesEntry>().copyWith(showSearchResultSeparationHeaders: v)
          )
        ),
        SearchProfileSettingsToggleListTile(
          title: LocaleKeys.SettingsScreenSearchProfiles_search_profiles_show_kanji_entries_title.tr(),
          subtitle: LocaleKeys.SettingsScreenSearchProfiles_search_profiles_show_kanji_entries_info_subtitle.tr(),
          value: context.watch<SearchProfilesEntry>().showKanjiEntriesInSearchResults,
          onChanged: (v) => GetIt.I<DaDb>().searchProfilesDao.updateProfile(
            context.read<SearchProfilesEntry>().copyWith(showKanjiEntriesInSearchResults: v)
          )
        ),
        SearchProfileSettingsToggleListTile(
          title: LocaleKeys.SettingsScreenSearchProfiles_show_tags_title.tr(),
          subtitle: LocaleKeys.SettingsScreenSearchProfiles_show_tags_subtitle.tr(),
          value: context.watch<SearchProfilesEntry>().showTags,
          onChanged: (v) => GetIt.I<DaDb>().searchProfilesDao.updateProfile(
            context.read<SearchProfilesEntry>().copyWith(showTags: v)
          )
        ),
        SearchProfileSettingsToggleListTile(
          title: LocaleKeys.SettingsScreenSearchProfiles_show_meta_entries_title.tr(),
          subtitle: LocaleKeys.SettingsScreenSearchProfiles_show_meta_entries_subtitle.tr(),
          value: context.watch<SearchProfilesEntry>().showMetaEntries,
          onChanged: (v) => GetIt.I<DaDb>().searchProfilesDao.updateProfile(
            context.read<SearchProfilesEntry>().copyWith(showMetaEntries: v)
          )
        ),
        SearchProfileSettingsToggleListTile(
          title: LocaleKeys.SettingsScreenSearchProfiles_use_compact_mode_title.tr(),
          subtitle: LocaleKeys.SettingsScreenSearchProfiles_use_compact_mode_subtitle.tr(),
          value: context.watch<SearchProfilesEntry>().definitionsCompactMode,
          onChanged: (v) => GetIt.I<DaDb>().searchProfilesDao.updateProfile(
            context.read<SearchProfilesEntry>().copyWith(definitionsCompactMode: v)
          )
        ),
        SearchProfileSettingsToggleListTile(
          title: LocaleKeys.SettingsScreenSearchProfiles_limit_definitions_height_title.tr(),
          subtitle: LocaleKeys.SettingsScreenSearchProfiles_limit_definitions_height_subtitle.tr(),
          value: context.watch<SearchProfilesEntry>().definitionsMaxHeight > 0,
          onChanged: (v) => GetIt.I<DaDb>().searchProfilesDao.updateProfile(
            context.read<SearchProfilesEntry>().copyWith(definitionsMaxHeight: v ? 60.0 : 0.0)
          )
        ),
        SearchProfileSettingsToggleListTile(
          title: LocaleKeys.SettingsScreenSearchProfiles_use_katakana_for_furigana_title.tr(),
          subtitle: LocaleKeys.SettingsScreenSearchProfiles_use_katakana_for_furigana_subtitle.tr(),
          value: context.watch<SearchProfilesEntry>().useKatakanaForFurigana,
          onChanged: (v) => GetIt.I<DaDb>().searchProfilesDao.updateProfile(
            context.read<SearchProfilesEntry>().copyWith(useKatakanaForFurigana: v)
          )
        ),
        
          
        // --- Sort Order ---
        SearchProfileSettingsCategorySeparator(),
        SearchProfileSettingsHeading(LocaleKeys.SettingsScreenSearchProfiles_sort_order_title.tr()),
        SearchProfileSettingsSearchResultSortOrder(
          firstSortOrder: true,
          
          title: LocaleKeys.SettingsScreenSearchProfiles_sort_by_title.tr(),
          infoText: LocaleKeys.SettingsScreenSearchProfiles_sort_by_text.tr(),
          optionNames: [
            LocaleKeys.SettingsScreenSearchProfiles_sort_by_direct_match.tr(),
            LocaleKeys.SettingsScreenSearchProfiles_sort_by_flexible_match.tr(),
            LocaleKeys.SettingsScreenSearchProfiles_sort_by_smart_grammar_match.tr(),
            LocaleKeys.SettingsScreenSearchProfiles_sort_by_typo_correction_match.tr(),
          ],
        ),
        SearchProfileSettingsSearchResultSortOrder(
          secondSortOrder: true,
          
          title: LocaleKeys.SettingsScreenSearchProfiles_then_by_title.tr(),
          infoText: LocaleKeys.SettingsScreenSearchProfiles_then_by_text.tr(),
          optionNames: [
            LocaleKeys.SettingsScreenSearchProfiles_then_by_exact_match.tr(),
            LocaleKeys.SettingsScreenSearchProfiles_then_by_starts_with_match.tr(),
            LocaleKeys.SettingsScreenSearchProfiles_then_by_subword_match.tr(),
            LocaleKeys.SettingsScreenSearchProfiles_then_by_wildcard_match.tr(),
          ],
        ),
          
        SearchProfileSettingsCategorySeparator(),
        SearchProfileSettingsHeading(LocaleKeys.SettingsScreenSearchProfiles_grouping_title.tr()),
        SearchProfileSettingsGroupingWidget(),
      
        SearchProfileSettingsCategorySeparator(),
        SearchProfileSettingsHeading(LocaleKeys.SettingsScreenSearchProfiles_misc_title.tr()),

        // TODO Search result limit

        // TODO: spellfix max results
        // TODO: spellfix max cost

        // TODO: Export dictionaries
        // TODO: Import dictionaries
      ],
    );
  
  }
}