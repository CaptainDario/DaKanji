import 'package:dakanji_db_core/database/dakanji_db.dart';
import 'package:dakanji_db_core/database/db_queries/dictionary_search/dictionary_match_group.dart';
import 'package:dakanji_db_core/database/db_queries/dictionary_search/dictionary_search_result.dart';
import 'package:dakanji_db_ui/search_results/dictionary_match_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class DictionarySearchResultWidget extends StatelessWidget {

  final DictionarySearchResult result;
  final DaKanjiDB db;
  final bool showTags;
  final bool showMetaEntries;
  final bool compactDefinitions;

  const DictionarySearchResultWidget(
    this.result,
    this.db,
    {
      this.showTags = true,
      this.showMetaEntries = true,
      this.compactDefinitions = false,
      super.key
    }
  );

  @override
  Widget build(BuildContext context) {
    final normalized = result.normalizedQueryMatchGroups;
    final variants = result.queryVariantMatches;
    final fuzzy = result.fuzzyMatches;

    return Provider.value(
      value: db,
      child: CustomScrollView(
        slivers: [
          // Section 1: Query Matches
          const SliverToBoxAdapter(child: _Header("Query Matches")),
          ..._buildSliversForMatchGroup(result.queryMatches),

          // Section 2: Normalized Matches
          if (normalized.isNotEmpty) ...[
            const SliverToBoxAdapter(child: _Header("Normalized Matches")),
            ...normalized.expand((group) => _buildSliversForMatchGroup(group)),
          ],

          // Section 3: Variant Matches
          if (variants.isNotEmpty) ...[
            const SliverToBoxAdapter(child: _Header("Variant Matches")),
            ...variants.expand((group) => _buildSliversForMatchGroup(group)),
          ],

          // Section 4: Fuzzy Matches
          if (fuzzy.isNotEmpty) ...[
            const SliverToBoxAdapter(child: _Header("Fuzzy Matches")),
            ...fuzzy.expand((group) => _buildSliversForMatchGroup(group)),
          ],
        ],
      ),
    );
  }


  List<Widget> _buildSliversForMatchGroup(DictionaryMatchGroup matchGroup) {
    final List<Widget> slivers = [];

    // Sub-Section: Exact Matches
    if (matchGroup.exactMatches.isNotEmpty) {
      slivers.add(const SliverToBoxAdapter(child: _SubHeader("Exact Matches")));
      slivers.add(SliverList.builder(
        itemCount: matchGroup.exactMatches.length,
        itemBuilder: (context, i) =>
            DictionaryMatchWidget(
              matchGroup.exactMatches[i],
              showTags: showTags,
              showMetaEntries: showMetaEntries,
              compactDefinitions: compactDefinitions,
            ),
      ));
    }

    // Sub-Section: Prefix Matches
    if (matchGroup.prefixMatches.isNotEmpty) {
      slivers.add(const SliverToBoxAdapter(child: _SubHeader("Prefix Matches")));
      slivers.add(SliverList.builder(
        itemCount: matchGroup.prefixMatches.length,
        itemBuilder: (context, i) =>
            DictionaryMatchWidget(
              matchGroup.prefixMatches[i],
              showTags: showTags,
              showMetaEntries: showMetaEntries,
              compactDefinitions: compactDefinitions,
            ),
      ));
    }

    // Sub-Section: Token Matches
    if (matchGroup.tokenMatches.isNotEmpty) {
      slivers.add(const SliverToBoxAdapter(child: _SubHeader("Sub-word Matches")));
      slivers.add(SliverList.builder(
        itemCount: matchGroup.tokenMatches.length,
        itemBuilder: (context, i) =>
            DictionaryMatchWidget(
              matchGroup.tokenMatches[i],
              showTags: showTags,
              showMetaEntries: showMetaEntries,
              compactDefinitions: compactDefinitions,
            ),
      ));
    }

    // Sub-Section: Wildcard Matches
    if (matchGroup.wildcardMatches.isNotEmpty) {
      slivers.add(const SliverToBoxAdapter(child: _SubHeader("Wildcard Matches")));
      slivers.add(SliverList.builder(
        itemCount: matchGroup.wildcardMatches.length,
        itemBuilder: (context, i) =>
            DictionaryMatchWidget(
              matchGroup.wildcardMatches[i],
              showTags: showTags,
              showMetaEntries: showMetaEntries,
              compactDefinitions: compactDefinitions,
            ),
      ));
    }

    return slivers;
  }
}

// Main section header
class _Header extends StatelessWidget {
  final String title;
  const _Header(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}

// Sub-section header
class _SubHeader extends StatelessWidget {
  final String title;
  const _SubHeader(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 20.0, bottom: 8.0),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),
    );
  }
}