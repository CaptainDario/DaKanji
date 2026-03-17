import 'package:collection/collection.dart';
import 'package:da_db/database/db_queries/dictionary_search/dictionary_match.dart';
import 'package:da_db/database/db_queries/dictionary_search/dictionary_match_group.dart';
import 'package:da_kanji_mobile/features/dictionary/widgets/term/term_entry_widget.dart';
import 'package:da_kanji_mobile/locales_keys.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';



class SearchMatchGroupWidget extends StatelessWidget {
  
  final DictionaryMatchGroup matchGroup;

  final bool useStructuredContentDefinitions;
  
  const SearchMatchGroupWidget(
    this.matchGroup,
    this.useStructuredContentDefinitions,
    {
      super.key
    }
  );

  List<DictionaryMatch> get allMatchGroups {
    return CombinedListView([
      matchGroup.exactMatches,
      matchGroup.prefixMatches,
      matchGroup.tokenMatches,
      matchGroup.wildcardMatches
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return SliverList.list(
      children: [
        Text("${LocaleKeys.DictionaryScreen_search_results_exact_matches_header.tr()}: ${matchGroup.exactMatches.length}"),
        for (final match in matchGroup.exactMatches)
          TermEntryWidget(match),
        Text("${LocaleKeys.DictionaryScreen_search_results_prefix_matches_header.tr()}: ${matchGroup.prefixMatches.length}"),
        for (final match in matchGroup.prefixMatches)
          TermEntryWidget(match),
        Text("${LocaleKeys.DictionaryScreen_search_results_sub_word_matches_header.tr()}: ${matchGroup.tokenMatches.length}"),
        for (final match in matchGroup.tokenMatches)
          TermEntryWidget(match),
        Text("${LocaleKeys.DictionaryScreen_search_results_wildcard_matches_header.tr()}: ${matchGroup.wildcardMatches.length}"),
        for (final match in matchGroup.wildcardMatches)
          TermEntryWidget(match),
      ],
    );
  }
}