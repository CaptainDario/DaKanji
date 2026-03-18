import 'package:da_db/database/index/index_table_entry.dart';
import 'package:da_kanji_mobile/locales_keys.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';



class DictionaryManagementDetailsTable extends StatelessWidget {

  final IndexEntry dict;

  const DictionaryManagementDetailsTable(
    this.dict,
    {
      super.key,
    }
  );

  @override
  Widget build(BuildContext context) {
    return SelectionArea(
      child: Table(
        children: [
          for (var (String name, String value) in dictionaryInfo(dict))
            TableRow(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(name),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MarkdownBody(
                    data: value,
                    onTapLink: (text, href, title) async {
                      if(await canLaunchUrlString(href!))
                        launchUrlString(href, mode: LaunchMode.externalApplication);
                    },
                  ),
                ),
              ]
            )
        ],
      ),
    );
  }

  Iterable<(String name, String value)> dictionaryInfo(IndexEntry dict) {
    return [
      (LocaleKeys.SettingsScreenSearchProfiles_dictionary_info_id.tr(), dict.id.toString()),
      (LocaleKeys.SettingsScreenSearchProfiles_dictionary_info_user_dictionary.tr(), dict.isDefaultDictionary
        ? LocaleKeys.SettingsScreenSearchProfiles_dictionary_info_yes.tr()
        : LocaleKeys.SettingsScreenSearchProfiles_dictionary_info_no.tr()),
      (LocaleKeys.SettingsScreenSearchProfiles_dictionary_info_enabled.tr(), dict.enabled
        ? LocaleKeys.SettingsScreenSearchProfiles_dictionary_info_yes.tr()
        : LocaleKeys.SettingsScreenSearchProfiles_dictionary_info_no.tr()),
      (LocaleKeys.SettingsScreenSearchProfiles_dictionary_info_dictionary_type.tr(), dict.dictionaryType.name.toString()),
      (LocaleKeys.SettingsScreenSearchProfiles_dictionary_info_current_sort_order.tr(), "${dict.currentSortingOrder}"),
      (LocaleKeys.SettingsScreenSearchProfiles_dictionary_info_is_global_frequency_dictionary.tr(), dict.currentFrequencyDictionary
        ? LocaleKeys.SettingsScreenSearchProfiles_dictionary_info_yes.tr()
        : LocaleKeys.SettingsScreenSearchProfiles_dictionary_info_no.tr()),
      (LocaleKeys.SettingsScreenSearchProfiles_dictionary_info_title.tr(), dict.title),
      (LocaleKeys.SettingsScreenSearchProfiles_dictionary_info_revision.tr(), dict.revision.toString()),
      if (dict.sequenced != null) (LocaleKeys.SettingsScreenSearchProfiles_dictionary_info_sequenced.tr(), dict.sequenced!
        ? LocaleKeys.SettingsScreenSearchProfiles_dictionary_info_yes.tr()
        : LocaleKeys.SettingsScreenSearchProfiles_dictionary_info_no.tr()),
      if (dict.format != null) (LocaleKeys.SettingsScreenSearchProfiles_dictionary_info_format.tr(), dict.format!.toString()),
      (LocaleKeys.SettingsScreenSearchProfiles_dictionary_info_version.tr(), dict.version.toString()),
      if (dict.author != null) (LocaleKeys.SettingsScreenSearchProfiles_dictionary_info_author.tr(), dict.author!),
      if (dict.isUpdatable != null) (LocaleKeys.SettingsScreenSearchProfiles_dictionary_info_updatable.tr(), dict.isUpdatable!
        ? LocaleKeys.SettingsScreenSearchProfiles_dictionary_info_yes.tr()
        : LocaleKeys.SettingsScreenSearchProfiles_dictionary_info_no.tr()),
      if(dict.indexUrl != null) (LocaleKeys.SettingsScreenSearchProfiles_dictionary_info_index_url.tr(), dict.indexUrl!),
      if(dict.downloadUrl != null) (LocaleKeys.SettingsScreenSearchProfiles_dictionary_info_download_url.tr(), dict.downloadUrl!),
      if(dict.url != null) (LocaleKeys.SettingsScreenSearchProfiles_dictionary_info_url.tr(), dict.url!),
      if(dict.description != null) (LocaleKeys.SettingsScreenSearchProfiles_dictionary_info_description.tr(), dict.description!),
      if(dict.attribution != null) (LocaleKeys.SettingsScreenSearchProfiles_dictionary_info_attribution.tr(), dict.attribution!),
      if(dict.sourceLanguage != null) (LocaleKeys.SettingsScreenSearchProfiles_dictionary_info_source_languagae.tr(), dict.sourceLanguage!.name),
      if(dict.targetLanguage != null) (LocaleKeys.SettingsScreenSearchProfiles_dictionary_info_target_language.tr(), dict.targetLanguage!.name),
    ];
  }
}