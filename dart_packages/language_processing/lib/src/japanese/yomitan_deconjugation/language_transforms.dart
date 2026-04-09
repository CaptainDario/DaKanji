// lib/src/japanese/yomitan_deconjugation/language_transforms.dart

/// Represents a generic morphological rule.
abstract class InflectionPattern<TFlag> {
  /// The regex used to identify if this pattern *might* apply.
  RegExp get matchPattern;

  /// Modifies the string to its previous state.
  String revert(String surfaceForm);

  /// The flags the current term must have (corresponds to Yomitan's conditionsIn)
  List<TFlag> get expectedFlags;

  /// The flags assigned to the resulting term (corresponds to Yomitan's conditionsOut)
  List<TFlag> get nextFlags;
}

/// Handles modifications at the end of a string.
class SuffixModification<TFlag> implements InflectionPattern<TFlag> {
  final String _inflected;
  final String _base;
  
  @override
  final List<TFlag> expectedFlags;
  
  @override
  final List<TFlag> nextFlags;

  SuffixModification(this._inflected, this._base, this.expectedFlags, this.nextFlags);

  @override
  late final RegExp matchPattern = RegExp('$_inflected\$');

  @override
  String revert(String surfaceForm) {
    if (!surfaceForm.endsWith(_inflected)) return surfaceForm;
    return surfaceForm.substring(0, surfaceForm.length - _inflected.length) + _base;
  }
}

/// Handles modifications at the beginning of a string.
class PrefixModification<TFlag> implements InflectionPattern<TFlag> {
  final String _inflected;
  final String _base;
  
  @override
  final List<TFlag> expectedFlags;
  
  @override
  final List<TFlag> nextFlags;

  PrefixModification(this._inflected, this._base, this.expectedFlags, this.nextFlags);

  @override
  late final RegExp matchPattern = RegExp('^$_inflected');

  @override
  String revert(String surfaceForm) {
    if (!surfaceForm.startsWith(_inflected)) return surfaceForm;
    return _base + surfaceForm.substring(_inflected.length);
  }
}

/// Handles total replacements of strings.
class ExactMatchModification<TFlag> implements InflectionPattern<TFlag> {
  final String _inflected;
  final String _base;
  
  @override
  final List<TFlag> expectedFlags;
  
  @override
  final List<TFlag> nextFlags;

  ExactMatchModification(this._inflected, this._base, this.expectedFlags, this.nextFlags);

  @override
  late final RegExp matchPattern = RegExp('^$_inflected\$');

  @override
  String revert(String surfaceForm) => _base;
}

// Factory adapters to keep compatibility with `japanese_transforms.dart`
// Notice how conditionsIn maps to expectedFlags, and conditionsOut maps to nextFlags.

SuffixModification<T> suffixInflection<T>(
  String inflected, String base, List<T> conditionsIn, List<T> conditionsOut
) => SuffixModification(inflected, base, conditionsIn, conditionsOut);

PrefixModification<T> prefixInflection<T>(
  String inflected, String base, List<T> conditionsIn, List<T> conditionsOut
) => PrefixModification(inflected, base, conditionsIn, conditionsOut);

ExactMatchModification<T> wholeWordInflection<T>(
  String inflected, String base, List<T> conditionsIn, List<T> conditionsOut
) => ExactMatchModification(inflected, base, conditionsIn, conditionsOut);