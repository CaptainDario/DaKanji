import 'package:dakanji_db_core/database/dakanji_db.dart';
import 'package:dakanji_db_core/database/db_queries/dictionary_search/dictionary_match.dart';
import 'package:dakanji_db_core/database/db_queries/dictionary_search/dictionary_match_group.dart';
import 'package:dakanji_db_core/database/db_queries/dictionary_search/dictionary_search_result.dart';
import 'package:dakanji_db_ui/model/dakanji_db_search_result_sort_order.dart';
import 'package:dakanji_db_ui/model/dakanji_db_settings.dart';
import 'package:dakanji_db_ui/widgets/model/dakanji_db_localization.dart';
import 'package:dakanji_db_ui/widgets/search_results/dictionary_match_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DictionarySearchResultWidget extends StatefulWidget {

  /// The dictionary search result to display.
  final DictionarySearchResult result;
  /// The database instance.
  final DaKanjiDB db;
  /// Settings for displaying the search results.
  final DaKanjiDbSettings settings;
  /// Localization for the search results UI
  final DakanjiDbLocalization localization;

  /// Callback that is called when this widget is tapped.
  final Function(DictionaryMatch match)? onTap;

  const DictionarySearchResultWidget(
    {
      required this.result,
      required this.db,
      required this.settings,
      required this.localization,
      this.onTap,
      super.key
    }
  );

  @override
  State<DictionarySearchResultWidget> createState() => _DictionarySearchResultWidgetState();
}

class _DictionarySearchResultWidgetState extends State<DictionarySearchResultWidget> {
  final Set<String> _collapsedSections = {};

  void _toggleSection(String key) {
    setState(() {
      if (_collapsedSections.contains(key)) {
        _collapsedSections.remove(key);
      } else {
        _collapsedSections.add(key);
      }
    });
  }

  bool _isExpanded(String title) => !_collapsedSections.contains(title);

  @override
  Widget build(BuildContext context) {
    final normalized = widget.result.normalizedQueryMatchGroups;
    final variants = widget.result.queryVariantMatches;
    final fuzzy = widget.result.fuzzyMatches;

    final loc = widget.localization;

    // show empty state if there are no results
    if(widget.result.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: .center,
          children: [
            Icon(Icons.search_off),
            SizedBox(height: 4),
            Text(loc.noResultsFound),
          ],
        ),
      );
  }

    return Provider.value(
      value: widget.db,
      child: CustomScrollView(
        slivers: [
        for (var (i, matchType) in widget.settings.s.firstSortOrder.indexed)
          ...switch (matchType.$1) {
            
            // Query Matches
            DakanjiDbSearchResult1stSortOrder.queryMatch when
              matchType.$2 && !widget.result.queryMatches.isEmpty => [
                _buildMainSection(loc.sortByDirectMatch, widget.result.queryMatches, i)
              ],

            // Normalized Matches
            DakanjiDbSearchResult1stSortOrder.normalizedMatch when
              matchType.$2 && normalized.any((e) => !e.isEmpty) =>
                normalized.map((group) => _buildMainSection(loc.sortByFlexibleMatch, group, i)),

            // Variant Matches
            DakanjiDbSearchResult1stSortOrder.deconjugationMatch when
              matchType.$2 && variants.any((e) => !e.isEmpty) =>
                variants.map((group) => _buildMainSection(loc.sortBySmartGrammarMatch, group, i)),

            // Fuzzy Matches
            DakanjiDbSearchResult1stSortOrder.spellfixMatch when
              matchType.$2 && fuzzy.any((e) => !e.isEmpty) =>
                fuzzy.map((group) => _buildMainSection(loc.sortByTypoCorrectionMatch, group, i)),

            // Default case returns an empty list
            _ => [],
          },
        ],
      ),
    );
  }

  Widget _buildMainSection(String title, DictionaryMatchGroup group, int index) {
    
    title = "$title (${group.searchTerm})";
    final expanded = _isExpanded(title);
    final keyValue = "MainSection_${group.searchTerm}_$index";
    
    return SliverMainAxisGroup(
      // Key allows Flutter to reuse the render object when rebuilding
      key: ValueKey(keyValue), 
      slivers: [
        if (widget.settings.s.showSearchResultSeparationHeaders)
          SliverPersistentHeader(
            pinned: true,
            delegate: _StickyHeaderDelegate(
              title: title, 
              type: _StickyHeaderType.main,
              isExpanded: expanded,
              onTap: () => _toggleSection(keyValue),
              fontSize: 18.0, 
            ),
          ),
        
        if (expanded)
          ..._buildSliversForMatchGroup(group, index),
      ],
    );
  }

  List<Widget> _buildSliversForMatchGroup(DictionaryMatchGroup matchGroup, int mainIndex) {
    final List<Widget> slivers = [];
    final loc = widget.localization;

    void addSection(String title, List<DictionaryMatch> matches, int subIndex) {
      if (matches.isNotEmpty) {
        final expanded = _isExpanded(title);
        // Create a stable key for this section
        final sectionKey = 'SubSection_${matchGroup.searchTerm}_${mainIndex}_$subIndex';

        slivers.add(SliverMainAxisGroup(
          // Helps Flutter identify this specific sub-group
          key: ValueKey(sectionKey), 
          slivers: [
            if (widget.settings.s.showSearchResultSeparationHeaders)
              SliverPersistentHeader(
                pinned: true,
                delegate: _StickyHeaderDelegate(
                  title: title,
                  type: _StickyHeaderType.sub,
                  isExpanded: expanded,
                  onTap: () => _toggleSection(sectionKey),
                  fontSize: 14.0, 
                )
              ),
            if (expanded)
              _buildMatchSliver(matches, sectionKey),
          ],
        ));
      }
    }

    // display the results in the user defined order
    for (var (i, matchType) in widget.settings.s.secondSortOrder.indexed) {
      switch (matchType.$1) {
        case DakanjiDbSearchReesult2ndSortOrder.exactMatch:
          if (matchType.$2) {
            addSection("${loc.thenByExactMatch} (${matchGroup.exactMatches.length}):", matchGroup.exactMatches, i);
          }
        case DakanjiDbSearchReesult2ndSortOrder.prefixMatch:
          if (matchType.$2) {
            addSection("${loc.thenByStartsWithMatch} (${matchGroup.prefixMatches.length}):", matchGroup.prefixMatches, i);
          }
        case DakanjiDbSearchReesult2ndSortOrder.subwordMatch:
          if (matchType.$2) {
            addSection("${loc.thenBySubwordMatch} (${matchGroup.tokenMatches.length}):", matchGroup.tokenMatches, i);
          }
        case DakanjiDbSearchReesult2ndSortOrder.wildcardMatch:
          if (matchType.$2) {
            addSection("${loc.thenByWildcardMatch} (${matchGroup.wildcardMatches.length})", matchGroup.wildcardMatches, i);
          }
      } 
    }

    return slivers;
  }

  Widget _buildMatchSliver(List<DictionaryMatch> matches, String keyPrefix) {
    return SliverList.builder(
      // Helps Flutter track this specific list
      key: ValueKey("${keyPrefix}_List"), 
      // Don't keep off-screen items alive.
      addAutomaticKeepAlives: false,
      itemCount: matches.length,
      itemBuilder: (context, i) => RepaintBoundary(
        key: ValueKey("${keyPrefix}_List_Item_$i"), 
        child: DictionaryMatchWidget(
          matches[i],
          showTags: widget.settings.s.showTags,
          showMetaEntries: widget.settings.s.showMetaEntries,
          definitionsMaxHeight: widget.settings.s.definitionsMaxHeight,
          useKatakanaForFurigana: widget.settings.s.useKatakanaForFurigana,
          onTap: widget.onTap,
        ),
      ),
    );
  }
}

enum _StickyHeaderType {
  main, 
  sub,  
}

class _StickyHeaderDelegate extends SliverPersistentHeaderDelegate {
  final String title;
  final _StickyHeaderType type;
  final bool isExpanded;
  final VoidCallback onTap;
  final double fontSize;

  const _StickyHeaderDelegate({
    required this.title,
    required this.type,
    required this.isExpanded,
    required this.onTap,
    required this.fontSize,
  });

  // 1. Calculate height based on font size, but round up to the nearest whole pixel
  double get _headerHeight => (fontSize * 1.8).ceilToDouble();

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    final isMain = type == _StickyHeaderType.main;
    final theme = Theme.of(context);

    return Material(
      color: theme.scaffoldBackgroundColor,
      child: InkWell(
        onTap: onTap,
        child: Container(
          // 2. FORCE the container to fill the exact calculated height
          height: _headerHeight, 
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: fontSize,
                  ),
                ),
              ),
              AnimatedRotation(
                turns: isExpanded ? 0.0 : -0.25,
                duration: const Duration(milliseconds: 200),
                child: Icon(
                  Icons.expand_more,
                  size: fontSize * 1.4,
                  color: isMain ? null : theme.colorScheme.secondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  double get maxExtent => _headerHeight;

  @override
  double get minExtent => _headerHeight;

  @override
  bool shouldRebuild(covariant _StickyHeaderDelegate oldDelegate) {
    return oldDelegate.title != title ||
        oldDelegate.isExpanded != isExpanded ||
        oldDelegate.fontSize != fontSize; // This triggers a rebuild when settings change
  }
}