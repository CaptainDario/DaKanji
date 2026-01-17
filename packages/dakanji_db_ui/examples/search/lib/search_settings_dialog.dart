import 'package:dakanji_db_core/database/db_queries/dictionary_search/grouping_rules.dart';
import 'package:dakanji_db_ui/model/dakanji_db_search_settings.dart';
import 'package:dakanji_db_ui/widgets/settings/dakanji_db_search_sort_order_setting_widget.dart';
import 'package:dakanji_db_ui_search_example/locales.dart';
import 'package:flutter/material.dart';


class SearchSettingsDialog extends StatefulWidget {
  final DaKanjiDbSearchSettings initialSettings;

  const SearchSettingsDialog({super.key, required this.initialSettings});

  @override
  State<SearchSettingsDialog> createState() => _SearchSettingsDialogState();
}

class _SearchSettingsDialogState extends State<SearchSettingsDialog> {
  late DaKanjiDbSearchSettings settings;

  @override
  void initState() {
    super.initState();
    settings = widget.initialSettings;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      constraints: const BoxConstraints(maxWidth: 500, maxHeight: 900),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [BoxShadow(blurRadius: 10, color: Colors.black26)],
      ),
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Search Configuration",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const Divider(),
          Flexible(
            child: ListView(
              shrinkWrap: true,
              children: [
                Text("Display", style: Theme.of(context).textTheme.headlineSmall),
                _buildToggle(
                  title: "Show Search Result Separation Headers",
                  subtitle: "Show or hide headers such as 'Exact Matches', 'Prefix Matches', etc.",
                  value: settings.showSearchResultSeparationHeaders,
                  onChanged: (v) => setState(() { 
                    settings.showSearchResultSeparationHeaders = v;
                  }),
                ),
                _buildToggle(
                  title: "Show Tags",
                  subtitle: "Shows tags such as 'common' in search results",
                  value: settings.showTags,
                  onChanged: (v) => setState(() { 
                    settings.showTags = v;
                  }),
                ),
                _buildToggle(
                  title: "Show Meta entries",
                  subtitle: "Shows Meta entries such as frequency in search results",
                  value: settings.showMetaEntries,
                  onChanged: (v) => setState(() { 
                    settings.showMetaEntries = v;
                  }),
                ),
                _buildToggle(
                  title: "Use Compact Definitions",
                  subtitle: "Limits the height of definitions in search results",
                  value: settings.definitionsMaxHeight > 0,
                  onChanged: (v) => setState(() { 
                    settings.definitionsMaxHeight = v ? 60.0 : 0.0;
                  }),
                ),

                Text("Sort Order", style: Theme.of(context).textTheme.headlineSmall),
                DakanjiDbSearchSortOrderSettingWidget(
                  settings: settings,
                  firstSortOrder: true,
                  
                  title: sortByTitle,
                  infoText: sortByText,
                  optionNames: [
                    sortByExactMatch,
                    sortByFlexibleMatch,
                    sortBySmartGrammarMatch,
                    sortByTypoCorrectionMatch,
                  ],
                ),
                DakanjiDbSearchSortOrderSettingWidget(
                  settings: settings,
                  secondSortOrder: true,
                  
                  title: thenByTitle,
                  infoText: thenByText,
                  optionNames: [
                    thenByExactMatch,
                    thenByStartsWithMatch,
                    thenBySubwordMatch,
                    thenByWildcardMatch,
                  ],
                ),

                SizedBox(height: 8),
                Text("Grouping", style: Theme.of(context).textTheme.headlineSmall),
                _buildToggle(
                  title: "Group by term",
                  subtitle: "Group identical entries (term only) together",
                  value: settings.groupingRule is TermAndReadingGroupingRule,
                  onChanged: (v) => setState(() { 
                    settings.groupingRule = v
                      ? [TermAndReadingGroupingRule({3, 4})]
                      : [NoGroupingRule()];
                  }),
                ),
                _buildToggle(
                  title: "Group by term and reading",
                  subtitle: "Group identical entries (term + reading) together",
                  value: settings.groupingRule is TermGroupingRule,
                  onChanged: (v) => setState(() { 
                    settings.groupingRule = v
                      ? [TermGroupingRule({3, 4})]
                      : [NoGroupingRule()];
                  }),
                ),
                _buildToggle(
                  title: "Group by Sequence",
                  subtitle: "Group results by their sequence id",
                  value: settings.groupingRule is SequenceGroupingRule,
                  onChanged: (v) => setState(() { 
                    settings.groupingRule = v
                      ? [SequenceGroupingRule(
                        sourceDictId: 3,
                        targetDictIds: {3, 4}
                      )]
                      : [NoGroupingRule()];
                  }),
                ),
              ],
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context, null),
                  child: const Text("Cancel"),
                ),
                const SizedBox(width: 10),
                FilledButton(
                  onPressed: () => Navigator.pop(context, settings),
                  child: const Text("Apply"),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

Widget _buildToggle({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return SwitchListTile(
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(subtitle, style: const TextStyle(fontSize: 12)),
      value: value,
      onChanged: onChanged,
      activeThumbColor: Colors.white, 
      activeTrackColor: Colors.green,
      inactiveThumbColor: Colors.grey,
      inactiveTrackColor: Colors.grey.withValues(alpha: 0.3),
    );
  }
}