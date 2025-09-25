import 'package:collection/collection.dart';
import 'package:dakanji_db_core/database/term/term_bank_v3_entry.dart';
import 'package:test/test.dart';

// Your TermBankV3Entry class import goes here
// import 'package:dakanji_db_core/database/term/term_bank_v3_entry.dart';

/// A helper function that makes the matcher easier to use.
Matcher matchesTermBankEntry(TermBankV3Entry expected) =>
    _TermBankV3EntryMatcher(expected);

/// The custom matcher class.
class _TermBankV3EntryMatcher extends Matcher {
  final TermBankV3Entry expected;
  const _TermBankV3EntryMatcher(this.expected);

  @override
  bool matches(dynamic item, Map matchState) {
    if (item is! TermBankV3Entry) return false;

    // Use DeepCollectionEquality for robust list comparison
    const equality = DeepCollectionEquality();

    // Check if all properties are equal
    return item.term == expected.term &&
        item.reading == expected.reading &&
        equality.equals(item.definitionTags, expected.definitionTags) &&
        equality.equals(item.ruleIdentifiers, expected.ruleIdentifiers) &&
        item.popularity == expected.popularity &&
        equality.equals(item.definitions, expected.definitions) &&
        item.sequenceNumber == expected.sequenceNumber &&
        equality.equals(item.tags, expected.tags);
  }

  @override
  Description describe(Description description) =>
      description.add('a TermBankV3Entry that matches ${expected.term}');

@override
Description describeMismatch(
  dynamic item,
  Description mismatchDescription,
  Map matchState,
  bool verbose,
) {
  if (item is! TermBankV3Entry) {
    return mismatchDescription.add('is not a TermBankV3Entry');
  }

  mismatchDescription.add('has the following mismatches:\n');
  const equality = DeepCollectionEquality();

  // --- START: UPGRADED MISMATCH LOGIC FOR LISTS ---

  // Check the definitions list specifically for a diff-like output
  if (!equality.equals(item.definitions, expected.definitions)) {
    mismatchDescription.add('  - definitions list did not match:\n');
    // Find the first differing item to make the error more specific
    for (var i = 0; i < expected.definitions.length; i++) {
      if (i >= item.definitions.length) {
        mismatchDescription.add('    - Actual list is shorter. Missing item at index $i: "${expected.definitions[i]}"\n');
        break;
      }
      if (item.definitions[i] != expected.definitions[i]) {
        mismatchDescription
            .add('    - Difference at index $i:\n')
            .add('      - Expected: "${expected.definitions[i]}"\n')
            .add('      -   Actual: "${item.definitions[i]}"\n');
        // Stop after the first difference to keep the output clean
        break; 
      }
    }
    if (item.definitions.length > expected.definitions.length) {
        mismatchDescription.add('    - Actual list is longer. Extra item at index ${expected.definitions.length}: "${item.definitions[expected.definitions.length]}"\n');
    }
  }

  // --- END: UPGRADED MISMATCH LOGIC FOR LISTS ---

  // You can keep checks for other simple fields if you like
  if (item.term != expected.term) {
    mismatchDescription.add(
        "  - term: expected '${expected.term}' but got '${item.term}'\n");
  }

  return mismatchDescription;
}
}