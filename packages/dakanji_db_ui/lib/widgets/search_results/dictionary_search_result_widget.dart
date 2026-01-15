import 'package:dakanji_db_core/database/dakanji_db.dart';
import 'package:dakanji_db_core/database/db_queries/dictionary_search/dictionary_match.dart';
import 'package:dakanji_db_core/database/db_queries/dictionary_search/dictionary_match_group.dart';
import 'package:dakanji_db_core/database/db_queries/dictionary_search/dictionary_search_result.dart';
import 'package:dakanji_db_core/util/dakanji_db_search_result_order.dart';
import 'package:dakanji_db_core/util/dakanji_db_search_settings.dart';
import 'package:dakanji_db_ui/widgets/search_results/dictionary_match_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DictionarySearchResultWidget extends StatefulWidget {

  /// The dictionary search result to display.
  final DictionarySearchResult result;
  /// The database instance.
  final DaKanjiDB db;
  /// Settings for displaying the search results.
  final DaKanjiDbSearchSettings settings;

  /// Callback that is called when this widget is tapped.
  final Function(DictionaryMatch match)? onTap;

  const DictionarySearchResultWidget(
    {
      required this.result,
      required this.db,
      required this.settings,
      this.onTap,
      super.key
    }
  );

  @override
  State<DictionarySearchResultWidget> createState() => _DictionarySearchResultWidgetState();
}

class _DictionarySearchResultWidgetState extends State<DictionarySearchResultWidget> {
  final Set<String> _collapsedSections = {};

  void _toggleSection(String title) {
    setState(() {
      if (_collapsedSections.contains(title)) {
        _collapsedSections.remove(title);
      } else {
        _collapsedSections.add(title);
      }
    });
  }

  bool _isExpanded(String title) => !_collapsedSections.contains(title);

  @override
  Widget build(BuildContext context) {
    final normalized = widget.result.normalizedQueryMatchGroups;
    final variants = widget.result.queryVariantMatches;
    final fuzzy = widget.result.fuzzyMatches;

    return Provider.value(
      value: widget.db,
      child: CustomScrollView(
        slivers: [
        for (var matchType in widget.settings.firstSortOrder)
          ...switch (matchType.$1) {
            
            // Query Matches
            DakanjiDbSearch1stSortOrder.queryMatch when matchType.$2 => [
                _buildMainSection("Query Matches", widget.result.queryMatches)
              ],

            // Normalized Matches
            DakanjiDbSearch1stSortOrder.normalizedMatch when matchType.$2 =>
              normalized.map((group) => _buildMainSection("Normalized Matches", group)),

            // Variant Matches
            DakanjiDbSearch1stSortOrder.deconjugationMatch when matchType.$2 =>
              variants.map((group) => _buildMainSection("Variant Matches", group)),

            // Fuzzy Matches
            DakanjiDbSearch1stSortOrder.spellfixMatch when matchType.$2 =>
              fuzzy.map((group) => _buildMainSection("Fuzzy Matches", group)),

            // Default case returns an empty list
            _ => [],
          },
        ],
      ),
    );
  }

  Widget _buildMainSection(String title, DictionaryMatchGroup group) {
    final expanded = _isExpanded(title);
    
    return SliverMainAxisGroup(
      // Key allows Flutter to reuse the render object when rebuilding
      key: ValueKey("MainSection_$title"), 
      slivers: [
        if (widget.settings.showSearchResultSeparationHeaders)
          SliverPersistentHeader(
            pinned: true,
            delegate: _StickyHeaderDelegate(
              title: title, 
              type: _StickyHeaderType.main,
              isExpanded: expanded,
              onTap: () => _toggleSection(title),
              fontSize: 18.0, 
            ),
          ),
        
        if (expanded)
          ..._buildSliversForMatchGroup(group),
      ],
    );
  }

  List<Widget> _buildSliversForMatchGroup(DictionaryMatchGroup matchGroup) {
    final List<Widget> slivers = [];

    void addSection(String title, List<DictionaryMatch> matches) {
      if (matches.isNotEmpty) {
        final expanded = _isExpanded(title);
        // Create a stable key for this section
        final sectionKey = "SubSection_${matchGroup.searchTerm}_$title";

        slivers.add(SliverMainAxisGroup(
          // Helps Flutter identify this specific sub-group
          key: ValueKey(sectionKey), 
          slivers: [
            if (widget.settings.showSearchResultSeparationHeaders)
              SliverPersistentHeader(
                pinned: true,
                delegate: _StickyHeaderDelegate(
                  title: title,
                  type: _StickyHeaderType.sub,
                  isExpanded: expanded,
                  onTap: () => _toggleSection(title),
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
    for (var matchType in widget.settings.secondSortOrder) {
      switch (matchType.$1) {
        case DakanjiDbSearch2ndSortOrder.exactMatch:
          if (matchType.$2) {
            addSection("Exact matches (${matchGroup.searchTerm}):", matchGroup.exactMatches);
          }
        case DakanjiDbSearch2ndSortOrder.prefixMatch:
          if (matchType.$2) {
            addSection("Prefix matches (${matchGroup.searchTerm}*):", matchGroup.prefixMatches);
          }
        case DakanjiDbSearch2ndSortOrder.subwordMatch:
          if (matchType.$2) {
            addSection("Subword matches (*${matchGroup.searchTerm}*):", matchGroup.tokenMatches);
          }
        case DakanjiDbSearch2ndSortOrder.wildcardMatch:
          if (matchType.$2) {
            addSection("Wildcard matches (${matchGroup.searchTerm})", matchGroup.wildcardMatches);
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
          showTags: widget.settings.showTags,
          showMetaEntries: widget.settings.showMetaEntries,
          definitionsMaxHeight: widget.settings.definitionsMaxHeight,
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
    this.fontSize = 14.0,
  });

  double get _headerHeight => fontSize * 1.8; 

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    final isMain = type == _StickyHeaderType.main;
    final theme = Theme.of(context);

    return Material(
      color: theme.scaffoldBackgroundColor,
      child: InkWell(
        onTap: onTap,
        child: Container(
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
           oldDelegate.type != type ||
           oldDelegate.fontSize != fontSize || 
           oldDelegate.isExpanded != isExpanded;
  }
}