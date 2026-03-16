// lib/src/language_transforms.dart

/// A generic rule for transforming text.
abstract class Rule<TCondition> {
  /// A regular expression to check if the rule applies to a given text.
  RegExp get isInflected;

  /// The function that performs the deinflection.
  String deinflect(String text);

  /// The conditions that the resulting (deinflected) term will have.
  List<TCondition> get conditionsIn;

  /// The conditions that the source (inflected) term must satisfy for the rule to apply.
  List<TCondition> get conditionsOut;
}

/// A rule that applies to the suffix of a word.
class SuffixRule<TCondition> implements Rule<TCondition> {
  final String inflectedSuffix;
  final String deinflectedSuffix;
  @override
  final List<TCondition> conditionsIn;
  @override
  final List<TCondition> conditionsOut;

  SuffixRule(this.inflectedSuffix, this.deinflectedSuffix, this.conditionsIn,
      this.conditionsOut);

  @override
  late final RegExp isInflected = RegExp('$inflectedSuffix\$');

  @override
  String deinflect(String text) {
    if (text.length < inflectedSuffix.length) {
      return text; // Should not happen if isInflected matches
    }
    return '${text.substring(0, text.length - inflectedSuffix.length)}$deinflectedSuffix';
  }
}

/// A rule that applies to the prefix of a word.
class PrefixRule<TCondition> implements Rule<TCondition> {
  final String inflectedPrefix;
  final String deinflectedPrefix;
  @override
  final List<TCondition> conditionsIn;
  @override
  final List<TCondition> conditionsOut;

  PrefixRule(this.inflectedPrefix, this.deinflectedPrefix, this.conditionsIn,
      this.conditionsOut);

  @override
  late final RegExp isInflected = RegExp('^$inflectedPrefix');

  @override
  String deinflect(String text) {
    if (text.length < inflectedPrefix.length) {
      return text;
    }
    return '$deinflectedPrefix${text.substring(inflectedPrefix.length)}';
  }
}

/// A rule that applies to the entire word.
class WholeWordRule<TCondition> implements Rule<TCondition> {
  final String inflectedWord;
  final String deinflectedWord;
  @override
  final List<TCondition> conditionsIn;
  @override
  final List<TCondition> conditionsOut;

  WholeWordRule(this.inflectedWord, this.deinflectedWord, this.conditionsIn,
      this.conditionsOut);

  @override
  late final RegExp isInflected = RegExp('^$inflectedWord\$');

  @override
  String deinflect(String text) => deinflectedWord;
}

/// Factory function to create a [SuffixRule].
SuffixRule<TCondition> suffixInflection<TCondition>(
  String inflectedSuffix,
  String deinflectedSuffix,
  List<TCondition> conditionsIn,
  List<TCondition> conditionsOut,
) {
  return SuffixRule(
      inflectedSuffix, deinflectedSuffix, conditionsIn, conditionsOut);
}

/// Factory function to create a [PrefixRule].
PrefixRule<TCondition> prefixInflection<TCondition>(
  String inflectedPrefix,
  String deinflectedPrefix,
  List<TCondition> conditionsIn,
  List<TCondition> conditionsOut,
) {
  return PrefixRule(
      inflectedPrefix, deinflectedPrefix, conditionsIn, conditionsOut);
}

/// Factory function to create a [WholeWordRule].
WholeWordRule<TCondition> wholeWordInflection<TCondition>(
  String inflectedWord,
  String deinflectedWord,
  List<TCondition> conditionsIn,
  List<TCondition> conditionsOut,
) {
  return WholeWordRule(
      inflectedWord, deinflectedWord, conditionsIn, conditionsOut);
}