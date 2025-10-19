/// Represents an expected search result, including the matched text.
class ExpectedSearchResult {
  final String term;
  final String reading;
  final List<String> definitions;
  /// The text that was matched (e.g., highlighted text)
  final String match;

  final List<String> termMetaTypes;

  const ExpectedSearchResult({
    required this.term,
    required this.reading,
    required this.definitions,
    required this.match,
    this.termMetaTypes = const [],
  });

  /// Formats this result with indentation.
  String toFormattedString({String indent = ''}) {
    final buffer = StringBuffer();
    // E.g., 食べる [たべる] (Matched: "食べる")
    buffer.writeln('$indent$term [$reading] (Matched: "$match")');
    
    // E.g.,   1. to eat
    for (var i = 0; i < definitions.length; i++) {
      buffer.writeln('$indent  ${i + 1}. ${definitions[i]}');
    }
    // Trim the final newline so the caller can use writeln()
    return buffer.toString().trimRight();
  }

  @override
  String toString() => toFormattedString();
}

/// A container for the expected results of a single search query form,
/// categorized by match type. This structure mirrors the `SearchMatchGroup` class.
class ExpectedMatchGroup {
  final List<ExpectedSearchResult> exactMatches;
  final List<ExpectedSearchResult> prefixMatches;
  final List<ExpectedSearchResult> tokenMatches;
  final List<ExpectedSearchResult> fuzzyMatches;
  final List<ExpectedSearchResult> wildcardMatches;

  const ExpectedMatchGroup({
    this.exactMatches = const [],
    this.prefixMatches = const [],
    this.tokenMatches = const [],
    this.fuzzyMatches = const [],
    this.wildcardMatches = const [],
  });

  bool get isEmpty =>
      exactMatches.isEmpty &&
      prefixMatches.isEmpty &&
      tokenMatches.isEmpty &&
      fuzzyMatches.isEmpty &&
      wildcardMatches.isEmpty;

  /// Formats this entire group with indentation.
  String toFormattedString({String indent = ''}) {
    final buffer = StringBuffer();
    final nextIndent = '$indent  ';

    void printSection(String title, List<ExpectedSearchResult> matches) {
      if (matches.isNotEmpty) {
        // E.g., ▶ Prefix Matches (4):
        buffer.writeln('$indent▶ $title (${matches.length}):');
        for (final match in matches) {
          buffer.writeln(match.toFormattedString(indent: nextIndent));
        }
      }
    }

    printSection('Exact Matches', exactMatches);
    printSection('Prefix Matches', prefixMatches);
    printSection('Token Matches', tokenMatches);
    printSection('Fuzzy Matches', fuzzyMatches);
    printSection('Wildcard Matches', wildcardMatches);

    // Note: Do not trim trailing newline here.
    // The top-level caller (SearchTestCase) uses write()
    // and expects a trailing newline if content exists.
    return buffer.toString();
  }

  @override
  String toString() => toFormattedString();
}

/// Defines a single, comprehensive test case that can assert against the different
/// categories of results from a `DictionaryLookupResult`.
class SearchTestCase {
  final String description;
  final String query;
  final List<String> tags;

  /// Expected results from the original, unmodified query.
  final ExpectedMatchGroup queryMatches;

  /// Expected results from the Romaji-to-Hiragana converted query.
  final List<ExpectedMatchGroup> normalizedQueryMatchGroups;

  /// Expected results from de-conjugated or other normalized query variants.
  final List<ExpectedMatchGroup> queryVariantMatches;

  const SearchTestCase({
    required this.description,
    required this.query,
    this.tags = const [],
    this.queryMatches = const ExpectedMatchGroup(),
    this.normalizedQueryMatchGroups = const [],
    this.queryVariantMatches = const [],
  });

  @override
  String toString() {
    final buffer = StringBuffer();
    const sectionIndent = '  '; // Two spaces

    // --- Header ---
    buffer.writeln('\n--- 📖 Dictionary Search Results ---');
    buffer.writeln('Search Term: $query');

    // --- 1. Original Query Matches ---
    if (!queryMatches.isEmpty) {
      buffer.writeln('\n▼ Matches for Original Query');
      // Use write(), as toFormattedString() includes its own trailing newline
      buffer.write(queryMatches.toFormattedString(indent: sectionIndent));
    }

    // --- 2. Hiragana Query Matches ---
    final nonEmptyNormalized =
        normalizedQueryMatchGroups.where((v) => !v.isEmpty).toList();
    if (nonEmptyNormalized.isNotEmpty) {
      buffer.writeln(
          '\n▼ Matches for Normalized queries (${nonEmptyNormalized.length})');
      for (var i = 0; i < nonEmptyNormalized.length; i++) {
        buffer.writeln('$sectionIndent- Variant ${i + 1}:');
        // Add extra indentation for the content of each variant
        buffer.write(
            nonEmptyNormalized[i].toFormattedString(indent: '$sectionIndent  '));
      }
    }

    // --- 3. De-conjugated / Variant Matches ---
    final nonEmptyVariants =
        queryVariantMatches.where((v) => !v.isEmpty).toList();
        
    if (nonEmptyVariants.isNotEmpty) {
      buffer.writeln(
          '\n▼ Matches for De-conjugated Variants (${nonEmptyVariants.length})');
      for (var i = 0; i < nonEmptyVariants.length; i++) {
        buffer.writeln('$sectionIndent- Variant ${i + 1}:');
        // Add extra indentation for the content of each variant
        buffer.write(
            nonEmptyVariants[i].toFormattedString(indent: '$sectionIndent  '));
      }
    }

    // --- No Matches Check ---
    if (queryMatches.isEmpty &&
        nonEmptyNormalized.isEmpty &&
        nonEmptyVariants.isEmpty) {
      buffer.writeln("\n<No matches found anywhere>");
    }
    
    // --- Tags (from original implementation, if desired) ---
    if (tags.isNotEmpty) {
      buffer.writeln('\nTags: $tags');
    }

    // --- Footer ---
    buffer.writeln('\n------------------------------------');
    return buffer.toString();
  }
}