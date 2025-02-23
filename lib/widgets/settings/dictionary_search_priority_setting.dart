import 'package:da_kanji_mobile/entities/settings/dictionary_search_priority_interface.dart';
import 'package:da_kanji_mobile/locales_keys.dart';
import 'package:da_kanji_mobile/widgets/responsive_widgets/responsive_filter_chips.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';



class DictionarySearchPrioritySetting extends StatefulWidget {

  /// The setting from which this widget should draw its configuration
  /// Needs to implement
  /// * List<String> selectedSearchResultSortPriorities
  /// * List<String> searchResultSortPriorities
  final DictionarySearchPriorityInterface setting;
  /// Function that can be used to save `this.setting`
  final Function save;

  const DictionarySearchPrioritySetting(
    this.setting,
    this.save,
    {
      super.key
    }
  );

  @override
  State<DictionarySearchPrioritySetting> createState() => _DictionarySearchPrioritySettingState();
}

class _DictionarySearchPrioritySettingState extends State<DictionarySearchPrioritySetting> {

  @override
  Widget build(BuildContext context) {

    return ResponsiveFilterChips(
      description: LocaleKeys.SettingsScreen_dict_separate_search_results.tr(),
      detailedDescription: SizedBox(
        height: MediaQuery.sizeOf(context).height*0.8,
        child: SingleChildScrollView(
          
          child: MarkdownBody(
            data:
"""
# ${LocaleKeys.SettingsScreen_dict_search_sorting_information.tr()}
${LocaleKeys.SettingsScreen_dict_search_sorting_information_description_1.tr()}
${LocaleKeys.SettingsScreen_dict_search_sorting_information_description_2.tr()}
${LocaleKeys.SettingsScreen_dict_search_sorting_information_description_3.tr()}

## ${LocaleKeys.SettingsScreen_dict_term.tr()}
${LocaleKeys.SettingsScreen_dict_term_description.tr()}

## ${LocaleKeys.SettingsScreen_dict_convert_to_kana.tr()}
${LocaleKeys.SettingsScreen_dict_convert_to_kana_description.tr()}

## ${LocaleKeys.SettingsScreen_dict_base_form.tr()}
${LocaleKeys.SettingsScreen_dict_base_form_description.tr()}
"""
          ),
        ),
      ),
      chipWidget: (int index) {

        bool isSelected = widget.setting.selectedSearchResultSortPriorities
          .contains(widget.setting.searchResultSortPriorities[index]);

        int iWithoutUnselected = widget.setting.searchResultSortPriorities
          .sublist(0, index+1)
          .where((e) => widget.setting.selectedSearchResultSortPriorities
            .contains(e)
          ).length;

        return Text(
          (isSelected ? "$iWithoutUnselected. " : "") + 
          widget.setting.searchResultSortPriorities[index].tr()
        );
      },
      selected: (index) {
        return widget.setting.selectedSearchResultSortPriorities
          .contains(widget.setting.searchResultSortPriorities[index]);
      },
      numChips: widget.setting.searchResultSortPriorities.length,
      onReorder: (oldIndex, newIndex) {
        // update order of list with languages
        String priority = widget.setting.searchResultSortPriorities.removeAt(oldIndex);
        widget.setting.searchResultSortPriorities.insert(newIndex, priority);

        // update list of selected languages
        widget.setting.selectedSearchResultSortPriorities =
          widget.setting.searchResultSortPriorities.where((e) => 
            widget.setting.selectedSearchResultSortPriorities.contains(e)
          ).toList();
          
        widget.save();
      },
      onFilterChipTap: (selected, index) async {
        String priority = widget.setting.searchResultSortPriorities[index];

        // do not allow removing the last priority
        if(widget.setting.selectedSearchResultSortPriorities.length == 1 &&
          widget.setting.selectedSearchResultSortPriorities.contains(priority)) {
          return;
        }

        if(!widget.setting.selectedSearchResultSortPriorities.contains(priority)) {
          widget.setting.selectedSearchResultSortPriorities = 
            widget.setting.searchResultSortPriorities.where((element) => 
              [priority, ...widget.setting.selectedSearchResultSortPriorities].contains(element)
            ).toList();
        }
        else {
          widget.setting.selectedSearchResultSortPriorities.remove(priority);
        }

        await widget.save();
        setState(() {});
        
      },
    );
        
  }
}