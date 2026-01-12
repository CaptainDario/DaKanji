import 'package:dakanji_db_core/database/db_queries/dictionary_search/grouping_rules.dart';
import 'package:flutter/material.dart';

import 'search_settings.dart';

class SearchSettingsDialog extends StatefulWidget {
  final SearchSettings initialSettings;

  const SearchSettingsDialog({super.key, required this.initialSettings});

  @override
  State<SearchSettingsDialog> createState() => _SearchSettingsDialogState();
}

class _SearchSettingsDialogState extends State<SearchSettingsDialog> {
  late SearchSettings settings;

  @override
  void initState() {
    super.initState();
    settings = widget.initialSettings;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      constraints: const BoxConstraints(maxWidth: 500, maxHeight: 600),
      decoration: BoxDecoration(
        color: Theme.of(context).dialogTheme.backgroundColor,
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
                _buildToggle(
                  title: "Broad Search Mode",
                  subtitle: "Ignore minor input differences like Ａ vs A",
                  value: settings.normalizedSearch,
                  onChanged: (v) => setState(() => settings.normalizedSearch = v),
                ),
                _buildToggle(
                  title: "Auto-Convert Romaji",
                  subtitle: "Treat 'sushi' as 'すし'",
                  value: settings.convertRomaji,
                  onChanged: (v) => setState(() => settings.convertRomaji = v),
                ),
                _buildToggle(
                  title: "De-conjugation",
                  subtitle: "Find '食べる' when searching '食べます'",
                  value: settings.deconjugation,
                  onChanged: (v) => setState(() => settings.deconjugation = v),
                ),
                _buildToggle(
                  title: "Autocorrect",
                  subtitle: "Fix minor spelling mistakes like: すうし → すし",
                  value: settings.spellfix,
                  onChanged: (v) => setState(() => settings.spellfix = v),
                ),
                _buildToggle(
                  title: "Group by term",
                  subtitle: "Group identical entries (term only) together",
                  value: settings.groupingRule is TermAndReadingGroupingRule,
                  onChanged: (v) => setState(() { 
                    settings.groupingRule = v
                      ? TermAndReadingGroupingRule({3, 4})
                      : NoGroupingRule();
                  }),
                ),
                _buildToggle(
                  title: "Group by term and reading",
                  subtitle: "Group identical entries (term + reading) together",
                  value: settings.groupingRule is TermGroupingRule,
                  onChanged: (v) => setState(() { 
                    settings.groupingRule = v
                      ? TermGroupingRule({3, 4})
                      : NoGroupingRule();
                  }),
                ),
                _buildToggle(
                  title: "Group by Sequence",
                  subtitle: "Group results by their sequence id",
                  value: settings.groupingRule is SequenceGroupingRule,
                  onChanged: (v) => setState(() { 
                    settings.groupingRule = v
                      ? SequenceGroupingRule(
                        sourceDictId: 3,
                        targetDictIds: {3, 4}
                      )
                      : NoGroupingRule();
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
      inactiveTrackColor: Colors.grey.withOpacity(0.3),
    );
  }
}