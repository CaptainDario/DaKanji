// This list should contain the search term that corresponds to the expectations above.
import 'package:dakanji_db_core/database/term/term_bank_v3_entry.dart';

final termBankTestCases2 = [
  '発条',
];

final termBankTestCaseExpectations2 = [
  // Test case for "発条"
  [
    TermBankV3Entry(
      term: '発条',
      reading: 'ばね',
      definitionTags: [],
      ruleIdentifiers: [],
      popularity: 0,
      definitions: [
        'spring',
        'spring (in one\'s legs); bounce',
        'springboard; impetus',
      ],
      sequenceNumber: 1099490,
      tags: [],
    ),
  ],
];