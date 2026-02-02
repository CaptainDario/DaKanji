import 'package:dakanji_db_core/data/dakanji_db_search_result_sort_order.dart';
import 'package:dakanji_db_core/database/dakanji_db.dart';
import 'package:dakanji_db_core/database/db_queries/dictionary_search/dictionary_match.dart';
import 'package:dakanji_db_core/database/db_queries/dictionary_search/dictionary_match_group.dart';
import 'package:dakanji_db_core/database/db_queries/dictionary_search/dictionary_search_result.dart';
import 'package:dakanji_db_core/database/search_profiles/search_profiles_entry.dart';
import 'package:dakanji_db_ui/model/dakanji_db_localization.dart';
import 'package:dakanji_db_ui/widgets/kanji/kanji_entry_widget.dart';
import 'package:dakanji_db_ui/widgets/term/term_entry_widget.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class DictionarySearchResultWidget extends StatefulWidget {

  final DictionarySearchResult result;
  final DakanjiDbLocalization localization;
  final Function(DictionaryMatch match)? onTap;

  const DictionarySearchResultWidget({
    required this.result,
    required this.localization,
    this.onTap,
    super.key
  });

  @override
  State<DictionarySearchResultWidget> createState() => _DictionarySearchResultWidgetState();
}

class _DictionarySearchResultWidgetState extends State<DictionarySearchResultWidget> {
  
  final Set<String> _collapsedSections = {};
  late final Stream<SearchProfilesEntry> _profilesStream;

  @override
  void initState() {
    super.initState();
    _profilesStream = GetIt.I<DaKanjiDB>().searchProfilesDao.watchActiveProfile();
  }

  bool _isExpanded(String key) => !_collapsedSections.contains(key);

  void _toggleSection(String key) {
    setState(() {
      _collapsedSections.contains(key) 
        ? _collapsedSections.remove(key) 
        : _collapsedSections.add(key);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.result.isEmpty) return _buildEmptyState();

    return StreamBuilder<SearchProfilesEntry>(
      stream: _profilesStream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
        if (snapshot.hasError) return Center(child: Text("Error: ${snapshot.error}"));

        return Provider.value(
          value: snapshot.data!,
          child: CustomScrollView(
            slivers: [
              _buildKanjiSection(snapshot.data!),
              ..._buildDictionarySections(snapshot.data!),
              const SliverToBoxAdapter(child: SizedBox(height: 20)),
            ],
          ),
        );
      }
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.search_off, size: 48, color: Colors.grey),
          const SizedBox(height: 16),
          Text(
            widget.localization.noResultsFound, 
            style: Theme.of(context).textTheme.titleMedium
          ),
        ],
      ),
    );
  }

  // --- 1. Kanji Section ---

  Widget _buildKanjiSection(SearchProfilesEntry profile) {
    if (widget.result.kanjiResults.isEmpty || !profile.showKanjiEntriesInSearchResults) {
      return const SliverToBoxAdapter(child: SizedBox.shrink());
    }

    final title = "Kanji (${widget.result.kanjiResults.map((k) => k.kanjiBankEntry.kanji).join(', ')})";
    const key = "KanjiSection";

    return SliverMainAxisGroup(
      slivers: [
        SliverPersistentHeader(
          delegate: _StickyHeaderDelegate(
            title: title,
            type: _StickyHeaderType.main,
            isExpanded: _isExpanded(key),
            onTap: () => _toggleSection(key),
          ),
        ),
        if (_isExpanded(key))
          SliverList.builder(
            itemCount: widget.result.kanjiResults.length,
            itemBuilder: (_, i) => KanjiEntryWidget(
              result: widget.result.kanjiResults[i],
              showTags: profile.showTags,
              showMeta: profile.showMetaEntries,
              includeAllStats: false,
            ),
          ),
      ],
    );
  }

  // --- 2. Main Sections (Iterate Match Types) ---

  List<Widget> _buildDictionarySections(SearchProfilesEntry profile) {
    final loc = widget.localization;
    final r = widget.result;

    List<DictionaryMatchGroup> nonEmpty(List<DictionaryMatchGroup> groups) => 
        groups.where((g) => !g.isEmpty).toList();

    return profile.firstSortOrder.indexed.expand<Widget>((entry) {
      final (index, matchType) = entry;
      
      if (!matchType.$2) return const []; 

      return switch (matchType.$1) {
        DakanjiDbSearchResult1stSortOrder.queryMatch => 
          nonEmpty(r.queryMatches).isNotEmpty 
            ? [_buildMainSection(loc.sortByDirectMatch, nonEmpty(r.queryMatches), index)] 
            : const [],
            
        DakanjiDbSearchResult1stSortOrder.normalizedMatch => 
          nonEmpty(r.normalizedQueryMatchGroups).isNotEmpty 
            ? [_buildMainSection(loc.sortByFlexibleMatch, nonEmpty(r.normalizedQueryMatchGroups), index)] 
            : const [],
            
        DakanjiDbSearchResult1stSortOrder.deconjugationMatch => 
          nonEmpty(r.queryVariantMatches).isNotEmpty 
            ? [_buildMainSection(loc.sortBySmartGrammarMatch, nonEmpty(r.queryVariantMatches), index)] 
            : const [],
            
        DakanjiDbSearchResult1stSortOrder.spellfixMatch => 
          nonEmpty(r.fuzzyMatches).isNotEmpty 
            ? [_buildMainSection(loc.sortByTypoCorrectionMatch, nonEmpty(r.fuzzyMatches), index)] 
            : const [],
      };
    }).toList();
  }

  Widget _buildMainSection(String title, List<DictionaryMatchGroup> groups, int mainIndex) {
    final key = "MainSection_$mainIndex";
    final expanded = _isExpanded(key);
    final profile = context.read<SearchProfilesEntry>();

    final displayTitle = title;

    return SliverMainAxisGroup(
      key: ValueKey(key),
      slivers: [
        if (profile.showSearchResultSeparationHeaders)
          SliverPersistentHeader(
            pinned: true,
            delegate: _StickyHeaderDelegate(
              title: displayTitle,
              type: _StickyHeaderType.main,
              isExpanded: expanded,
              onTap: () => _toggleSection(key),
            ),
          ),
        if (expanded)
          ..._buildQualitySections(groups, mainIndex),
      ],
    );
  }

  // --- 3. Sub Sections (Iterate Match Quality) ---

  List<Widget> _buildQualitySections(List<DictionaryMatchGroup> groups, int mainIndex) {
    final profile = context.read<SearchProfilesEntry>();
    final loc = widget.localization;
    final isMultiSearch = groups.length > 1;

    return profile.secondSortOrder.indexed.expand<Widget>((entry) {
      final (subIndex, matchType) = entry;
      if (!matchType.$2) return const [];

      final (title, selector) = switch (matchType.$1) {
        DakanjiDbSearchResult2ndSortOrder.exactMatch    => (loc.thenByExactMatch, (DictionaryMatchGroup g) => g.exactMatches),
        DakanjiDbSearchResult2ndSortOrder.prefixMatch   => (loc.thenByStartsWithMatch, (DictionaryMatchGroup g) => g.prefixMatches),
        DakanjiDbSearchResult2ndSortOrder.subwordMatch  => (loc.thenBySubwordMatch, (DictionaryMatchGroup g) => g.tokenMatches),
        DakanjiDbSearchResult2ndSortOrder.wildcardMatch => (loc.thenByWildcardMatch, (DictionaryMatchGroup g) => g.wildcardMatches),
      };

      if (!groups.any((g) => selector(g).isNotEmpty)) return const [];

      return [
        _buildQualitySection(
          title: title,
          groups: groups,
          selector: selector,
          parentKey: "Sub_${mainIndex}_$subIndex",
          isMultiSearch: isMultiSearch,
        )
      ];
    }).toList();
  }

  Widget _buildQualitySection({
    required String title,
    required List<DictionaryMatchGroup> groups,
    required List<DictionaryMatch> Function(DictionaryMatchGroup) selector,
    required String parentKey,
    required bool isMultiSearch,
  }) {
    final expanded = _isExpanded(parentKey);
    final profile = context.read<SearchProfilesEntry>();

    // FIX: Restore term name in sub-header for single searches
    // "Exact Match (Eat)" vs "Exact Match"
    final displayTitle = !isMultiSearch && groups.isNotEmpty
        ? "$title (${groups.first.searchTerm})" 
        : title;

    return SliverMainAxisGroup(
      key: ValueKey(parentKey),
      slivers: [
        if (profile.showSearchResultSeparationHeaders)
          SliverPersistentHeader(
            pinned: true,
            delegate: _StickyHeaderDelegate(
              title: displayTitle,
              type: _StickyHeaderType.sub,
              isExpanded: expanded,
              onTap: () => _toggleSection(parentKey),
            ),
          ),
        
        if (expanded) ...[
          if (isMultiSearch) ...[
             for (var (i, group) in groups.indexed)
                if (selector(group).isNotEmpty)
                  _buildTermSection(
                    term: group.searchTerm,
                    matches: selector(group),
                    parentKey: parentKey,
                    index: i
                  )
          ] else ...[
             _buildEntriesList(selector(groups.first), parentKey)
          ]
        ]
      ],
    );
  }

  // --- 4. Term Sections (Multi-Search Only) ---

  Widget _buildTermSection({
    required String term,
    required List<DictionaryMatch> matches,
    required String parentKey,
    required int index,
  }) {
    final key = "${parentKey}_Term_$index";
    final expanded = _isExpanded(key);
    final profile = context.read<SearchProfilesEntry>();

    return SliverMainAxisGroup(
      key: ValueKey(key),
      slivers: [
        if (profile.showSearchResultSeparationHeaders)
          SliverPersistentHeader(
            pinned: true,
            delegate: _StickyHeaderDelegate(
              title: term,
              type: _StickyHeaderType.tertiary,
              isExpanded: expanded,
              onTap: () => _toggleSection(key),
            ),
          ),
        if (expanded)
          _buildEntriesList(matches, key),
      ],
    );
  }

  // --- 5. Entries List ---

  Widget _buildEntriesList(List<DictionaryMatch> matches, String keyPrefix) {
    final profile = context.watch<SearchProfilesEntry>();
    
    return SliverList.builder(
      key: ValueKey("${keyPrefix}_List"),
      addAutomaticKeepAlives: false,
      itemCount: matches.length,
      itemBuilder: (context, i) => RepaintBoundary(
        key: ValueKey("${keyPrefix}_Item_$i"),
        child: TermEntryWidget(
          matches[i],
          showTags: profile.showTags,
          showMetaEntries: profile.showMetaEntries,
          definitionsMaxHeight: profile.definitionsMaxHeight,
          useKatakanaForFurigana: profile.useKatakanaForFurigana,
          showAudioPlaybackButtons: false,
          onTap: widget.onTap,
        ),
      ),
    );
  }
}

// --- Sticky Header Utilities ---

enum _StickyHeaderType { main, sub, tertiary }

class _StickyHeaderDelegate extends SliverPersistentHeaderDelegate {
  final String title;
  final _StickyHeaderType type;
  final bool isExpanded;
  final VoidCallback onTap;
  
  final double fontSize = 14;

  const _StickyHeaderDelegate({
    required this.title,
    required this.type,
    required this.isExpanded,
    required this.onTap,
  });

  // Ensure header is touch-friendly (min 40px) but scales with font
  double get _height => (fontSize * 2.5).clamp(25.0, 60.0).ceilToDouble();

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    final theme = Theme.of(context);

    return Material(
      color: theme.scaffoldBackgroundColor, 
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: _height,
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: fontSize,
                    color: type == _StickyHeaderType.tertiary ? theme.textTheme.bodyMedium?.color : theme.textTheme.titleMedium?.color,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 8),
              AnimatedRotation(
                turns: isExpanded ? 0.0 : -0.25,
                duration: const Duration(milliseconds: 200),
                child: Icon(
                  Icons.expand_more,
                  size: 20,
                  color: theme.disabledColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  double get maxExtent => _height;
  @override
  double get minExtent => _height;

  @override
  bool shouldRebuild(covariant _StickyHeaderDelegate old) {
    return old.title != title || old.isExpanded != isExpanded || old.type != type;
  }
}