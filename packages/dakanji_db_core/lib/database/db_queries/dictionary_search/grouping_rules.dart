/// Base class for grouping rules
abstract class DictionaryGroupingRule {

  const DictionaryGroupingRule();

  /// Which dictionaries this rule applies to
  Set<int> get dictionaryIds;
}

/// Rule for Sequence-based grouping
class SequenceGroupingRule extends DictionaryGroupingRule {

  /// The dictionary from which sequence numbers are taken.
  final int primaryDictId;
  /// The dictionaries in which to search for entries matching the sequence
  /// numbers from [primaryDictId].
  final Set<int> secondaryDictIds;

  SequenceGroupingRule({required this.primaryDictId, required this.secondaryDictIds});

  @override
  Set<int> get dictionaryIds => {primaryDictId, ...secondaryDictIds};
}

/// Rule for Term+Reading grouping
class TermAndReadingGroupingRule extends DictionaryGroupingRule {

  /// The dictionaries in which to search for matching entries 
  final Set<int> targetDictIds;

  TermAndReadingGroupingRule(this.targetDictIds);

  @override
  Set<int> get dictionaryIds => targetDictIds;
}

/// Rule for Term grouping
class TermGroupingRule extends DictionaryGroupingRule {

  /// The dictionaries in which to search for matching entries
  final Set<int> targetDictIds;

  TermGroupingRule(this.targetDictIds);

  @override
  Set<int> get dictionaryIds => targetDictIds;
}

/// Shorthand class for no grouping
class NoGroupingRule extends DictionaryGroupingRule {

  const NoGroupingRule();

  @override
  Set<int> get dictionaryIds => {};
}